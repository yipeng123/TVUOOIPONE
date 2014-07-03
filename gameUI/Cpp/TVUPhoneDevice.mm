#include "TVUPhoneDevice.h"
#include "TVUClient.h"
TVUPhoneDevice::TVUPhoneDevice() {

	m_eventPort = 0;
	m_imgPort = 0;

	m_pUdpEventChannel = NULL;
	m_pUdpImageChannel = NULL;
	//	TVUChannel* m_pTcpChannels[MAX_TCP_CONN];

	m_workingStatus = TVU_STOP;

	m_pFirewall = NULL;

	client = NULL;

}

unsigned short TVUPhoneDevice::getImgPort() {
	return m_imgPort;
}

void TVUPhoneDevice::stopService() {
	stopUdpEventChannel();
	if (m_pUdpImageChannel != NULL) {
		delete m_pUdpImageChannel;
	}
	m_pUdpImageChannel = NULL;
	//重置工作状态为停止状态
	m_workingStatus = TVU_STOP;
}

void TVUPhoneDevice::stopClient() {
	//关闭所有TCP连接
	if (client != NULL && client->getChannel() != NULL) {
		delete client;
		client = NULL;
	}
}

int TVUPhoneDevice::openService() {
	stopService();
	if (opendUdpEventChannel() < 0) {
		return -1;
	}
	int fd = 0;
	//置工作状态为端口检查
	int portIdx = 0;
//    NSLog(@"udp接收创建成功");
	//初始化UDP图片通道
	for (portIdx = 0; portIdx < IMG_PORT_COUNT; portIdx++) {
		if ((fd = openPort(IMG_PORTS[portIdx], SOCK_DGRAM)) > 0) {
			m_imgPort = IMG_PORTS[portIdx];
			m_pUdpImageChannel = new TVUChannel(fd, m_imgPort, 0);
			break;
		}
	}
	if (m_pUdpImageChannel == NULL) {
		//未能打开图片通道，同屏功能失效

//        CCLog("udp图片接收创建失败");
	}
	TVUPackage *package = new TVUPackage(TVU_INIT_TV_UDP);
	package->addData(TVU_PACKAGE_MAPNAME_E, "0");
	package->addData(TVU_PACKAGE_MAPNAME_TAG, "TVUOO");
	package->setPeerIP("255.255.255.255");

	char buf[16];
	sprintf(buf,"%d",m_eventPort);
	package->addData(TVU_PACKAGE_MAPNAME_UDPPORT, buf);
	sprintf(buf,"%d",UDP_PHONE);
	package->addData(TVU_PACKAGE_UDP_TYPE,buf);
	sendPackageWithAll(package);
	delete package;
	m_workingStatus = TVU_WAITINGPEERDEVICE;
	return 1;
}

int TVUPhoneDevice::resetFdSet(fd_set &fds) {

	FD_ZERO(&fds);
	//    FD_ZERO(fds);
	maxFd = 0;
	if (m_pUdpEventChannel != NULL && m_pUdpEventChannel->getFd() > 0) {
		FD_SET(m_pUdpEventChannel->getFd(), &fds);
		maxFd = maxFd < m_pUdpEventChannel->getFd() ?
				m_pUdpEventChannel->getFd() : maxFd;
	}
	if (m_pUdpImageChannel != NULL && m_pUdpImageChannel->getFd() > 0) {
		FD_SET(m_pUdpImageChannel->getFd(), &fds);
		maxFd = maxFd < m_pUdpImageChannel->getFd() ?
				m_pUdpImageChannel->getFd() : maxFd;
	}

	if (client != NULL && client->getChannel() != NULL
			&& client->getChannel()->getFd() > 0) {
		FD_SET(client->getChannel()->getFd(), &fds);
		maxFd = maxFd < client->getChannel()->getFd() ?
				client->getChannel()->getFd() : maxFd;
	}
	return maxFd;
}

//客户端连接TV
int TVUPhoneDevice::connectServer(int ip, unsigned short port, int protocal) {
	client = new TVUClient(ip, port, protocal);
//	LOGE("TVUPhoneDevice::connectServer");
	int flag = client->connectServer();
	if (flag > 0)
    {
		fd_set fdsr;
		resetFdSet(fdsr);
	} else
    {
        return -1;
	}
	return 1;
}

