#ifndef TVU_CLIENT
#define TVU_CLIENT
#include "TVUChannel.h"

#include <sys/types.h>
#include <sys/socket.h>
#include<pthread.h>
#include <netinet/in.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>

#include <sys/wait.h>
#include <errno.h>
#include <time.h>
#include <fcntl.h>
#include <arpa/inet.h>

#define TVU_ERROR_SERVER_NOT_OPEN -1;
class TVUClient
{
public:
	TVUClient( int ip,unsigned short port,int protocal/*SOCK_STREAM ��SOCK_DGRAM*/);
    ~TVUClient();
	TVUChannel* getChannel();
	int connectServer();
	void closeClient();
	int sendPackage(TVUPackage* package);
	int recvPackage(int &flag);

private:
    int flag;
	TVUChannel * m_pChannel;
	int m_peerIp;
	int m_protocal;
	unsigned short m_peerPort;
}; 
#endif
