//
//  OrientationNavigationController.m
//  gameUI
//
//  Created by yibin chen on 14-05-27.
//  Copyright (c) 2014年 yibin chen. All rights reserved.
//

#import "OrientationNavigationController.h"

@interface OrientationNavigationController ()

@end

@implementation OrientationNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-支持自动转屏
-(NSUInteger)supportedInterfaceOrientations
{
    //返回顶层视图支持的旋转方向
    
    
    
    return self.supportedInterfaceOrientations;
}
- (BOOL)shouldAutorotate
{
    //返回顶层视图的设置
    return self.shouldAutorotate;
}


@end
