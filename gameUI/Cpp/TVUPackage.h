/**
 使用指南（直接使用或通过JNI使用）
 1.TVUPackage 为所有数据包父类，为虚类，不可实例化
 2.所有数据包必须为TVUPackage子类
 3.通信层所有接口均通过TVUPackage的数据单元来实现，协议更改，新增数据类型等只需实现新的子类即可
 */
#ifndef TVU_PACKAGE
#define TVU_PACKAGE

#include <map>
#include <list>

#include <stdio.h>

#include <unistd.h>
#include <stdlib.h>
//#include "st"
#include <string>
#include "jsoncpp/include/json/json.h"
using namespace std;


#define LOGI(...) ((void)__android_log_print(ANDROID_LOG_INFO, "native-activity", __VA_ARGS__))
#define LOGW(...) ((void)__android_log_print(ANDROID_LOG_WARN, "native-activity", __VA_ARGS__))
#define LOGE(...) ((void)__android_log_print(ANDROID_LOG_ERROR, "native-activity", __VA_ARGS__))

//支持不同类型的数据包编解码，暂只实现json
#ifndef TVU_ENCODING_TYPE
#define TVU_ENCODING_TYPE
#define TVU_ENCODING_BIN	1
#define TVU_ENCODING_JSON	2
#define TVU_ENCODING_XML	4
#endif

const string TVU_PACKAGE_MAPNAME_E = "e";//数据类型
const string TVU_PACKAGE_MAPNAME_TAG = "tag";//固定值TVUOO
const string TVU_PACKAGE_MAPNAME_VS  = "vs";//协议版本号
const string TVU_PACKAGE_MAPNAME_MINVS = "minVs";//兼容的最低版本号
const string TVU_PACKAGE_MAPNAME_WINW = "winW";//屏幕宽
const string TVU_PACKAGE_MAPNAME_WINH ="winH";//屏幕高
const string TVU_PACKAGE_MAPNAME_NAME ="name";//device 名
const string TVU_PACKAGE_MAPNAME_MAC ="mac";//device mac
const string TVU_PACKAGE_MAPNAME_SERVERPORT = "serverPort";//建立的tcpserver的端口号
const string TVU_PACKAGE_MAPNAME_UDPPORT = "udpPort";//建立的udp的端口号
const string TVU_PACKAGE_MAPNAME_ISROOTED = "isRooted";//是否root 非root 1root
const string TVU_PACKAGE_MAPNAME_CAPABILITY = "capability";//性能 1普通 2高性能 3低性能
const string TVU_PACKAGE_UDP_TYPE = "udpType";//建立的udp的类型



const string TVU_PACKAGE_MAPNAME_RESPCODE = "respCode";//握手包响应代码
const string TVU_PACKAGE_MAPNAME_TEXT =  "text";//握手包响应的文字信息，输入框文字信息

const string TVU_PACKAGE_MAPNAME_CLINETPORT =  "clientPort";//握手包响应的文字信息，输入框文字信息

const string TVU_PACKAGE_MAPNAME_ACT = "act";//鼠标动作，触摸事件

const string TVU_PACKAGE_MAPNAME_CODE =  "code";//按键组合码
const string TVU_PACKAGE_MAPNAME_FLAG ="flag";//按键动作Mode

const string TVU_PACKAGE_MAPNAME_X ="x";//坐标|位移|感应器
const string TVU_PACKAGE_MAPNAME_Y ="y";//坐标|位移|感应器
const string TVU_PACKAGE_MAPNAME_Z ="z";//感应器

const string TVU_PACKAGE_MAPNAME_CNT= "cnt";//触摸手指个数
const string TVU_PACKAGE_MAPNAME_AID ="aId";//第一个手指id
const string TVU_PACKAGE_MAPNAME_AX ="ax";
const string TVU_PACKAGE_MAPNAME_AY ="ay";
const string TVU_PACKAGE_MAPNAME_BID =  "bId";
const string TVU_PACKAGE_MAPNAME_BX ="bx";
const string TVU_PACKAGE_MAPNAME_BY ="by";
const string TVU_PACKAGE_MAPNAME_CID ="cId";
const string TVU_PACKAGE_MAPNAME_CX ="cx";
const string TVU_PACKAGE_MAPNAME_CY ="cy";

