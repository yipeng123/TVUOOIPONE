#include "TVUChannel.h"
#include "MyJniTransport.h"

TVUChannel::TVUChannel(int fd, int port, int ip) {

	pthread_mutex_init(&m_mutex,NULL);
	m_fd = fd;
	m_port = port;
	m_readBuf = (unsigned char*) (malloc(TVU_BUF_SIZE));
	bzero(m_readBuf, TVU_BUF_SIZE);

	m_readUdpBuf = (unsigned char*) (malloc(TVU_BUF_SIZE));
	bzero(m_readUdpBuf, TVU_BUF_SIZE);
	m_readLen = 0;
	m_ip = ip;
	time_t t;
	time(&t);
	actTime = t;
	sendActTime = t;
	remain = 0;
}

TVUChannel::~TVUChannel() {
	closeFD();
	free(m_readBuf);
	free(m_readUdpBuf);
	pthread_mutex_destroy(&m_mutex);
}
void TVUChannel::closeFD() {
	if (m_fd < 1) {
		return;
	}
	close(m_fd);
	m_fd = -1;
}

int TVUChannel::getFd() {
	return m_fd;
}

int TVUChannel::getPort() {
	return m_port;
}

//阻塞模式与非阻塞模式下recv的返回值各代表什么意思？有没有区别？
//（就我目前了解阻塞与非阻塞recv返回值没有区分，都是 <0：出错，=0：连接关闭，>0接收到数据大小，特别：返回值 <0时并且(errno == EINTR || errno == EWOULDBLOCK || errno == EAGAIN)的情况下认为连接是正常的，继续接收。
//只是阻塞模式下recv会阻塞着接收数据，非阻塞模式下如果没有数据会返回，不会阻塞着读，因此需要 循环读取
//读包后如返回null，需检测flag是否为关闭
int TVUChannel::recvPackage(int type) {
//	LOGE("recvPackage");
	sockaddr_in addr;
	addr.sin_family = AF_INET;
	addr.sin_port = htons(m_port);
	addr.sin_addr.s_addr = htonl(INADDR_ANY);
//	static int m_count = 0;

	int len = readData(m_readBuf + remain, TVU_BUF_SIZE - remain, addr);
	if (len == TVU_ERROR_CLOSE) {
//		LOGE("recv len =%d||errno = %d", len,errno);
		return len;
	} else if (len < 0) {
		//连接关闭？？重连机制？？可以考虑抛异常，由ConnectorManager去重连
//		LOGE("recv errno =%d", errno);
		return len;
	}
	TVUPackage* package;
	int dataLen = 0;
	int begin = 0;
	int bytes = remain + len;
//	LOGE("readBuf = %s", m_readBuf);

	while (begin<bytes&&(package = TVUPackage::decode(m_readBuf + begin, bytes - begin,
			remain, dataLen)) != NULL) {
		//处理包
		setData(package, m_ip);
//		delete package;
		begin += dataLen;
	}
	if(remain>3000){
		remain = 0;
	}else if (remain > 0) {
		memmove(m_readBuf, m_readBuf + bytes-remain, remain);
		bzero(m_readBuf+remain,TVU_BUF_SIZE-remain);
	} else {
		bzero(m_readBuf,TVU_BUF_SIZE);
	}
	if(remain>31){
		m_readBuf[begin+remain] = 0;
//		LOGE("tcp rev buf  = %s",m_readBuf+begin);
	}
	updateActTime();
	return len;
}

int TVUChannel::recvImgPackage() {

	sockaddr_in addr;
	addr.sin_family = AF_INET;
	addr.sin_port = htons(m_port);
	addr.sin_addr.s_addr = htonl(INADDR_ANY);
	int len = readData(m_readUdpBuf, TVU_BUF_SIZE, addr);
	TVUPackage* package = TVUPackage::decodeWithUdp(m_readUdpBuf, TVU_BUF_SIZE);
//	setData(package, addr.sin_addr.s_addr);
	bzero(m_readUdpBuf, TVU_BUF_SIZE);

}

int TVUChannel::recvUdpPackage() {
	sockaddr_in addr;
	addr.sin_family = AF_INET;
	addr.sin_port = htons(m_port);
	addr.sin_addr.s_addr = htonl(INADDR_ANY);
	int len = readData(m_readUdpBuf, TVU_BUF_SIZE, addr);

	if(len<1||len>=TVU_BUF_SIZE){
		return len;
	}
	m_readUdpBuf[len] = 0;
//	LOGE("rec udp package");
	TVUPackage* package = TVUPackage::decodeWithUdp(m_readUdpBuf, len);
	if(package!=NULL){
//		delete package;
		setData(package, addr.sin_addr.s_addr);
	}
//	bzero(m_readUdpBuf, TVU_BUF_SIZE);

}

