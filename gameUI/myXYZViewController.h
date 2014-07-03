//
//  myXYZViewController.h
//  gameUI
//
//  Created by yibin chen on 14-05-20.
//  Copyright (c) 2014年 yibin chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "FetchJson.h"
#import "monitorTV.h"
#import "MyJniTransport.h"
#import "Singleton.h"
#import "LabelconncetTV.h"
#import <AudioToolbox/AudioToolbox.h>
#import "Settings.h"
#import <CoreMotion/CoreMotion.h>
static int m_label = 0;

@interface myXYZViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ProcessJson,StartUI>
{
    NSTimer * t_timer;
    NSTimer * t_rotaeTime;
    NSMutableArray *_tvInfos ;
    Singleton *single;
    Settings *settings;
    CMMotionManager *motionManager;
    NSTimer *updateTimer;
    BOOL flag;
}
@property BOOL flag;
@property (retain, nonatomic) NSTimer *updateTimer;
@property (retain, nonatomic) CMMotionManager *motionManager;
@property (retain, nonatomic) IBOutlet UIView *lockerView;        //抽屉
@property (retain, nonatomic) IBOutlet UIView *loadImage;

@property (retain, nonatomic) IBOutlet NSTimer * t_timer;;

@property (retain, nonatomic) IBOutlet UIProgressView *progress;  //进度条


@property (retain, nonatomic) IBOutlet UIView *lordView;        //抽屉界面
@property (retain, nonatomic) IBOutlet UIButton *MoreBttonu;      //抽屉关闭按钮

@property (retain, nonatomic) IBOutlet UIImageView *touVoice;     //设置声音
@property (retain, nonatomic) IBOutlet UIImageView *touShake;     //设置震动
@property (retain, nonatomic) IBOutlet UIImageView *touFrame;     //设置边界
@property (retain, nonatomic) IBOutlet UIButton *buttonHelp;      //帮助按钮
@property (retain, nonatomic) IBOutlet UIButton *buttonOpinion;   //建议按钮
@property (retain, nonatomic) IBOutlet UIButton *buttonVersions;  //版本按钮
@property (retain, nonatomic) IBOutlet UIButton *buttonConnect;   //连接设备按钮

//@property  (retain,nonatomic)  NSString *game_id;
@property (retain, nonatomic) IBOutlet UIImageView *labelImage;     //标签图片
@property (retain, nonatomic) IBOutlet UILabel *labelNTv;           //提示有几台电视标签
@property (retain, nonatomic) IBOutlet UILabel *nameTV;             //电视机名字
@property (retain, nonatomic) IBOutlet UIImageView *rotateImage;    //旋转图片
@property (retain, nonatomic) IBOutlet UIView *rotateView;          //旋转View
@property (retain, nonatomic) IBOutlet UILabel *rotaeLabel;         //旋转标签

@property (retain, nonatomic) IBOutlet UIButton *remoteShutButton;   //遥控关机按钮
@property (retain, nonatomic) IBOutlet UIButton *remoteVoiceButton;  //遥控静音
@property (retain, nonatomic) IBOutlet UIButton *remoteMinButton;    //遥控减小
@property (retain, nonatomic) IBOutlet UIButton *remoteMaxButton;    //遥控加大
@property (retain, nonatomic) IBOutlet UIView *closeView;            //关闭屏幕
@property (retain, nonatomic) IBOutlet UIButton *nullMouseConncetButton;    //空鼠连接设备按钮


@property (retain, nonatomic) IBOutlet UIImageView *vacancy1;



- (void) accelerator;                           //陀螺仪操作

- (IBAction)packLocker:(id)sender;              //抽屉
- (IBAction)ClickMoreBtton:(id)sender;          //单击更多
- (IBAction)ClickHelp:(id)sender;               //单击帮助
- (IBAction)ClickOpinion:(id)sender;            //单击意见
- (IBAction)ClickVersions:(id)sender;           //单击版本

- (IBAction)ClickConnect:(id)sender;            //单击连接设备
@property (retain, nonatomic) IBOutlet UIButton *ClickremoteConncet;    //遥控连接按钮
- (IBAction)ClickremoteConncetBtton:(id)sender;                 //遥控连接按钮事件



- (IBAction)ClickMyGame:(id)sender;     //单击我的游戏按钮 事件

- (IBAction)ClickremoteShutDown:(id)sender;     //关机 静音 减小 加大的按下松开事件
- (IBAction)ClickremoteShutUp:(id)sender;

- (IBAction)ClickremoteVoiceDown:(id)sender;
- (IBAction)ClickremoteVoiceUp:(id)sender;

- (IBAction)ClickremoteMinDown:(id)sender;
- (IBAction)ClickremoteMinUp:(id)sender;

- (IBAction)ClickremoteMaxDown:(id)sender;
- (IBAction)ClickremoteMaxUp:(id)sender;

- (IBAction)ClickYesClose:(id)sender;        //确定关闭事件
- (IBAction)ClickNoClose:(id)sender;         //暂不关闭事件


- (IBAction)ClickReturn:(id)sender;         //返回 主页 菜单
- (IBAction)ClickLord:(id)sender;
- (IBAction)ClickMuen:(id)sender;

- (IBAction)ClickNoNullmao:(id)sender;
- (IBAction)ClickconncetNonullmao:(id)sender;


- (IBAction)ClickGameCentre:(id)sender;     //游戏中心
- (IBAction)ClickTouch:(id)sender;          //触摸板
- (IBAction)nullMouseReturn:(id)sender;
- (IBAction)ClickCloseNullMouse:(id)sender;
- (IBAction)ClickCloseMouse2:(id)sender;

@end
