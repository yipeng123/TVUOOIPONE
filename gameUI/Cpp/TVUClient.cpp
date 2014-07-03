#include "TVUClient.h"
TVUClient::TVUClient(int ip,unsigned short port,int protocal/*SOCK_STREAM 或SOCK_DGRAM*/)
{
	m_peerIp = ip;
	m_peerPort = port;
	m_protocal = protocal;
	m_pChannel = NULL;
}

TVUClient::~TVUClient()
{
	closeClient();
}

TVUChannel* TVUClient::getChannel()
{
	return m_pChannel;
}

void TVUClient::closeClient()
{
	if(m_pChannel != NULL)
	{
		delete m_pChannel;
	}
	m_pChannel = NULL;
}

int TVUClient::connectServer()
{
	if(m_protocal!=SOCK_STREAM && m_protocal!=SOCK_DGRAM)
	{
		return -1;
	}
	
	closeClient();
    
	//int keepalive=1;
	sockaddr_in addr;
	addr.sin_family=AF_INET;
	addr.sin_port=htons(m_peerPort);
	addr.sin_addr.s_addr=m_peerIp;
   	if (addr.sin_addr.s_addr == INADDR_NONE)
	{
		printf("\n无效ip \n"); 
		return -1;
	}
	bzero(&(addr.sin_zero),8);
	int sock = socket(AF_INET,m_protocal,0);
	if(sock<1)
    {
		return -1;
	}
	//setsockopt(sock,SOL_SOCKET,SO_KEEPALIVE,&keepalive,4);
	//keepalive=0;
	//setsockopt(sock,SOL_TCP,TCP_NODELAY,&keepalive,4);
	if(m_protocal==SOCK_STREAM)
	{
		//TCP连接
		//alarm(5);
		if(connect(sock,(struct sockaddr*)&addr,sizeof(addr))<0){
//			cout<<"+++++++++++连接失败+++++++++"<<endl;
			close(sock);
//            closeClient();
			//alarm(0);
			return -1;
		}
		alarm(0);
//		cout<<"+++++++++++连接成功+++++++++"<<endl;
		
	}
	m_pChannel = new TVUChannel(sock,m_peerPort,m_peerIp);
	return sock;
}

int TVUClient::recvPackage(int &flag)
{
	if(m_pChannel == NULL)
	{
		//连接服务器
		if(connectServer()<1)
           {
               flag = TVU_ERROR_SERVER_NOT_OPEN;
               return NULL;
           }
    }
    return m_pChannel->recvPackage(flag);
}
           
int TVUClient::sendPackage(TVUPackage* package)
{
    if(m_pChannel == NULL)
            {
                if(connectServer()<1)
                   {
                       //连接服务器
//                       if(connectServer()<1)
//                          {
                              flag = TVU_ERROR_SERVER_NOT_OPEN;
                              return flag;
//                          }
                    }
            }
        return m_pChannel->sendTcpPackage(package);
}
