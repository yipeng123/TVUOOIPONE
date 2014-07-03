//
//  Delegate.m
//  gameUI
//
//  Created by xubo on 6/5 星期四.
//  Copyright (c) 2014年 yibin chen. All rights reserved.
//

#import "Delegate.h"

@implementation Delegate

@synthesize delegate1;

- (void) showTv:(NSString*)info
           addr:(int)ip
{
    if(delegate1 != nil)
    {
        [delegate1 showTvInfo:tv_info
                      address:tv_ip];
    }
}

- (void) gameStart:(NSString*) gameId
              type:(int) gameType
         direction:(int) gameDirection
{
    if(delegate1 != nil)
    {
        [delegate1 startGame:game_str
                        type:game_type
                   direction:game_direction];
    }
}

+ (Delegate*) init
{
    static Delegate *instance;
    
    @synchronized(self)
    {
        if(!instance)
        {
            instance = [[Delegate alloc] init];
        }
    }
    return (instance);
}
- (void) dealloc
{
    [delegate1 release];
    [game_str release];
    [super dealloc];
}

- (void) getStart:(NSString*)string
             type:(int)gameType
        direction:(int)gameDirection
{
    game_str = string;
    game_type = gameType;
    game_direction = gameDirection;
    
    //    如果设置waitUntilDone为YES:等待当前线程执行完以后，主线程才会执行gameStart方法；
    //    设置为NO：不等待当前线程执行完，就在主线程上执行gameStart方法。
    //    如果，当前线程就是主线程，那么gameStart方法会马上执行。
    [self performSelectorOnMainThread:@selector(gameStart:type:direction:)
                           withObject:nil
                        waitUntilDone:YES];
}

- (void) tvInfo:(NSString*)info
        address:(int)ip
{
    tv_info = info;
    tv_ip = ip;
    [self performSelectorOnMainThread:@selector(showTv:addr:)
                           withObject:nil
                        waitUntilDone:YES];
}


@end