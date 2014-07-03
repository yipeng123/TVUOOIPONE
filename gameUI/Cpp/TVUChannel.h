#ifndef TVU_CHANNEL
#define TVU_CHANNEL

#include <sys/select.h>
#include <sys/socket.h>
#include<pthread.h>
#include <netinet/in.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>
#include <time.h>

#include <sys/wait.h>
#include <errno.h>
#include <time.h>
#include <fcntl.h>
#include <arpa/inet.h>

#include "TVUFirewall.h"
#include "TVUPackage.h"


#define LOGI(...) ((void)__android_log_print(ANDROID_LOG_INFO, "native-activity", __VA_ARGS__))
#define LOGW(...) ((void)__android_log_print(ANDROID_LOG_WARN, "native-activity", __VA_ARGS__))
#define LOGE(...) ((void)__android_log_print(ANDROID_LOG_ERROR, "native-activity", __VA_ARGS__))
//using namespace cocos2d;
#ifndef TVU_BUF_SIZE
#define TVU_BUF_SIZE	8192
#endif

#define TVU_ERROR_FORBIDDEN -2
#define TVU_ERROR_CLOSE		0
#define TVU_HEART_TIMEOUT 10

struct NetPacketHeader
{
    unsigned short      wDataSize;  ///< 数据包大小，包含封包头和封包数据大小
};

class TVUChannel
{
public:
	TVUChannel(int fd,int port,int ip);
    
	~TVUChannel();
	int getFd();
    void closeFD();
    unsigned int getIp();
     int getPort();
//    void setIp(char* ip);
	int recvPackage(int type);
    int recvImgPackage();
    int recvUdpPackage();
	int sendTcpPackage(TVUPackage* package);
	    int sendUdpPackage(TVUPackage* package,int peerPort);

	    void updateActTime();

	       long getCheckActTime();
	     void updateSendActTime();
	     long getCheckSendActTime();
//	TVUPackage* recvPackage(int &flag);
    void setFirewall(TVUFirewall* firewall);
protected:
	int sendData(const char* buf,int dataLen,sockaddr_in &peerAddr);
	int readData(unsigned char* buf,int bufLen,sockaddr_in &peerAddr);
protected:
	unsigned char * m_readBuf;
	unsigned char *m_readUdpBuf;
	int m_fd;
	int m_port;
	int m_readLen;
    unsigned int m_ip;
	TVUFirewall * m_pFirewall;
    long actTime;
    long sendActTime;
    int remain;
	pthread_mutex_t m_mutex;
}; 
#endif
