//
//  gameIntroduce.h
//  gameUI
//
//  Created by yibin chen on 14-06-04.
//  Copyright (c) 2014年 yibin chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FetchJson.h"
@interface gameIntroduce : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) IBOutlet UIImageView *headImage;

@property(nonatomic,strong)GameInfo * exchangeString;
@property (retain, nonatomic) IBOutlet UILabel *gameLabel;
@property (retain, nonatomic) IBOutlet UILabel *gameName;
@property (retain, nonatomic) IBOutlet UILabel *gameState;
@property (retain, nonatomic) IBOutlet UILabel *gameSize;


@end
