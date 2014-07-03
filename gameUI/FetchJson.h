//
//  FetchJson.h
//  ParseJSON
//
//  Created by xubo on 5/29 星期四.
//  Copyright (c) 2014年 xubo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ProcessJson.h"
#import "ParseJson.h"
#import "ProcessJson.h"

@interface FetchJson : NSObject //<ProcessJson>
{
    NSString *jsonTag;
    NSString *url;
    NSError *error;
    BOOL isArray;
    
    NSDictionary *gameDic;
    NSDictionary *otherGameDic;
    
    NSMutableArray *game;
    //other game;
    NSMutableArray *otherGame;
    
    GameInfo *gameInfo;
    
    id<ProcessJson> delegate;
    
}

- (void) fetchJson;
- (FetchJson*) initWithUrl:(NSString*)address
                  jsonType:(NSString*)tag
                   isArray:(BOOL)yesNo;
@property (retain,nonatomic) id<ProcessJson> delegate;
@end
