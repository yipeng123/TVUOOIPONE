//
//  HORViewController.h
//  gameUI
//
//  Created by yibin chen on 14-05-27.
//  Copyright (c) 2014年 yibin chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cpp/MyJniTransport.h"
#import "Singleton.h"
#import "ParseJson.h"
#import <AudioToolbox/AudioToolbox.h>
#import "Settings.h"
static SystemSoundID soundId = 0;
@interface HORViewController : UIViewController
{
    UIImageView *crank1;
    UIImageView *bottom1;
    Singleton *single;
    NSString * path;
    Settings *settings;
}
@property (retain, nonatomic) Settings *settings;
@property (retain, nonatomic) NSMutableArray *tvInfos;
@property (retain, nonatomic) IBOutlet UIImageView *HOR;
@property (retain, nonatomic) IBOutlet UIButton *buttonMouse;
@property (retain, nonatomic) IBOutlet UIImageView *imageMouse;
@property (retain, nonatomic) Singleton *single;

@property (retain, nonatomic) IBOutlet UIButton *Finger;
@property (retain, nonatomic) IBOutlet UIImageView *TouchTablet;
@property (retain, nonatomic) IBOutlet UIButton *functionButton;    //功能按钮
@property (retain, nonatomic) IBOutlet UIButton *gameButton;        //开始游戏
@property (retain, nonatomic) IBOutlet UIButton *insertButton;      //免费投币
@property (retain, nonatomic) IBOutlet UIButton *lockerButtonVibration;      //按钮震动
@property (retain, nonatomic) IBOutlet UIButton *lockerButtonVoice;          //按钮音效
@property (retain, nonatomic) IBOutlet UIButton *buttonAddVoice;            //声音加
@property (retain, nonatomic) IBOutlet UIButton *buttonCutVoice;            //声音减
@property (retain, nonatomic) IBOutlet UIButton *buttonSystem;              //系统
@property (retain, nonatomic) IBOutlet UIButton *buttonOut;                 //退出当前游戏


@property (retain, nonatomic) IBOutlet UIView *lockerView;          //更多功能抽屉view
@property (retain, nonatomic) IBOutlet UIButton *buttonMenu;        //菜单
@property (retain, nonatomic) IBOutlet UIButton *buttonConncet;     //连接设备按钮
@property (retain, nonatomic) IBOutlet UIImageView *bottom2;




- (IBAction)clikeOut:(id)sender;                //单击退出
- (IBAction)clikeMenu:(id)sender;               //单击菜单
- (IBAction)clikeSystem:(id)sender;             //单击系统
- (IBAction)clikeAddButtonUpOut:(id)sender;     //减小声音松开
- (IBAction)clikeCutButtonDown:(id)sender;      //减小声音按下
- (IBAction)deddd:(id)sender;
- (IBAction)clikeAddButtonDown:(id)sender;      //加声音按下
- (IBAction)clikeFunction:(id)sender;       //功能单击事件
- (IBAction)clikeGame:(id)sender;           //开始游戏事件
- (IBAction)clikeInsert:(id)sender;         //免费投币事件

- (IBAction)clikeGameDown:(id)sender;   //开始游戏事件按下
- (IBAction)clikeInsertDown:(id)sender;  //免费投币事件按下



- (IBAction)clikeVibration:(id)sender;      //震动单击事件
- (IBAction)clikeVoice:(id)sender;          //声音单击事件

- (IBAction)returnTop:(id)sender;
- (IBAction)ClickNO:(id)sender;
- (IBAction)ClickOK:(id)sender;






@end
