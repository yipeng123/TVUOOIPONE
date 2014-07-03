//
//  Delegate.m
//  gameUI
//
//  Created by xubo on 6/5 星期四.
//  Copyright (c) 2014年 yibin chen. All rights reserved.
//

#import "Singleton.h"
#import "ParseJson.h"

@implementation Singleton
@synthesize game_type;
@synthesize game_direction;
@synthesize game_str;
@synthesize conn_withTv;
@synthesize delegate1;
@synthesize ip_array;
@synthesize cur_tvInfo;
@synthesize Game_ID;

@synthesize vibrate_flag;
@synthesize sound_flag;
@synthesize frame_flag;
@synthesize vibrate_flag2;
@synthesize sound_flag2;


- (void) haveInstalledGameArrayInfo:(NSString*)str
{
    NSObject *object = (NSObject*)delegate1;
    [object performSelectorOnMainThread:@selector(haveInstalledArrayInfo:)
                             withObject:str
                          waitUntilDone:YES];
}
- (void) connStatue:(int)ip
               conn:(int)isConnected
              count:(int)num
{
    if(isConnected == 1)
    {
        
        for(TvInfo *tv in ip_array)
        {
            if(tv.tv_ip == ip)
            {
                cur_tvInfo = tv;
            }
        }
    }
    else
    {
        cur_tvInfo = nil;
    }
    NSNumber *_ip = [NSNumber numberWithInt:ip];
    NSNumber *_isConnected = [NSNumber numberWithInt:isConnected];
    NSNumber *_num = [NSNumber numberWithInt:num];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:3];
    [array addObject:_ip];
    [array addObject:_isConnected];
    [array addObject:_num];
    NSObject *object = (NSObject*)delegate1;
    
    if([delegate1 respondsToSelector:@selector(connectStatue:)])
    {
        [object performSelectorOnMainThread:@selector(connectStatue:)
                                 withObject:array
                              waitUntilDone:YES];
    }
}

//- (void) gameStart:(NSString*) gameId
//              type:(int) gameType
//         direction:(int) gameDirection
//{
//    if(delegate1 != nil)
//    {
//        [delegate1 startGame:game_str
//                        type:game_type
//                   direction:game_direction];
//    }
//}
- (void) initWithData
{
    ip_array = [[NSMutableArray alloc] init];
    timer = [NSTimer timerWithTimeInterval:5
                                    target:self
                                  selector:@selector(check)
                                  userInfo:nil
                                   repeats:YES];
    conn_withTv = TRUE;
}

- (void) check
{
    NSDate *date = [[NSDate alloc] init];
    for (int i = [ip_array count]; i>=0; i--)
    {
        TvInfo *info = (TvInfo*)[ip_array objectAtIndex:i];
        if ([date timeIntervalSinceDate:info.date]>12)
        {
            [ip_array removeObjectAtIndex:i];
            
            NSObject* object = (NSObject*)delegate1;
            if([delegate1 respondsToSelector:@selector(showTvInfo)])
            {
                [object performSelectorOnMainThread:@selector(showTvInfo)
                                         withObject:nil
                                      waitUntilDone:YES];
            }
        }
    }
    [date release];
    
}

+ (Singleton*) getInstance
{
    static Singleton*instance;
    
    @synchronized(self)
    {
        if(!instance)
        {
            instance = [[Singleton alloc] init];
            [instance initWithData];
            
        }
    }
    return (instance);
}


- (void) dealloc
{
    [row release];
    [Game_ID release];
    [ip_array release];
    [delegate1 release];
    [game_str release];
    [cur_tvInfo release];
    [super dealloc];
}

//- (void) getStart:(NSString*)string
//             type:(int)gameType
//        direction:(int)gameDirection
//{
//    game_str = string;
//    game_type = gameType;
//    game_direction = gameDirection;
//    
//    //    如果设置waitUntilDone为YES:等待当前线程执行完以后，主线程才会执行gameStart方法；
//    //    设置为NO：不等待当前线程执行完，就在主线程上执行gameStart方法。
//    //    如果，当前线程就是主线程，那么gameStart方法会马上执行。
//    [self performSelectorOnMainThread:@selector(gameStart:type:direction:)
//                           withObject:nil
//                        waitUntilDone:YES];
//}





- (void) tvInfo:(NSString*)info
        address:(int)ip
{

    NSDate *date = [[NSDate alloc] init];
    
    TvInfo *tv = [ParseJson parseTvInfoJsonWithString:info];
    tv.tv_ip = ip;
    tv.date = date;
    
    [date release];
    
    if([ip_array count] == 0)
    {
        [ip_array addObject:tv];
    }
    else
    {
        BOOL isInArray = false;
        
        for(int i=0; i<[ip_array count]; ++i)
        {
            TvInfo* tempInfo = (TvInfo*)[ip_array objectAtIndex:i];
            if(tempInfo.tv_ip == tv.tv_ip)
            {
                [ip_array setObject:tv
                 atIndexedSubscript:i];
                 isInArray = true;
                
            }
        }
        if(!isInArray)
        {
            [ip_array addObject:tv];
        }
    }

    NSObject* object = (NSObject*)delegate1;
    [object performSelectorOnMainThread:@selector(showTvInfo)
                             withObject:nil
                          waitUntilDone:YES];
}

@synthesize pNum;
@synthesize row;
@synthesize flag;
@end