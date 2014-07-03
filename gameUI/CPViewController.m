//
//  CPViewController.m
//  ParseJSON
//
//  Created by xubo on 5/28 星期三.
//  Copyright (c) 2014年 xubo. All rights reserved.
//

#import "CPViewController.h"

@interface CPViewController ()
{
    ParseJson *parseJson;
}
@end

@implementation CPViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
//    NSString *string = @"http://a.wap3.cn//entry/gamegroupinfo.jsp?groupid=9";
    
    
    //initWithUrl参数:1、要解析的json的地址   2、GameInfo   3、这个json最外层是否是数组
    FetchJson *fetchJson = [[FetchJson alloc] initWithUrl:@"http://a.wap3.cn//entry/gamegroupinfo.jsp?groupid=9"
                                                 jsonType:@"GameInfo"
                                                  isArray:YES];

    
    //开始解析
    [fetchJson fetchJson];
    
    //设置委托对象
    [fetchJson setDelegate: self];
    
    
    
	// Do any additional setup after loading the view, typically from a nib.
}

    //如果要解析的json不是数组,则回调此函数
-(void) getGameInfoFromNet:(NSDictionary*)dic
                  jsonType:tag
{
    NSArray *array = [dic objectForKey:@"press"];
    
    NSLog(@"text is: %@", [[array objectAtIndex:6] objectForKey:@"text"]);

}

    //数组
-(void) getGameInfoArrayFromNet:(NSMutableArray*)gameArrayInfo
                       jsonType:(NSString *)tag
{
    if([tag isEqualToString:@"GameInfo"])
    {
        NSLog(@"getGameInfoArrayFromNet");
        GameInfo *gameInfo;
        for(gameInfo in gameArrayInfo)
        {
            NSLog(@"game_text: %@", [gameInfo text]);
        }
    }
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
