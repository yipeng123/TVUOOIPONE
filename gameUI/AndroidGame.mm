//
//  AndroidGame.m
//  gameUI
//
//  Created by yibin chen on 14-06-27.
//  Copyright (c) 2014年 yibin chen. All rights reserved.
//

#import "AndroidGame.h"
#import "ZipArchive.h"
#import "KeyBean.h"

@interface AndroidGame ()
{
    FetchJson *fetchJson;
    
    BOOL label1 ;       //判断按钮是否按下
    BOOL label2 ;
    
    float radioX ;
    float radioY ;
    CGPoint startPoint;
    
    UIImageView *imageview[15];
    
    GameInfo *appRecord;
    NSString *path;
    
    float buttonXy[3][2];
    UITouch * g_point[15];
 
}
@end

@implementation AndroidGame

@synthesize single;
//@synthesize appRecord;
@synthesize GameBackgroundImage;
@synthesize GameMaxView;
@synthesize Gameview;
@synthesize HandMaxView;
@synthesize HandView;

@synthesize VoiceMin;
@synthesize VoicMax;
@synthesize VoicMAXHAND;
@synthesize VoicMaxHand;
@synthesize ReturnGame;
@synthesize ReturnGameHand;
@synthesize shakeBUtton;
@synthesize shakeButtonHand;
@synthesize NOVoic;
@synthesize NoVoicHand;
@synthesize HandDownOk;
@synthesize Hand;
@synthesize HandTou;
@synthesize keybean;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//不支持转屏
- (BOOL)shouldAutorotate{
    return NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    //设置应用程序的状态栏到指定的方向
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
    //view旋转
    [self.view setTransform:CGAffineTransformMakeRotation(M_PI/2)];
    
    self.view.multipleTouchEnabled =YES;        //设置可以接受多点事件
    
    single = [Singleton getInstance];
    
    if(GameBackgroundImage.tag == 1)
    {
    
        
            fetchJson = [[FetchJson alloc] initWithUrl:  [NSString stringWithFormat:@"http://a.wap3.cn//entry/gameinfo.jsp?gameid=%d", [single.Game_ID  intValue]]  jsonType:@"GameInfo" isArray:NO];
            //设置委托对象
            [fetchJson setDelegate: self];

            //开始解析
            [fetchJson fetchJson];

    }
}



- (void) conncetGameButton
{
//    [super viewDidAppear:animated];
    
    dispatch_queue_t queue = dispatch_get_global_queue(
                                                       DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSURL *url = [NSURL URLWithString:appRecord.img_zip_url];
        NSLog(@"%@",appRecord.img_zip_url);
        NSError *error = nil;
        NSData *data = [NSData dataWithContentsOfURL:url options:0 error:&error];
        
        if(!error)
        {
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
      
            path = [paths objectAtIndex:0];
            NSString *zipPath = [path stringByAppendingPathComponent:@"zipfile.zip"];
          
            [path retain];
            [data writeToFile:zipPath options:0 error:&error];
            
            if(!error)
            {
                ZipArchive *za = [[ZipArchive alloc] init];
                if ([za UnzipOpenFile: zipPath]) {
                    BOOL ret = [za UnzipFileTo: path overWrite: YES];
                    if (NO == ret){} [za UnzipCloseFile];
                    
                    for(int i =0 ; [appRecord.press count] > i; i++)
                    {
                        KeyBean * bin = [appRecord.press objectAtIndex:i];

                        float X =  1300/(self.view.frame.size.height - 120);
                        float Y =  768/(self.view.frame.size.width -40);
                        
                    
                        
                        NSString *imageFilePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%d_up.jpg", [bin.keys intValue]]];

                        
                      
                        
                    NSData *imageData = [NSData dataWithContentsOfFile:imageFilePath options:0 error:nil];
                    UIImage *img = [UIImage imageWithData:imageData];

                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        if([bin.keys intValue] == 151)
                        {
                           imageview[i]=[[UIImageView alloc] initWithFrame:CGRectMake([bin.x  floatValue]/X,([bin.y floatValue ]+20)/Y,img.size.width/1300*self.view.frame.size.height,img.size.height/768*self.view.frame.size.width)];
                        }else
                        {
                            imageview[i]=[[UIImageView alloc] initWithFrame:CGRectMake([bin.x  floatValue]/X,[bin.y floatValue]/Y,img.size.width/1300*self.view.frame.size.height,img.size.height/768*self.view.frame.size.width)];
                        }
                        
                        imageview[i].image = img;
                        
//                        NSLog(@"size.x = %f,size.y = %f",img.size.width,img.size.height);
 
                         
                            [self.view addSubview:imageview[i]];
                        
      
                        
                    });
                    }}
            }
            else
            {
                NSLog(@"Error saving file %@",error);
            }
        }
        else
        {
            NSLog(@"Error downloading zip file: %@", error);
        }
        
    });
}






