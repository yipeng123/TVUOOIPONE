//
//  monitorTV.h
//  gameUI
//
//  Created by yibin chen on 14-06-10.
//  Copyright (c) 2014年 yibin chen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Delegate.h"
#import "ParseJson.h"
#import "StartUI.h"
#import "TvInfo.h"





@interface monitorTV : UIViewController<StartUI>
{
    NSMutableArray *tvInfoArray;
    Delegate *delegate;
}
- (void) initData;
+ (monitorTV *)init;
- (void) notiftyTvInfo:(NSString *)tvInfo
               address:(int)ip;
@property (retain, nonatomic) NSMutableArray *tvInfoArray;

@end
