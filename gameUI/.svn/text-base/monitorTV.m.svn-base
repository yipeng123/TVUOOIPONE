//
//  monitorTV.m
//  gameUI
//
//  Created by yibin chen on 14-06-10.
//  Copyright (c) 2014年 yibin chen. All rights reserved.
//

#import "monitorTV.h"
#import "gameIntroduce.h"

@interface monitorTV ()

@end

@implementation monitorTV

@synthesize tvInfoArray;

//回调函数
- (void) startGame:(NSString*) gameId
              type:(int)gameType
         direction:(int)gameDirection
{
}


- (void) notiftyTvInfo:(NSString *)tvInfo
            address:(int)ip
{

//    
//   // NSLog(@"--------ip: %@", tv.name);
//    TvInfo *tv = [ParseJson parseTvInfoJsonWithString:tvInfo];
//    if([tvInfoArray count] == 0)
//    {
//        [tvInfoArray addObject:tv];
//    }
//    else
//    {
//        for(TvInfo* info in tvInfoArray)
//        {
//            if(tv.tv_ip == info.tv_ip)
//                return ;
//        }
//        [tvInfoArray addObject:tv];
//    }
//    


}


- (void) showTvInfo:(NSString*) tvInfo
            address:(int)ip
{
    char* st = parseIp(ip);
    NSString *ip_str =  [NSString stringWithFormat:@"%s", st];
    
    TvInfo *tv = [ParseJson parseTvInfoJsonWithString:tvInfo];
    [tv setTv_ip:ip];
    [tv setStr_tv_ip:ip_str];
}

- (void) initData
{
    
}



+ (monitorTV *)init
{
    static monitorTV *instance;
    
    @synchronized(self)
    {
        if(!instance)
        {
            instance = [[monitorTV alloc] init];
        }
    }
    
    
    return (instance);
    
}

- (void) dealloc
{
    [tvInfoArray release];
    [super dealloc];
}

@end
