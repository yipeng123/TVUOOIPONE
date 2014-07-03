//
//  gameIntroduce.m
//  gameUI
//
//  Created by yibin chen on 14-06-04.
//  Copyright (c) 2014年 yibin chen. All rights reserved.
//

#import "gameIntroduce.h"
#import <QuartzCore/QuartzCore.h>

@interface gameIntroduce ()

@end

@implementation gameIntroduce
@synthesize headImage;
@synthesize exchangeString;
@synthesize gameLabel;
@synthesize gameName;
@synthesize gameSize;
@synthesize gameState;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
       
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad]; 
	// Do any additional setup after loading the view.
    
    
    NSURL *url=[NSURL URLWithString:exchangeString.icon_url];
    headImage.image  =[[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:url]];
    [headImage setImage:[[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:url]]];
    
    if(exchangeString==NULL)
    {
        printf("传值为空");
    }else
    {
        printf("传值不为空");
    }

    gameLabel.text =exchangeString.text;
    gameName.text = exchangeString.name;
    gameSize.text = [NSString stringWithFormat:@"大小:  %d M",(int)exchangeString.sizes.floatValue/1024/1024];

 


}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [headImage release];
    [gameLabel release];
    [gameName release];
    [gameState release];
    [gameSize release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setHeadImage:nil];
    [self setGameLabel:nil];
    [self setGameName:nil];
    [self setGameState:nil];
    [self setGameSize:nil];
    [super viewDidUnload];
}
@end
