#include "TVUPhoneDevice.h"
#include "TVUPackage.h"
#include <iostream>
#include <sstream>
#import "Singleton.h"
#import "ParseJson.h"
#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

//#define LOGI(...) ((void)__android_log_print(ANDROID_LOG_INFO, "native-activity", __VA_ARGS__))
//#define LOGW(...) ((void)__android_log_print(ANDROID_LOG_WARN, "native-activity", __VA_ARGS__))
//#define LOGE(...) ((void)__android_log_print(ANDROID_LOG_ERROR, "native-activity", __VA_ARGS__))

#define CHANNEL_HEART 1
//锟竭筹拷锟斤拷
#define NUMTHREADS 5
//全锟街憋拷锟斤拷

static TVUPhoneDevice *device = NULL;



//创建Singleton类的单实例对象
Singleton *single = [Singleton getInstance];

extern "C" {

//jstring stringTojstring(JNIEnv* env, const char* pat) {
//	jclass strClass = env->FindClass("Ljava/lang/String;");
//	jmethodID ctorID = env->GetMethodID(strClass, "<init>",
//			"([BLjava/lang/String;)V");
//	jbyteArray bytes = env->NewByteArray(strlen(pat));
//	env->SetByteArrayRegion(bytes, 0, strlen(pat), (jbyte*) pat);
//	jstring encoding = env->NewStringUTF("utf-8");
//	return (jstring) env->NewObject(strClass, ctorID, bytes, encoding);
//}
//
//string jstringTostring(JNIEnv* env, jstring jstr) {
//	char* rtn = NULL;
//	jclass clsstring = env->FindClass("java/lang/String");
//
//	jstring strencode = env->NewStringUTF("utf-8");
//	jmethodID mid = env->GetMethodID(clsstring, "getBytes",
//			"(Ljava/lang/String;)[B");
//	jbyteArray barr = (jbyteArray) env->CallObjectMethod(jstr, mid, strencode);
//	jsize alen = env->GetArrayLength(barr);
//	jbyte* ba = env->GetByteArrayElements(barr, JNI_FALSE);
//	if (alen > 0) {
//		rtn = (char*) malloc(alen + 1); //new   char[alen+1];
//		memcpy(rtn, ba, alen);
//		rtn[alen] = 0;
//	}
//	env->ReleaseByteArrayElements(barr, ba, 0);
//	string stemp(rtn);
//	free(rtn);
//	return stemp;
//}

string int2str(unsigned short &i) {
	string s;
	stringstream ss(s);
	ss << i;
	return ss.str();
}

string floatToString(float value) {
	char Strf[256];
	memset(Strf, 0, 256);
	sprintf(Strf, "%f", value);
	return Strf;
}

string intToString(int value) {
	char Strf[16];
	memset(Strf, 0, 16);
	sprintf(Strf, "%d", value);
	return Strf;
}



void connectRespone(int ip, int isConnected, int statue)
{
    
        [single connStatue:ip
                         conn:isConnected
                        count:statue];
}
//链接断开，  通知UI
void breakTVWithIp(int ip)
{
    single.conn_withTv = FALSE;
    NSLog(@"与电视的连接断开");
}



    
@implementation DeviceInfo : NSObject  
+ (NSString*) getDeviceName
{
    UIDevice *device = [[UIDevice alloc] init];
    //    NSLog(@"设备所有者的名称－－%@",device_.name);
    //    NSLog(@"设备的类别－－－－－%@",device_.model);
    //    NSLog(@"设备的的本地化版本－%@",device_.localizedModel);
    //    NSLog(@"设备运行的系统－－－%@",device_.systemName);
    //    NSLog(@"当前系统的版本－－－%@",device_.systemVersion);
    //    NSLog(@"设备识别码－－－－－%@",device_.identifierForVendor.UUIDString);
    return device.name;
}
#pragma mark MAC

+ (NSString *) getMacAddress
{
	int                   mib[6];
	size_t                len;
	char                *buf;
	unsigned char        *ptr;
	struct if_msghdr    *ifm;
	struct sockaddr_dl    *sdl;
	
	mib[0] = CTL_NET;
	mib[1] = AF_ROUTE;
	mib[2] = 0;
	mib[3] = AF_LINK;
	mib[4] = NET_RT_IFLIST;
	
	if ((mib[5] = if_nametoindex("en0")) == 0) {
		printf("Error: if_nametoindex error/n");
		return NULL;
	}
	
	if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
		printf("Error: sysctl, take 1/n");
		return NULL;
	}
	
	if ((buf = (char*)malloc(len)) == NULL) {
		printf("Could not allocate memory. error!/n");
		return NULL;
	}
	
	if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
		printf("Error: sysctl, take 2");
		return NULL;
	}
	
	ifm = (struct if_msghdr *)buf;
	sdl = (struct sockaddr_dl *)(ifm + 1);
	ptr = (unsigned char *)LLADDR(sdl);
	// NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
	NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
	free(buf);
	return [outstring uppercaseString];
	
}

