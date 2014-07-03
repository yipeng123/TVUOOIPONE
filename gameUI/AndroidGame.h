//
//  AndroidGame.h
//  gameUI
//
//  Created by yibin chen on 14-06-27.
//  Copyright (c) 2014年 yibin chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FetchJson.h"
#import "StartUI.h"
#import "Singleton.h"
#import "Cpp/MyJniTransport.h"
#import "LabelconncetTV.h"
#import "KeyBean.h"
#import "MyJniTransport.h"
#import "ParseJson.h"



@interface AndroidGame : UIViewController<ProcessJson,StartUI>
{
    Singleton *single;
    KeyBean * keybean;
} 


@property(retain,nonatomic) Singleton *single;
//@property(retain,nonatomic) GameInfo *appRecord;
@property(retain,nonatomic) KeyBean * keybean;

@property (retain, nonatomic) IBOutlet UIImageView *GameBackgroundImage; //游戏背景图片

@property (retain, nonatomic) IBOutlet UIView *Gameview;    //游戏view
@property (retain, nonatomic) IBOutlet UIView *HandView;    //触摸view
@property (retain, nonatomic) IBOutlet UIImageView *HandTou;     //手指触摸板
@property (retain, nonatomic) IBOutlet UIButton *Hand;          //手指
@property (retain, nonatomic) IBOutlet UIButton *HandDownOk;







@property (retain, nonatomic) IBOutlet UIView *GameMaxView;
@property (retain, nonatomic) IBOutlet UIView *HandMaxView;
@property (retain, nonatomic) IBOutlet UIButton *VoiceMin;
@property (retain, nonatomic) IBOutlet UIButton *VoicMax;
@property (retain, nonatomic) IBOutlet UIButton *ReturnGame;
@property (retain, nonatomic) IBOutlet UIButton *shakeBUtton;
@property (retain, nonatomic) IBOutlet UIButton *NOVoic;


@property (retain, nonatomic) IBOutlet UIButton *shakeButtonHand;   //震动
@property (retain, nonatomic) IBOutlet UIButton *NoVoicHand;        //静音
@property (retain, nonatomic) IBOutlet UIButton *VoicMaxHand;   //音量小
@property (retain, nonatomic) IBOutlet UIButton *VoicMAXHAND;   //音量大
@property (retain, nonatomic) IBOutlet UIButton *ReturnGameHand;







- (IBAction)CilkeGameFun:(id)sender;    //抽屉开关
- (IBAction)ClikeHandFun:(id)sender;
- (IBAction)ClikeGameNo:(id)sender;
- (IBAction)ClikeHandNo:(id)sender;

- (IBAction)Clickzhend:(id)sender;
- (IBAction)ClikeNoVoic:(id)sender;
- (IBAction)ClikeVoicMaxDown:(id)sender;    //声音小按下
- (IBAction)ClikeVoicMinUp:(id)sender;
- (IBAction)ClikeVoicMAXDown:(id)sender;
- (IBAction)ClikeVoicMaxUp:(id)sender;
- (IBAction)ClikeReturnGame:(id)sender;

- (IBAction)ClikezhenHand:(id)sender;
- (IBAction)ClikeNoVoicHand:(id)sender;
- (IBAction)ClikeVoicMaxHand:(id)sender;
- (IBAction)ClikeVoicMaxHandUp:(id)sender;
- (IBAction)ClikeVoicMinHandDown:(id)sender;
- (IBAction)ClikeVoicMinHandUp:(id)sender;
- (IBAction)ClikeReturnGameHand:(id)sender;


- (IBAction)OkHandDown:(id)sender;
- (IBAction)OKHand:(id)sender;
- (IBAction)NoHand:(id)sender;


@end