-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self.view];
    
    if(CGRectContainsPoint(HandTou.frame, pt))
    {
        if(pt.y + Hand.frame.size.height > HandTou.frame.origin.y + HandTou.frame.size.height || pt.x + Hand.frame.size.width > HandTou.frame.origin.x + HandTou.frame.size.width)
        {
            return;
        }
    
        [Hand setFrame:CGRectMake(pt.x, pt.y, Hand.frame.size.width, Hand.frame.size.height)];
        
        radioX =  [single.cur_tvInfo.winW floatValue]/HandTou.frame.size.width;
        radioY =  [single.cur_tvInfo.winH floatValue]/HandTou.frame.size.height;
        startPoint = pt;
        
        return;
    }

    if([touches count] > 3)return;
    [self GmeViewMonitor:touches];
    
    NSLog(@"count = %d",[touches count]);

}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
//    UITouch *touch = [touches anyObject];
 
    
    
    if(1 == GameBackgroundImage.tag)
    {
        for(int i =0 ; i < [appRecord.press count] ; i++)
        {
            if(g_point[i].phase ==3 && g_point[i] != NULL)
            {
                KeyBean * bin = [appRecord.press objectAtIndex:i];
            
                NSString *imageFilePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%d_up.jpg", [bin.keys intValue]]];
                NSData *imageData = [NSData dataWithContentsOfFile:imageFilePath options:0 error:nil];
                UIImage *img = [UIImage imageWithData:imageData];
                [imageview[i] setImage:img];
                imageview[i].tag = 0;
                g_point[i]=NULL;
                
                int num = [touches count] -1;
                
                if(num == 0)
                {
                    sendMouseTouch(num*256+6, 1, 0, buttonXy[0][0], buttonXy[0][1], 0, 0, 0, 0, 0, 0, single.cur_tvInfo.tv_ip);
                    
                }
                else if(num ==1)
                {
                    sendMouseTouch(num*256+6, 2, 0, buttonXy[0][0], buttonXy[0][1], 1, buttonXy[1][0], buttonXy[1][1], 0, 0, 0, single.cur_tvInfo.tv_ip);
                }else if(num ==2)
                {
                    sendMouseTouch(num*256+6, 3, 0, buttonXy[0][0], buttonXy[0][1], 1, buttonXy[1][0], buttonXy[1][1], 2, buttonXy[2][0], buttonXy[2][1], single.cur_tvInfo.tv_ip);
                }

            }
            
        }
        
    }


}

-(void)GmeViewMonitor:(NSSet *)touches
{
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self.view];
    
    if(1 == GameBackgroundImage.tag)
    {

        for(int i =0 ; i < [appRecord.press count] ; i++)
        {
            if(CGRectContainsPoint(imageview[i].frame, pt) && imageview[i].tag == 0)
            {
                KeyBean * bin = [appRecord.press objectAtIndex:i];
                
                NSString *imageFilePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%d_down.jpg", [bin.keys intValue]]];
                NSData *imageData = [NSData dataWithContentsOfFile:imageFilePath options:0 error:nil];
                UIImage *img = [UIImage imageWithData:imageData];
                [imageview[i] setImage:img];
                imageview[i].tag = 1;
                g_point[i] = touch;
                
                int num = [touches count]-1;
                float w = [single.cur_tvInfo.winW floatValue]/1920;
                float h = [single.cur_tvInfo.winH floatValue]/1080;
                
                if(num == 0)
                {
                    
                    buttonXy[num][0] = [bin.tv_x floatValue] * w;
                    buttonXy[num][1] = [bin.tv_y floatValue] * h;
                    sendMouseTouch(num, 1, 0, buttonXy[0][0], buttonXy[0][1], 0, 0, 0, 0, 0, 0, single.cur_tvInfo.tv_ip);
                }
                else if(num ==1)
                {
                    buttonXy[num][0] = [bin.tv_x floatValue] * w;
                    buttonXy[num][1] = [bin.tv_y floatValue] * h;
                    sendMouseTouch(num*256+5, 2,0, buttonXy[0][0],buttonXy[0][1], 1, buttonXy[0][0], buttonXy[0][0], 0, 0, 0, single.cur_tvInfo.tv_ip);
                }else if(num ==2)
                {
                    buttonXy[num][0] = [bin.tv_x floatValue] * w;
                    buttonXy[num][1] = [bin.tv_y floatValue] * h;
                    sendMouseTouch(num*256+5, 3, 0, buttonXy[0][0], buttonXy[1][0], 1, buttonXy[1][0], buttonXy[1][1], 2,buttonXy[2][0], buttonXy[2][1], single.cur_tvInfo.tv_ip);
                }
                
            NSLog(@"tvx = %f tvy = %f ",buttonXy[0][0],buttonXy[0][1]);
            

            }else if((!CGRectContainsPoint(imageview[i].frame, [g_point[i] locationInView:self.view])) && g_point[i].phase == 1)
            {
                KeyBean * bin = [appRecord.press objectAtIndex:i];
                
                NSString *imageFilePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%d_up.jpg", [bin.keys intValue]]];
                NSData *imageData = [NSData dataWithContentsOfFile:imageFilePath options:0 error:nil];
                UIImage *img = [UIImage imageWithData:imageData];
                [imageview[i] setImage:img];
                imageview[i].tag = 0;
                g_point[i] = NULL;

            }
            
        }
        
    }


}