//TCP服务端采用多路IO技术来读取数据
//后续测试如多路IO性能差，则改造为线程模式
int TVUPhoneDevice::run() {
	if (m_workingStatus != TVU_WAITINGPEERDEVICE) {
		stopService();
		openService();
	}
	if (m_workingStatus != TVU_WAITINGPEERDEVICE) {
		//初始化失败，通知应用层处理
		return -1;
	}
//	LOGE("run");
	struct sockaddr_in client_addr;
	fd_set fdsr;
	struct timeval tv;
	socklen_t sin_size = sizeof(client_addr);
	int ret = 0;
	// 初始化 file descriptor set，如调试出现异常，将FD_ZERO及FD_SET放入循环体内
	int maxsock = resetFdSet(fdsr);

	int clientFd = 0;
	int i = 0;
	int readFlag = 0;
	isWhile = true;
	while (1) {
		// timeout setting
		tv.tv_sec = 5;
		tv.tv_usec = 0;

		maxsock = resetFdSet(fdsr);
		ret = select(maxsock + 1, &fdsr, NULL, NULL, &tv);
		if (ret < 0) {
			//			cout<<"select error..."<<endl<<"error no:"<<errorno<<endl;
			break;
		} else if (ret == 0) {
			//timeout
			continue;
		}
		//优处理TCP客户端数据
		if (client != NULL && client->getChannel() != NULL
				&& FD_ISSET((clientFd = client->getChannel()->getFd()),
						&fdsr)) {
			int flag = processChannelData(client->getChannel(), TCP_PACKAGE);
//			LOGE("flag = %d",);
			if (flag <= 0) {
				//客户端连接关闭,此时应该通知应用层，对端设备情况发生了变化
				//notifyUI(ip,FLAG_CLOSE);
				delete client;
				client = NULL;
//                    client->closeClient();
			}
		}

		//然后处理UDP事件
		if (m_pUdpEventChannel != NULL && FD_ISSET((clientFd =
				m_pUdpEventChannel->getFd()), &fdsr)) {
			int flag = processChannelData(m_pUdpEventChannel, UDP_PACKAGE);
			if (flag == TVU_ERROR_CLOSE) {
				//UDP是否会对端关闭连接？理论上不会，需要验证对端close时本侧是否收到关闭通知，如无，则本代码块删除
				//如有，则视为连接中断，需要重连
				stopService();
				return -1;
			}
		}
		//最后处理UDP图片
		if (m_pUdpImageChannel != NULL && FD_ISSET((clientFd =
				m_pUdpImageChannel->getFd()), &fdsr)) {
			int flag = processChannelData(m_pUdpImageChannel, IMG_PACKAGE);
			if (flag == TVU_ERROR_CLOSE) {
				//UDP是否会对端关闭连接？理论上不会，需要验证对端close时本侧是否收到关闭通知，如无，则本代码块删除
				//如有，则视为图片连接中断，同屏功能终止
				delete m_pUdpImageChannel;
				m_pUdpImageChannel = NULL;
				// maxsock = resetFdSet(fdsr);
			}
		}

	}
}

int TVUPhoneDevice::sendTcpEvent(TVUPackage *package) {
	if (client != NULL && client->getChannel() != NULL
			&& client->getChannel()->getFd() > 0) {
		client->getChannel()->sendTcpPackage(package);
		return 1;
	}
	return 0;
}

int TVUPhoneDevice::checkHeartTime() {
	if (client != NULL && client->getChannel() != NULL
			&& client->getChannel()->getFd() > 0) {
		return client->getChannel()->getCheckActTime();
	}
	return -1;
}

void TVUPhoneDevice::sendHeartPackage(TVUPackage *package) {
	if (client != NULL && client->getChannel() != NULL
			&& client->getChannel()->getFd() > 0) {
//		LOGE("time = %d",client->getChannel()->getCheckSendActTime());
		if(client->getChannel()->getCheckSendActTime()
								>= (TVU_HEART_TIMEOUT / 5)){
			in_addr addr;
			addr.s_addr = client->getChannel()->getIp();
			char* ip = inet_ntoa(addr);
//			LOGE("sendHeartPackage ip = %s", ip);
			package->setPeerIP(ip);
			client->getChannel()->sendTcpPackage(package);
		}
	}
}
int TVUPhoneDevice::getPeerIp(){
	if (client != NULL && client->getChannel() != NULL
			&& client->getChannel()->getFd() > 0) {
		client->getChannel()->getIp();
	}
}