//阻塞模式与非阻塞模式下write的返回值各代表什么意思？有没有区别？
//阻塞与非阻塞write返回值没有区分，都是 <0：出错，=0：连接关闭，>0发送数据大小，特别：返回值 <0时并且(errno == EINTR || errno == EWOULDBLOCK || errno == EAGAIN)的情况下认为连接是正常的，继续发送。
//只是阻塞模式下write会阻塞着发送数据，非阻塞模式下如果暂时无法发送数据会返回，不会阻塞着 write，因此需要循环发送
int TVUChannel::sendTcpPackage(TVUPackage* package) {
	if(package==NULL){
		return 1;
	}
	int len = 0;
	int total = 0;
	sockaddr_in addr;
	addr.sin_family = AF_INET;
	addr.sin_port = htons(m_port);
	//将目标IP填入,该动作对TCP无效
	//测试下是否要进行htonl()转换
	addr.sin_addr.s_addr = package->getPeerIp();
	string pInfo = package->toJson();
		int packageLen = pInfo.length();
//		time_t t;
//			time(&t);
		len = sendData(pInfo.c_str(), packageLen, addr);
//		time_t t1;
//			time(&t1);
//			LOGE("send time = %d",t1-t);
	if (len > 0) {
		updateSendActTime();
	} else if (len == TVU_ERROR_CLOSE) {
		//连接关闭？？重连机制？？由ConnectorManager去重连?
//		LOGE(" send len = 0||errno = %d",errno);
		return TVU_ERROR_CLOSE;
	} else if (len < 0 && errno != EINTR && errno != EWOULDBLOCK
			&& errno != EAGAIN) {
		//连接关闭？？重连机制？？由ConnectorManager去重连?
//		LOGE(" send len <0||errno = %d",errno);
		return len;
	}
//	}
	return total;
}

int TVUChannel::sendUdpPackage(TVUPackage *package, int peerPort) {
	if(package==NULL){
			return 1;
	}
	int len = 0;
	int total = 0;
	sockaddr_in addr;
	addr.sin_family = AF_INET;
	addr.sin_port = htons(peerPort);
	//将目标IP填入,该动作对TCP无效
	//测试下是否要进行htonl()转换
	addr.sin_addr.s_addr = package->getPeerIp();
	string pInfo = package->toJson();
	int packageLen = pInfo.length();
	len = sendData(pInfo.c_str(), packageLen, addr);
	if (len > 0) {
		//发送成功

	} else if (len == TVU_ERROR_CLOSE) {
		//发送失败
//		LOGE("发送失败= %d ||errno = %d", len, errno);
//		break;
	} else if (len < 0 && errno != EINTR && errno != EWOULDBLOCK
			&& errno != EAGAIN) {
		//发送失败
//		LOGE("发送失败= %d", errno);
	}
	return len;
}

//TCP发送时，忽略peerAddr（可不赋值），UDP时，需填入对端IP
int TVUChannel::sendData(const char* buf, int dataLen, sockaddr_in &peerAddr) {
	if (m_fd < 1) {
		return m_fd;
	}
	pthread_mutex_lock(&m_mutex);
	//看看flag的含义是什么
	 int len = sendto(m_fd, (void*)buf, dataLen, 0, (struct sockaddr *) &peerAddr,
			sizeof(peerAddr));
	pthread_mutex_unlock(&m_mutex);
	return len;
}

int TVUChannel::readData(unsigned char* buf, int bufLen,
		sockaddr_in &peerAddr) {
	if (m_fd < 1) {
		return m_fd;
	}
    
    //addr_len 必须为unsigned int 类型
	unsigned int addr_len = sizeof(struct sockaddr_in);
	int len = recvfrom(m_fd, (void *) buf, bufLen, 0,
			(struct sockaddr *) &peerAddr, &addr_len);
//	if(m_pFirewall!=NULL && !m_pFirewall->allowIp(inet_ntoa(peerAddr.sin_addr)))
//	{
//		len = TVU_ERROR_FORBIDDEN;
//		errno = EAGAIN;
//	}
	return len;
}

void TVUChannel::setFirewall(TVUFirewall* firewall) {
	m_pFirewall = firewall;
}

unsigned int TVUChannel::getIp() {
	return m_ip;
}

void TVUChannel::updateActTime() {
	time_t t;
	time(&t);
	actTime = t;
}

long TVUChannel::getCheckActTime() {
	time_t t;
	time(&t);
	return t - actTime;
}
void TVUChannel::updateSendActTime() {
	time_t t;
	time(&t);
	sendActTime = t;
}

long TVUChannel::getCheckSendActTime() {
	time_t t;
	time(&t);
	return t - sendActTime;
}

