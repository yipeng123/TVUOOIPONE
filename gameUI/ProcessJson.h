//
//  ProcessJson.h
//  ParseJSON
//
//  Created by xubo on 5/29 星期四.
//  Copyright (c) 2014年 xubo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameInfo.h"
@protocol ProcessJson <NSObject>

@required
- (void) getGameInfoFromNet:(NSDictionary*)dic
                   jsonType:(NSString*)tag;

@required
- (void) getGameInfoArrayFromNet:(NSMutableArray*)gameArrayInfo
                        jsonType:(NSString*)tag;

@end
