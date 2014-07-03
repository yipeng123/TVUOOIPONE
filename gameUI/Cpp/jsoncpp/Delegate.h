//
//  Delegate.h
//  gameUI
//
//  Created by xubo on 6/5 星期四.
//  Copyright (c) 2014年 yibin chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StartUI.h"
@interface Delegate : NSObject
{
    id<StartUI> delegate1 ;
    
    NSString *game_str;
    int game_type;
    int game_direction;
    
    NSString *tv_info;
    int tv_ip;
}
+ (Delegate*) init;

//游戏启动画面
- (void) gameStart:(NSString*) gameId
              type:(int) gameType
         direction:(int) gameDirection;

//显示tvInfo
- (void) tvInfo:(NSString*)info
        address:(int)ip;

- (void) dealloc;
@property (retain, nonatomic) id<StartUI> delegate1;
@end
