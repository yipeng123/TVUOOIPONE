#ifndef TVU_DEVICE
#define TVU_DEVICE

#ifndef MAX_TCP_CONN
#define MAX_TCP_CONN  10
#endif

#ifndef MAX_UDP_SEND
#define MAX_UDP_SEND  5
#endif


 const unsigned short PORTS[] = {29527,40984,23481,46321,37633};

#ifndef PORT_COUNT
#define PORT_COUNT (sizeof(PORTS)/sizeof(PORTS[0]))
#endif

#include "TVUChannel.h"
#include "TVUFirewall.h"
//#include "cocos2d.h"
//using namespace cocos2d;
enum device_status
{
	TVU_STOP,
	TVU_CHECKINGPORT,
	TVU_WAITINGPEERDEVICE,
	TVU_WORKING
};

//2.IP是否放在channel,问题在UDP收时IP会变化，方案2是检测TCP收包时是否能填入对端IP，放进package,这时检测到close时要建一个close包
//
class TVUDevice
{
public:
	TVUDevice();
	//通讯握手：电视openservice以后，发送广播包，等待对端连接
	//手机openservice以后，等待广播包，连接到电视TCP端口，并告知自身服务端口号，设备名
//	virtual int handshake()=0;
	virtual int run() = 0;
	 unsigned short getEventPort();
	 int getWorkingStatus();
	//发包接口
	 int sendUdpEnvent(TVUPackage* package,int peerPort);

	    int sendPackageWithAll(TVUPackage* package);
protected:
    
    int opendUdpEventChannel();
    void stopUdpEventChannel();
	 int openPort(unsigned short port,int protocal);
	 int processChannelData(TVUChannel* channel,int type);
//	virtual int dispachPackage(TVUPackage* package)=0;
protected:
	unsigned short m_eventPort;
	
	TVUChannel* m_pUdpEventChannel;
    int maxFd;
    
	int m_workingStatus;
	
	TVUFirewall * m_pFirewall;
	
	
};
#endif