-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self.view];

    if(CGRectContainsPoint(HandTou.frame, pt))
    {
        if(pt.y + Hand.frame.size.height > HandTou.frame.origin.y + HandTou.frame.size.height || pt.x + Hand.frame.size.width > HandTou.frame.origin.x + HandTou.frame.size.width)
        {
            return;
        }
        [Hand setFrame:CGRectMake(pt.x, pt.y, Hand.frame.size.width, Hand.frame.size.height)];
        
         sendMouseEvent(2, (pt.x-startPoint.x)*radioX, (pt.y-startPoint.y)*radioY, single.cur_tvInfo.tv_ip, [single.cur_tvInfo.udpPort intValue]);
        startPoint = pt;
        
        return;
    }
    
   [self GmeViewMonitor:touches];

}

//-(void)gameMode
//{
//    
//
//}




-(void) getGameInfoFromNet:(NSDictionary*)dic
                  jsonType:tag
{

    appRecord = [ParseJson parseJson:dic];
    [self conncetGameButton];


    
    
    
    NSURL *url=[NSURL URLWithString:appRecord.loading_url];
    GameBackgroundImage.image =[[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:url]];
    NSLog(@"app.anme = %@ , count = %d  ,app.type  = %d",appRecord.name, [appRecord.press count] ,[appRecord.game_id intValue]);
    
    
    
    
    
    
}






















- (void) showTvInfo
{
}



//-(void)viewWillAppear:(BOOL)animated
//{
//    //隐藏navigationController
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
//    //隐藏状态栏
//    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    //显示状态栏
//    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
//    //显示navigationController
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    
//}















- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [GameBackgroundImage release];
    [Gameview release];
    [HandView release];
    [GameMaxView release];
    [HandMaxView release];
    [VoiceMin release];
    [VoicMax release];
    [VoicMax release];
    [ReturnGame release];
    [shakeBUtton release];
    [NOVoic release];
    [shakeButtonHand release];
    [NoVoicHand release];
    [VoicMaxHand release];
    [VoicMAXHAND release];
    [ReturnGameHand release];
    [keybean release];
    [HandTou release];
    [Hand release];
    [HandDownOk release];
    
    for(int i=0;i<[appRecord.press count];i++)
    {
        [imageview[i] release];
    }
    [appRecord release];
    [path release];
    [super dealloc];
}
- (IBAction)CilkeGameFun:(id)sender {
    [UIView animateWithDuration:0.5 animations:^{
        
        [self.Gameview setFrame:CGRectMake(268, 0, 212, 320)];
    }];
    
}

- (IBAction)ClikeHandFun:(id)sender {
    [UIView animateWithDuration:0.5 animations:^{
        
        [self.HandView setFrame:CGRectMake(268, 0, 212, 320)];
    }];
   
    
}

- (IBAction)ClikeGameNo:(id)sender {
    
    [UIView animateWithDuration:0.5 animations:^{
        
        [self.Gameview setFrame:CGRectMake(480, 0, 212, 320)];
    }];
}

- (IBAction)ClikeHandNo:(id)sender {
    
    [UIView animateWithDuration:0.5 animations:^{
        
        [self.HandView setFrame:CGRectMake(480, 0, 212, 320)];
    }];
}

- (IBAction)Clickzhend:(id)sender {
    
    if(label1)
    {
        single.vibrate_flag2 = NO;
        [shakeBUtton setBackgroundImage:[UIImage imageNamed:@"kaiguan2.png"] forState:UIControlStateNormal];
        label1 = NO;
    }else
    {
        single.vibrate_flag2 = YES;
        [shakeBUtton setBackgroundImage:[UIImage imageNamed:@"kaiguan1.png"] forState:UIControlStateNormal];
        label1 = YES;
    }

    
}