@end

//获取设备名
string getDeviceName()
{
    NSString* deviceName = [DeviceInfo getDeviceName];
    const char* c_string = [deviceName cStringUsingEncoding:NSASCIIStringEncoding];
    string name = c_string;
    return name;
}

void* thread_udp(void *arg)
{
	while (1)
    {
        //如果device为null，则阻塞
		if(device != NULL) 
        {
			break;
		}
	}
	TVUPackage *heartPackage = new TVUPackage(TVU_HEARTBEAT);
	heartPackage->addData(TVU_PACKAGE_MAPNAME_E, "9");
	while (1)
    {
		sleep(CHANNEL_HEART);
		if (device == NULL || device->checkHeartTime() > TVU_HEART_TIMEOUT)
        {
			if (device != NULL)
            {
				breakTVWithIp(device->getPeerIp());
				device->stopClient();
                NSLog(@"心跳异常  退出");
				//notify ui
			}
		}
        else if (device != NULL)
        {
            
            device->sendHeartPackage(heartPackage);
            
		}
	}
}

void* thread_fun(void *arg)
{
	device = new TVUPhoneDevice();
	device->openService();
    
	pthread_t pt1;
	pthread_create(&pt1, NULL, thread_udp, NULL);
	device->run();
}

//断开连接
void closeClient()
{
	if (device != NULL)
    {
		device->stopClient();
	}
}
 
    //连接TV
void connectServer(int port, int ip)
{
    if (device != NULL)
    {
        int sIp = ip;
        int code = port;
        device->stopClient();
        
        int deviceFlag = device->connectServer(sIp, code, SOCK_STREAM);
        if (deviceFlag > 0)
        {
            TVUPackage *package = new TVUPackage(TVU_TCP_REQUEST);
            package->addData(TVU_PACKAGE_MAPNAME_E, "1");
            string deviceName = getDeviceName();
            package->addData(TVU_PACKAGE_MAPNAME_NAME, deviceName);
            device->sendTcpEvent(package);
            if (package != NULL)
            {
                delete package;
            }
        }
        else
        {
            int rip = ip;
            connectRespone(rip, 0, 0);
        }
    }
}
void startThread()
{
	pthread_t pt;
	pthread_create(&pt, NULL, thread_fun, NULL);

}


//获取设备mac地址
string getMacAddress()
{
    return NULL;
}

void getAllTvInfo(/*JNIEnv *env,jobject thiz */){
    if(device!=NULL)
    {
        TVUPackage *package = new TVUPackage(TVU_INIT_TV_UDP);
        package->addData(TVU_PACKAGE_MAPNAME_E, "0");
        package->addData(TVU_PACKAGE_MAPNAME_TAG, "TVUOO");
        package->setPeerIP("255.255.255.255");
        char buf[16];
        unsigned short eventPort = device->getEventPort();
        sprintf(buf,"%d",eventPort);
        package->addData(TVU_PACKAGE_MAPNAME_UDPPORT, buf);
        sprintf(buf,"%d",UDP_PHONE);
        package->addData(TVU_PACKAGE_UDP_TYPE,buf);
        device->sendPackageWithAll(package);
        delete package;
    }
}
    
    
void getMyGameInfo(int ip)
{
    if (device != NULL)
    {
        int peerIp = ip;
        TVUPackage *package = new TVUPackage(TVU_GAME_INFO);
        package->addData(TVU_PACKAGE_MAPNAME_E, intToString(TVU_DOWNLOAD));
        package->setPeerIPWithInt(peerIp);
        device->sendTcpEvent(package);
        delete package;
    }
    
}

    
    
