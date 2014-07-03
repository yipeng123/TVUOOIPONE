//
//  TVUPhoneDevice.h
//  TestTvServer
//
//  Created by bug on 14-3-24.
//
//

#ifndef __TestTvServer__TVUPhoneDevice__
#define __TestTvServer__TVUPhoneDevice__

const unsigned short IMG_PORTS[] = {33334,44343,45352};

#ifndef IMG_PORT_COUNT
#define IMG_PORT_COUNT (sizeof(IMG_PORTS)/sizeof(IMG_PORTS[0]))
#endif


#include "TVUDevice.h"
#include "TVUClient.h"

class TVUPhoneDevice:public TVUDevice
{
public:
	TVUPhoneDevice();
	int openService();
    void stopClient();
	int run();
	unsigned short getImgPort();
	//发包接口
	int sendUdpImage(TVUPackage* package);
    int sendTcpEvent(TVUPackage* package);
    int checkHeartTime();
    void sendHeartPackage(TVUPackage* package);
    int connectServer(int ip,unsigned short port,int protocal);
    int getPeerIp();
protected:
	int resetFdSet(fd_set &fds);
protected:
    unsigned short m_imgPort;
    TVUClient *client;
	TVUChannel* m_pUdpImageChannel;
    bool isWhile;
private:
    void stopService();
};
#endif /* defined(__TestTvServer__TVUPhoneDevice__) */