- (IBAction)ClikeNoVoic:(id)sender {
    
    if(label2)
    {
        single.vibrate_flag2 = NO;
        [NOVoic setBackgroundImage:[UIImage imageNamed:@"kaiguan2.png"] forState:UIControlStateNormal];
        label2 = NO;
    }else
    {
        single.vibrate_flag2 = YES;
        [NOVoic setBackgroundImage:[UIImage imageNamed:@"kaiguan1.png"] forState:UIControlStateNormal];
        label2 = YES;
    }
    
}

- (IBAction)ClikeVoicMaxDown:(id)sender {   VoiceMin.backgroundColor = [UIColor colorWithRed:110/255.0 green:123/255.0 blue:139/255.0 alpha:1.0];
}

- (IBAction)ClikeVoicMaxUp:(id)sender {     VoicMax.backgroundColor = [UIColor whiteColor];
}

- (IBAction)ClikeVoicMinUp:(id)sender {    VoiceMin.backgroundColor = [UIColor whiteColor]; 
}

- (IBAction)ClikeVoicMAXDown:(id)sender {  VoicMax.backgroundColor = [UIColor colorWithRed:110/255.0 green:123/255.0 blue:139/255.0 alpha:1.0];
}


- (IBAction)ClikeReturnGame:(id)sender {    ReturnGame.backgroundColor = [UIColor colorWithRed:110/255.0 green:123/255.0 blue:139/255.0 alpha:1.0];
    [self.navigationController popViewControllerAnimated:YES];   [appRecord release]; appRecord = NULL;
}

- (IBAction)ClikezhenHand:(id)sender {
    
    if(label1)
    {
        single.vibrate_flag2 = NO;
        [shakeButtonHand setBackgroundImage:[UIImage imageNamed:@"kaiguan2.png"] forState:UIControlStateNormal];
        label1 = NO;
    }else
    {
        single.vibrate_flag2 = YES;
        [shakeButtonHand setBackgroundImage:[UIImage imageNamed:@"kaiguan1.png"] forState:UIControlStateNormal];
        label1 = YES;
    }

}

- (IBAction)ClikeNoVoicHand:(id)sender {
    
    if(label2)
    {
        single.vibrate_flag2 = NO;
        [NoVoicHand setBackgroundImage:[UIImage imageNamed:@"kaiguan2.png"] forState:UIControlStateNormal];
        label2 = NO;
    }else
    {
        single.vibrate_flag2 = YES;
        [NoVoicHand setBackgroundImage:[UIImage imageNamed:@"kaiguan1.png"] forState:UIControlStateNormal];
        label2 = YES;
    }

    
}

- (IBAction)ClikeVoicMaxHand:(id)sender {   VoicMaxHand.backgroundColor = [UIColor colorWithRed:110/255.0 green:123/255.0 blue:139/255.0 alpha:1.0];
}

- (IBAction)ClikeVoicMaxHandUp:(id)sender { VoicMaxHand.backgroundColor = [UIColor whiteColor];
}

- (IBAction)ClikeVoicMinHandDown:(id)sender {   VoicMAXHAND.backgroundColor = [UIColor colorWithRed:110/255.0 green:123/255.0 blue:139/255.0 alpha:1.0];
}

- (IBAction)ClikeVoicMinHandUp:(id)sender {     VoicMAXHAND.backgroundColor = [UIColor whiteColor];
}

- (IBAction)ClikeReturnGameHand:(id)sender {    ReturnGameHand.backgroundColor = [UIColor colorWithRed:110/255.0 green:123/255.0 blue:139/255.0 alpha:1.0];
    [self.navigationController popViewControllerAnimated:YES];   [appRecord release]; appRecord = NULL;
}

- (IBAction)OkHandDown:(id)sender { sendPSPEvent(0, "1006", 0, single.cur_tvInfo.tv_ip);
}

- (IBAction)OKHand:(id)sender {  NSLog(@"单击确认");    sendPSPEvent(1, "1006", 0, single.cur_tvInfo.tv_ip);
    NSLog(@"%d gameInfo",single.cur_tvInfo.tv_ip);
}

- (IBAction)NoHand:(id)sender {  NSLog(@"单击回退");    sendPSPEvent(0, "2009", 0, single.cur_tvInfo.tv_ip);
    sendPSPEvent(1, "2009", 0, single.cur_tvInfo.tv_ip);
}




@end
