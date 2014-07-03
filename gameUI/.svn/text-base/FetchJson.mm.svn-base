//
//  FetchJson.m
//  ParseJSON
//
//  Created by xubo on 5/29 星期四.
//  Copyright (c) 2014年 xubo. All rights reserved.
//

#import "FetchJson.h"

@implementation FetchJson

@synthesize delegate;

//初始化
- (FetchJson*) initWithUrl:(NSString *)address
                  jsonType:(NSString*)tag
                   isArray:(BOOL)yesNo
{
    if(self = [super init])
    {
        jsonTag = tag;
        url = address;
        isArray = yesNo;
    }
    return (self);
}
- (void) fetchJson
{
    NSURL *addr = [NSURL URLWithString: url];
    
    ASIHTTPRequest *request;
    request = [ASIHTTPRequest requestWithURL: addr];
    error = [request error];
    [request setDelegate:self];
    [request startAsynchronous];
    
}

//connect failued;
- (void) requestFailed: (ASIHTTPRequest*)request
{
    NSLog(@"获取json失败");
}

//connect success;
- (void) requestFinished: (ASIHTTPRequest*)request
{
    NSLog(@"获取json成功");
    NSString *jsonMsg = [request responseString];
    NSData *data = [jsonMsg dataUsingEncoding: NSUTF8StringEncoding];
    
    
    if(isArray)     //json最外层是数组
    {
        NSMutableArray *gameArray = [NSJSONSerialization JSONObjectWithData: data
                                                                    options:NSJSONReadingMutableLeaves
                                                                      error:&error];
        
        //    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data
        //                                                        options:NSJSONReadingMutableLeaves
        //                                                          error:&error];
        
        if(delegate != nil)
        {
            
            [delegate getGameInfoArrayFromNet:gameArray
                                     jsonType:jsonTag];
            
        }
    }
    else        //json最外层是对象
    {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:NSJSONReadingMutableLeaves
                                                                     error:&error];
        if(delegate != nil)
        {
            
            [delegate getGameInfoFromNet:dictionary
                                jsonType:jsonTag];
        }
        
    }

}



- (void) dealloc
{
    [delegate release];
    [super dealloc];
}

//- (void) getGameInfoFromNet:(GameInfo*)gameInfo
//{
//    NSLog(@"lsdkjf;s");
//}

//-(GameInfo*) getGameInfo:(NSDictionary*)gameJson
//{
//    NSDictionary *dic = gameJson;
//    GameInfo *gameInfo = [[GameInfo alloc] init];
//    for(id key in dic)
//    {
//        if(key)
//        {
//             NSLog(@"%@", key);
//            [[gameInfo keyArray] addObject: key];
//            [[gameInfo valueArray] addObject: [dic objectForKey:key]];
//        }
//    }
//    return (gameInfo);
//}

@end
