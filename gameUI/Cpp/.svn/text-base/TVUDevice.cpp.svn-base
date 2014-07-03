#include "TVUDevice.h"
TVUDevice::TVUDevice()
{

	m_eventPort = 0;
	m_pUdpEventChannel = NULL;
	m_workingStatus = TVU_STOP;
	
	m_pFirewall = NULL;
}

int TVUDevice::getWorkingStatus()
{
	return m_workingStatus;
}
unsigned short TVUDevice::getEventPort(){
    return m_eventPort;
}

void TVUDevice::stopUdpEventChannel(){
    if(m_pUdpEventChannel!=NULL){
        delete m_pUdpEventChannel;
    }
    m_pUdpEventChannel = NULL;
    m_workingStatus = TVU_STOP;
}

int TVUDevice::opendUdpEventChannel()
{
	int fd = 0;
	//置工作状态为端口检查
	m_workingStatus = TVU_CHECKINGPORT;
	int portIdx = 0;
		//TCP绑定OK，UDP绑定失败，理论上不会出现这种情况
		for(portIdx=0;portIdx<PORT_COUNT;portIdx++)
		{
			if((fd=openPort(PORTS[portIdx], SOCK_DGRAM))>0)
			{
                int on = 1;
                setsockopt(fd, SOL_SOCKET, SO_REUSEADDR | SO_BROADCAST, &on,
                           sizeof(on));
				m_eventPort = PORTS[portIdx];
				m_pUdpEventChannel = new TVUChannel(fd,m_eventPort,0);
                break;
			}
		}
//	}
	if(m_pUdpEventChannel==NULL)
	{
		//未能打开UDP事件通道，初始化失败,需要通知应用层处理
		stopUdpEventChannel();
		return -1;
	}
//	LOGE("opendUdpEventChannel sucess");
    return 1;
}

int TVUDevice::openPort(unsigned short port,int protocal)
{
    
	struct sockaddr_in addr;
	bzero(&addr, sizeof(struct sockaddr_in));
	addr.sin_family = AF_INET;
	addr.sin_addr.s_addr = htonl(INADDR_ANY);
	addr.sin_port = htons(port);
	
	int sock = -1;
	if ((sock = socket(AF_INET, protocal, 0)) == -1)
	{
//		cout<<"socket error..."<<endl<<"error no:"<<errorno<<endl;
//        CCLOG("socket error");
		return -1;
	}
	
	if(bind(sock,(struct sockaddr *)&(addr), sizeof(struct sockaddr_in)) == -1)
	{
		close(sock);
//		cout<<"bind error..."<<endl<<"error no:"<<errorno<<endl;
//        CCLOG("bind error");

		return -1;
	}
	
	return sock;
}

int TVUDevice::processChannelData(TVUChannel* channel,int type)
{
//    CCLog("processChannelData");
	int readFlag = 0;
    if (type==UDP_PACKAGE) {
        channel->recvUdpPackage();
        readFlag = 1;
    }else if(type==TCP_PACKAGE){
        readFlag = channel->recvPackage(readFlag);
    }else if(type==IMG_PACKAGE){
        channel->recvImgPackage();
        readFlag =1;
    }
	//处理数据包
//	if(pPackage!=NULL)
//	{
//		//通知应用层处理相应事件
//		dispachPackage(pPackage);
//	}
//	delete pPackage;//是否在这里回收取决于处理事件机制，如dispatch是阻塞的或非阻塞但不用到pPackage的内存变量，则可在这里回收
	return readFlag;
}

int TVUDevice::sendUdpEnvent(TVUPackage* package,int peerPort)
{
    return m_pUdpEventChannel->sendUdpPackage(package,peerPort);
}

int TVUDevice::sendPackageWithAll(TVUPackage *package){
    for (int i = 0; i < PORT_COUNT; i++) {
		if (m_pUdpEventChannel != NULL) {
			m_pUdpEventChannel->sendUdpPackage(package, PORTS[i]);
		}
	}
	return 1;
}
                                             