//获取我的游戏信息
void sendMyGameInfo(string gameIds)
{    
    //UI层直接调用
//	LOGE("sendMyGameInfo()");
//	g_jvm->AttachCurrentThread(&envtt, NULL);
//	cls = envtt->GetObjectClass(g_obj);
//	if (cls == NULL) {
//		LOGE("GetClass Error.....");
//	}
//	//	LOGE("setData()");
//	jmethodID mid = envtt->GetStaticMethodID(cls, "sendMyGameInfo",
//			"(Ljava/lang/String;)V");
//	if (mid == NULL)
//  {
//		LOGE("GetMethodID() Error.....");
//	}
//	string gameinfo = envtt->NewStringUTF(gameIds.c_str());
//	envtt->CallStaticVoidMethod(cls, mid, jgameinfo);
//	envtt->DeleteLocalRef(jgameinfo);
//	if (g_jvm->DetachCurrentThread() != JNI_OK) {
//		LOGE(" DetachCurrentThread() failed");
//	}
    
    const char *gameIDS = gameIds.c_str();
    
    //[NSString alloc] initWithFormat] 会出现乱码
    //[NSString stringWithFormat]会出现乱码
    //[NSString stringWithCString]不会出现乱码
    NSString *games = [NSString stringWithCString:gameIDS
                                         encoding:NSUTF8StringEncoding];
    
//    NSData *data = [games dataUsingEncoding: NSUTF8StringEncoding];
//    
//    NSError * error = [[NSError alloc] init];
//    
//    NSArray *haveInstalledGameArray = [NSJSONSerialization JSONObjectWithData: data
//                                                                    options:NSJSONReadingMutableLeaves
//                                                                      error:&error];
//    [error release];
//    error = nil;
//    single.haveInstalledGameArray = haveInstalledGameArray;
    [single haveInstalledGameArrayInfo:games];
}

    
//发送tvInfo到UI
void sendTvInfo(string tvInfo, int ip)
{
    const char* tvInfoStr = tvInfo.c_str();
    NSString *str_tvInfo = [NSString stringWithFormat:@"%s", tvInfoStr];
    [single tvInfo:str_tvInfo
           address:ip];
}
    
    
bool getRooted()
{
    return false;
}
//启动游戏 --手机启动电视
void startGame(string gameJson, int ip)
{
	if (device != NULL) {
		int peerIp = ip;
		TVUPackage *package = new TVUPackage(TVU_GAME_INFO);
		package->addData(TVU_PACKAGE_MAPNAME_E, "13");
		package->addData(TVU_PACKAGE_MAPNAME_GAMEINFO, gameJson);
		package->setPeerIPWithInt(peerIp);
		
        device->sendTcpEvent(package);
        
        delete package;
	}
}
    
//退出游戏
void exitGame(int gameType,string gamePkg, int ip) {
	if (device != NULL) {
		int peerIp = ip;
		int type = gameType;
		TVUPackage *package = new TVUPackage(TVU_GAME_INFO);
		package->addData(TVU_PACKAGE_MAPNAME_E, intToString(TVU_EXIT_GAME));
		package->addData(TVU_PACKAGE_MAPNAME_PKGNAME, gamePkg);
		package->addData(TVU_PACKAGE_MAPNAME_GAMETYPE,intToString(type));
		package->setPeerIPWithInt(peerIp);
		
        device->sendTcpEvent(package);
		
        delete package;
	}

}
static  char *st;
char* parseIp(int ip)
{
    struct in_addr ip_addr;
    memcpy(&ip_addr, &ip, 4);
     st = inet_ntoa(ip_addr);                              //将int型ip 转换成 字符串
    return st;
}
    


    



