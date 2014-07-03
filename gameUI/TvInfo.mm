//
//  TvInfo.m
//  gameUI
//
//  Created by xubo on 6/6 星期五.
//  Copyright (c) 2014年 yibin chen. All rights reserved.
//

#import "TvInfo.h"

@implementation TvInfo

- (TvInfo*) init
{
    if(self = [super init])
    {
    }
    return self;
}



- (void) dealloc
{
    [ip release];
    [capability release];
    [e release];
    [isRooted release];
    [mac release];
    [name release];
    [serverPort release];
    [tag release];
    [udpPort release];
    [udpType release];
    [winH release];
    [winW release];
    [super dealloc];
}
@synthesize date;
@synthesize ip;
@synthesize str_tv_ip;
@synthesize tv_ip;
@synthesize tv_name;

@synthesize capability;
@synthesize e;
@synthesize isRooted;
@synthesize mac;
@synthesize name;
@synthesize serverPort;
@synthesize tag;
@synthesize udpPort;
@synthesize udpType;
@synthesize winH;
@synthesize winW;
@end
