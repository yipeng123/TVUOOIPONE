//
//  connecTV.h
//  gameUI
//
//  Created by yibin chen on 14-06-10.
//  Copyright (c) 2014年 yibin chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"
#import "ParseJson.h"
#import "LabelconncetTV.h"
#import <QuartzCore/CALayer.h>


@interface connecTV : UIViewController<UITableViewDelegate,UITableViewDataSource,StartUI>
{
    UITableView * tableview;
    
    NSMutableArray *_tvInfos ;
    NSTimer * t_rotaeTime;
    Singleton *single;
    
}

- (void) connSrv:(TvInfo*)tvinfo;
- (IBAction)returnLay:(id)sender;     //返回上一页面


@property (retain, nonatomic) IBOutlet UIView *rotateView;          //旋转图片 标签 view
@property (retain, nonatomic) IBOutlet UIImageView *rotateImage;
@property (retain, nonatomic) IBOutlet UILabel *rotateLabel;

@property (retain, nonatomic) IBOutlet UILabel *PromptLabel;
@property (retain, nonatomic) IBOutlet UIButton *PromptButton;


@end