//发送鼠标事件
void sendMouseEvent(int act, float x, float y, int ip, int port) {
	if (device != NULL)
    {
		float sendx = x;
		float sendy = y;
		int sendact = act;
		int peerIp = ip;
		int peerPort = port;
		TVUPackage *package = new TVUPackage(TVU_GAME_INFO);
		package->addData(TVU_PACKAGE_MAPNAME_E, intToString(TVU_MOUSE));
		package->addData(TVU_PACKAGE_MAPNAME_ACT, intToString(sendact));
		package->addData(TVU_PACKAGE_MAPNAME_X, floatToString(sendx));
		package->addData(TVU_PACKAGE_MAPNAME_Y, floatToString(sendy));
		package->setPeerIPWithInt(peerIp);
		if (act == 2 || act == 1)
        {
			device->sendUdpEnvent(package, peerPort);
		} else {
			device->sendTcpEvent(package);
		}
//		LOGE("Touch mouse = %s",package->toJson().c_str());
		delete package;
	}

}
//发送psp等按键事件
void sendPSPEvent(int act, string code, int flag, int ip)
{
	if (device != NULL) {
//		LOGE("sendPSPEVENTBEGIN");
		int sendact = act;
//		string sendcode = jstringTostring(env, code);
		int sendflag = flag;
		int peerIp = ip;
		TVUPackage *package = new TVUPackage(TVU_KEYBOARD);
		package->addData(TVU_PACKAGE_MAPNAME_E, "4");
		package->addData(TVU_PACKAGE_MAPNAME_ACT, intToString(sendact));
		package->addData(TVU_PACKAGE_MAPNAME_CODE, code);               
		package->addData(TVU_PACKAGE_MAPNAME_FLAG, intToString(sendflag));
		package->setPeerIPWithInt(peerIp);
		device->sendTcpEvent(package);
		delete package;
//		LOGE("sendPSPEVENTEND");
	}
}
//发送感应器事件
void sendSensor(int act, float x, float y, float z, int ip,int port) {
	if (device != NULL) {
		int sendact = act;
		float sendx = x;
		float sendy = y;
		float sendz = z;
		int peerIp = ip;
		int peerPort = port;
		TVUPackage *package = new TVUPackage(TVU_SENSOR);
		package->addData(TVU_PACKAGE_MAPNAME_E, "5");
		package->addData(TVU_PACKAGE_MAPNAME_ACT, floatToString(sendact));
		package->addData(TVU_PACKAGE_MAPNAME_X, floatToString(sendx));
		package->addData(TVU_PACKAGE_MAPNAME_Y, floatToString(sendy));
		package->addData(TVU_PACKAGE_MAPNAME_Z, floatToString(sendz));
		package->setPeerIPWithInt(peerIp);
		device->sendUdpEnvent(package, peerPort);
		delete package;
	}

}


//发送支付结果信息
void sendPayInfo(string payInfo,int ip){
	if (device != NULL) {
//		string payinfo = jstringTostring(env, payInfo);                 //jstring   or   string  ??
//		int peerIp = ip;
//		TVUPackage *package = new TVUPackage(TVU_GAME_INFO);
//		package->addData(TVU_PACKAGE_MAPNAME_E, "11");
//		package->addData(TVU_PACKAGE_MAPNAME_PNAME, payinfo);
//		package->setPeerIPWithInt(peerIp);
//		device->sendTcpEvent(package);
//		delete package;
	}


}