const string TVU_PACKAGE_MAPNAME_PID ="pId";//商品id
const string TVU_PACKAGE_MAPNAME_PNAME ="pName";//商品名称
const string TVU_PACKAGE_MAPNAME_PRICE ="price";//商品价格
const string TVU_PACKAGE_MAPNAME_DESC ="desc";//商品描述
const string TVU_PACKAGE_MAPNAME_PAYTYPE ="paytype";//支付类型
const string TVU_PACKAGE_MAPNAME_PAYCID ="CID";//渠道号
const string TVU_PACKAGE_MAPNAME_APPID ="APP_ID";//应用id
const string TVU_PACKAGE_MAPNAME_CPID ="CPID";//
const string TVU_PACKAGE_MAPNAME_CPORDERNUM= "cp_order_num";//
const string TVU_PACKAGE_MAPNAME_CPNAME ="CPNAME";//开发商名称
const string TVU_PACKAGE_MAPNAME_RESERVE ="reserve";//预留
const string TVU_PACKAGE_MAPNAME_SIGN ="sign";//签名数据


const string TVU_PACKAGE_MAPNAME_RESULTSTATE ="resultState";//支付状态
const string TVU_PACKAGE_MAPNAME_RESULTCODE ="resultCode";//支付响应代码
const string TVU_PACKAGE_MAPNAME_RESULTSTRING ="resultstring";//支付结果显示文字
const string TVU_PACKAGE_MAPNAME_PORDERNO ="pOrderNO";//

const string TVU_PACKAGE_MAPNAME_PKGNAME ="pkgName";//游戏包名
const string TVU_PACKAGE_MAPNAME_GAMEINFO ="gameInfo";//本地已安装游戏信息

const string TVU_PACKAGE_MAPNAME_GAMEID ="gameID";//游戏id

const string TVU_PACKAGE_MAPNAME_ISMAINCONTRAL ="isMainContral";//是否主控，0是，1不是

const string TVU_PACKAGE_MAPNAME_GAMETYPE ="gameType";
const string TVU_PACKAGE_MAPNAME_INPUTFLAG ="inputFlag";

const string TVU_PACKAGE_MAPNAME_NESCONTRAL ="nescontral";//1 4方向，2 方向

const static string STRINGNames[] = {TVU_PACKAGE_MAPNAME_TAG,TVU_PACKAGE_MAPNAME_NAME,TVU_PACKAGE_MAPNAME_MAC,TVU_PACKAGE_MAPNAME_TEXT,TVU_PACKAGE_MAPNAME_CODE,TVU_PACKAGE_MAPNAME_PNAME,TVU_PACKAGE_MAPNAME_DESC,TVU_PACKAGE_MAPNAME_CPNAME,TVU_PACKAGE_MAPNAME_RESERVE,TVU_PACKAGE_MAPNAME_SIGN,TVU_PACKAGE_MAPNAME_RESULTSTRING,TVU_PACKAGE_MAPNAME_PKGNAME,TVU_PACKAGE_MAPNAME_GAMEID,TVU_PACKAGE_MAPNAME_GAMEINFO};

enum package_type{
    UDP_PACKAGE,
    TCP_PACKAGE,
    IMG_PACKAGE
};
enum udp_type{
    UDP_TV,
    UDP_PHONE
};


//这里列举所有数据包类型，每个类型实现一个子类
//子类实现对读到的数据进行解码以及对要发送的数据进行编码
enum tvupackagetype
{
	TVU_INIT_TV_UDP,//tv信息
	TVU_TCP_REQUEST,//握手请求
	TVU_TCP_RESPONE,//握手响应
	TVU_MOUSE,//鼠标
	TVU_KEYBOARD,//android psp按键
	TVU_SENSOR,//传感器
	TVU_INPUT,//输入法
	TVU_INPUT_TEXT,//输入法有数据
    TVU_TOUCH,//触摸多点
	TVU_HEARTBEAT,//心跳
	TVU_PAY,//发起支付
    TVU_PAYREQUEST,//支付请求结果
    TVU_SERVER,
	TVU_GAME_INFO,//游戏下载信息
	TVU_DOWNLOAD,//游戏下载游戏列表
	TVU_KEYBEAN,
	TVU_KEYSTAUS,//红白机和街机的按钮显示
	TVU_IMG,
	TVU_JAR,
	TVU_EXIT_GAME
};

class TVUPackage
{
public:
	TVUPackage(int pkgType);
	int encode(unsigned char* buf,int bufLen);

	static TVUPackage* decodeWithUdp(unsigned char* buf,int bufLen);
	static TVUPackage* decode(unsigned char* buf,int bufLen,int& remainLen,int& dataLen);
	int setEncodingType(int type);
	void setPeerIP(char* ip);
	void setPeerIPWithInt(unsigned int ip);
	unsigned int getPeerIp();
    string toJson();
    void setData(string json);
    string getDataWithName(string name);
    void addData(string name,string value);
    void removeData(string name);
//    virtual char* toJson();
protected:
	int p_iPkgType;
	unsigned int p_peerIp;

private:
    int p_encodingType;
    list<string> l_namelist;
    map<string, string> m_map;
};
#endif
