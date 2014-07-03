//
//  test.h
//  TestJniHelper
//
//  Created by �ゅ� ��on 13-12-2.
//
//

#ifndef __My_Jni_Transport__
#define __My_Jni_Transport__
//#include "cocos2d.h"
#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
#include "TVUPackage.h"
#include <string>
#include <arpa/inet.h>


using namespace std;

//获取手机的相关信息
@interface DeviceInfo : NSObject
+ (NSString*) getDeviceName;

+ (NSString*) getMacAddress;
@end



extern "C"{

static int   LABELCONNCETV;
char* parseIp(int ip);   //转换ip
     //启动线程  
void startThread();

//获取设备名
 string getDeviceName();
//获取设备mac地址
string getMacAddress();
//获取我的游戏信息    将游戏信息发送到ui层
void sendMyGameInfo(string gameIds);


    
//tv断开连接
void breakTVWithIp(int ip);

//连接是否成功
void connectRespone(int ip,int isConnected);

bool getRooted();
//断开连接
void closeClient();
//连接TV
void connectServer(int port,int ip);

//启动游戏 --手机启动电视
void startGame(string gameJson,int ip);
//退出游戏
void exitGame(int gameType,string gamePkg,int ip);
//发送tvInfo到UI
void sendTvInfo(string tvInfo,string ip);
//发送鼠标事件
void sendMouseEvent(int act,float x,float y,int ip,int port);
//发送psp等按键事件
void sendPSPEvent(int act,string code,int flag,int ip);
//发送感应器事件
void sendSensor(int act,float x,float y,float z,int ip,int port);
//发送输入法文字信息
void startInputInfo(string text,int flag,int ip);
//发送触摸事件
void sendMouseTouch(int act,int cnt,int aid,float ax,float ay,int bid,float bx,float by,int cid,float cx,float cy,int ip);

//发送支付结果信息
void sendPayInfo(string payInfo,int ip);
//请求我的游戏
void getMyGameInfo(int ip);

//再次发送广播
void getAllTvInfo();

//通知手机启动操作界面
void startGameInPhone(string gameId,int gameType,int gameDirection);
//通知手机启动支付界面
void startPayPageInPhone(string payData);
//通知手机启动输入法
void startInput();


    
//接到数据后在这里解析，解析后分发
static void setData(TVUPackage* package,unsigned int ip);

void* thread_fun(void *arg);

void* thread_udp(void *arg);


}

#endif /* defined(__TestJniHelper__test__) */