//发送输入法文字信息
void startInputInfo(string text, int flag,int ip)
{
	if (device != NULL)
    {
		int peerIp = ip;
		int inputflag = flag;
		TVUPackage *package = new TVUPackage(TVU_GAME_INFO);
		package->addData(TVU_PACKAGE_MAPNAME_E, "7");
		package->addData(TVU_PACKAGE_MAPNAME_TEXT, text);
		package->addData(TVU_PACKAGE_MAPNAME_INPUTFLAG, intToString(inputflag));

		package->setPeerIPWithInt(peerIp);
		device->sendTcpEvent(package);
		delete package;
	}

}
//触摸事件
void sendMouseTouch(int act, int cnt, int aid, float ax, float ay,
		int bid, float bx, float by, int cid, float cx, float cy,
		int ip)
{
	if (device != NULL)
    {
		int sendact = act;
		int sendcnt = cnt;
		int sendaid = aid;
		float sendax = ax;
		float senday = ay;
		int sendbid = bid;
		float sendbx = bx;
		float sendby = by;
		int sendcid = cid;
		float sendcx = cx;
		float sendcy = cy;
		int peerIp = ip;
		TVUPackage *package = new TVUPackage(TVU_TOUCH);
		package->addData(TVU_PACKAGE_MAPNAME_E, "8");
		package->addData(TVU_PACKAGE_MAPNAME_ACT, intToString(sendact));
		package->addData(TVU_PACKAGE_MAPNAME_CNT, intToString(sendcnt));
		package->addData(TVU_PACKAGE_MAPNAME_AID, intToString(sendaid));
		package->addData(TVU_PACKAGE_MAPNAME_AX, floatToString(sendax));
		package->addData(TVU_PACKAGE_MAPNAME_AY, floatToString(senday));
		package->addData(TVU_PACKAGE_MAPNAME_BID, intToString(sendbid));
		package->addData(TVU_PACKAGE_MAPNAME_BX, floatToString(sendbx));
		package->addData(TVU_PACKAGE_MAPNAME_BY, floatToString(sendby));
		package->addData(TVU_PACKAGE_MAPNAME_CID, intToString(sendcid));
		package->addData(TVU_PACKAGE_MAPNAME_CX, floatToString(sendcx));
		package->addData(TVU_PACKAGE_MAPNAME_CY, floatToString(sendcy));
		package->setPeerIPWithInt(peerIp);
		device->sendTcpEvent(package);
		delete package;
	}

}


    
//通知手机启动操作界面
void startGameInPhone(string gameId,int gameType,int gameDirection)
{
    const char *game_id = gameId.c_str();
//    NSString *game = [NSString stringWithFormat:@"%s",game_id];
    NSString *game = [NSString stringWithFormat:@"%s", game_id];
//    [single getStart:game
//                type:gameType
//           direction:gameDirection];


    single.game_str = game;
    single.game_direction = gameDirection;
    single.game_type = gameType;
    
    NSObject *object = (NSObject*)single.delegate1;
//    if(object respondsToSelector:(SEL)startGame(gameJson, ip));
    if([single.delegate1 respondsToSelector:@selector(startGame)])
    {
        [object performSelectorOnMainThread:@selector(startGame)
                                 withObject:nil
                              waitUntilDone:NO];
    }

}



    
    
//通知手机启动支付

void startPayPageInPhone(string payData)
{
	
}

//通知手机启动输入法
void startInput()
{	
}
//接受电视端的数据进行解析
void setData(TVUPackage* package, unsigned int ip) {

//	MyJniTransport hsjad
	int e = atoi(package->getDataWithName(TVU_PACKAGE_MAPNAME_E).c_str());
	if (e == 0)
    {
		sendTvInfo(package->toJson(), ip);
	}
    else if (e == TVU_TCP_REQUEST)
    {

	}
    else if (e == TVU_TCP_RESPONE)
    {
		int conStatue =
				atoi(package->getDataWithName(TVU_PACKAGE_MAPNAME_ISMAINCONTRAL).c_str());
//		LOGE("respone = %s",package->toJson().c_str());
		connectRespone(ip, 1, conStatue);
	}
    else if (e == TVU_GAME_INFO)
    {
		string id = package->getDataWithName(TVU_PACKAGE_MAPNAME_GAMEID);
		int gameType = atoi(package->getDataWithName(TVU_PACKAGE_MAPNAME_GAMETYPE).c_str());
		int gameDirection = atoi(package->getDataWithName(TVU_PACKAGE_MAPNAME_NESCONTRAL).c_str());
		startGameInPhone(id,gameType,gameDirection);
	}
    else if (e == TVU_PAY)
    {
		string payInfo = package->getDataWithName(TVU_PACKAGE_MAPNAME_PNAME);
		startPayPageInPhone(payInfo);
	}
    else if (e == TVU_INPUT)
    {
		startInput();
	}
    else if (e == TVU_DOWNLOAD)
    {
		string games = package->getDataWithName(TVU_PACKAGE_MAPNAME_GAMEINFO);
		sendMyGameInfo(games);
	}
	if (package != NULL)
    {
		delete package;
	}
}
}
