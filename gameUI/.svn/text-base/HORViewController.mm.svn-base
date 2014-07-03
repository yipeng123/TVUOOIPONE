//
//  HORViewController.m
//  gameUI
//
//  Created by yibin chen on 14-05-27.
//  Copyright (c) 2014年 yibin chen. All rights reserved.
//

#import "HORViewController.h"
@interface HORViewController ()
{
    
    float radioX;
    float radioY;
    BOOL label1 ;       //判断按钮是否按下
    BOOL label2 ;
    
    
    UIImageView * buttonA;
    UIImageView * buttonB;
    UIImageView * buttonC;
    UIImageView * buttonD;
    
    
    CGPoint startPoint;
    UIImageView *hand2 ;
    UIImageView *mouse2 ;
    UIImageView *hand1;
    UIImageView *mouse1 ;
    
    
    int direction[9] ;
    int ABCD[4];
    
    UITouch * g_pointA;
    UITouch * g_pointB;
    
    UITouch * g_pointC;
    UITouch * g_pointD;
    UITouch * g_point;
    
   
}
@end

@implementation HORViewController
@synthesize settings;
@synthesize lockerView;
@synthesize lockerButtonVibration;
@synthesize lockerButtonVoice;
@synthesize buttonAddVoice;
@synthesize buttonCutVoice;
@synthesize buttonMenu;
@synthesize buttonOut;
@synthesize buttonSystem;
@synthesize buttonConncet;
@synthesize buttonMouse;
@synthesize single;
@synthesize bottom2;


- (void)dealloc
{
    [settings release];
    [crank1 release];
    [bottom1 release];
    [_functionButton release];
    [_gameButton release];
    [_insertButton release];
    [_gameButton release];
    [_insertButton release];
    [lockerView release];
    [lockerButtonVibration release];
    [lockerButtonVoice release];
    [buttonAddVoice release];
    [buttonCutVoice release];
    [buttonSystem release];
    [buttonMenu release];
    [buttonOut release];
    [buttonConncet release];
    [single release];
    [bottom2 release];
    [super dealloc];
}


-(void)setDirection: (int)dir
{
    
    
    
    
    
//    sendPSPEvent(1, "2055", 0, single.cur_tvInfo.tv_ip);
//    sendPSPEvent(1, "2056", 0, single.cur_tvInfo.tv_ip);
//    sendPSPEvent(1, "2057", 0, single.cur_tvInfo.tv_ip);
//    sendPSPEvent(1, "2058", 0, single.cur_tvInfo.tv_ip);
    
//    if(dir==direction[0])return;
    
    if(2 == direction[0])
    {
        sendPSPEvent(1, "2056", 0, single.cur_tvInfo.tv_ip);

//        direction[2] = 0;
        
        
        NSLog(@"dir[0] xia= %d",direction[0]);
   
    }else if(3 == direction[0])
    {
        sendPSPEvent(1, "2057", 0, single.cur_tvInfo.tv_ip);
//        direction[3] = 0;

        NSLog(@"dir[0] zuo= %d",direction[0]);
    }else if(4 == direction[0])
    {
        sendPSPEvent(1, "2058", 0, single.cur_tvInfo.tv_ip);
        NSLog(@"dir[0] you= %d",direction[0]);
//        direction[4] = 0;
    }else if(1 == direction[0])
    {
        sendPSPEvent(1, "2055", 0, single.cur_tvInfo.tv_ip);
//        direction[1] = 0;
        
        NSLog(@"dir[0] shang= %d",direction[0]);
    }else if(5 == direction[0])
    {
        sendPSPEvent(1, "3005", 0, single.cur_tvInfo.tv_ip);
        NSLog(@"dir[0] zoushang= %d",direction[0]);
    }else if(6 == direction[0])
    {
        sendPSPEvent(1, "3006", 0, single.cur_tvInfo.tv_ip);
        NSLog(@"dir[0] youshang= %d",direction[0]);
    }else if(7 == direction[0])
    {
        sendPSPEvent(1, "3008", 0, single.cur_tvInfo.tv_ip);
        NSLog(@"dir[0] zuoxia= %d",direction[0]);
    }else if(8 == direction[0])
    {
        sendPSPEvent(1, "3007", 0, single.cur_tvInfo.tv_ip);
        NSLog(@"dir[0] youxia= %d",direction[0]);
    }
    
    if(dir != 0)
    {
        direction[1] = 0;
        direction[2] = 0;
        direction[3] = 0;
        direction[4] = 0;
        direction[5] = 0;
        direction[6] = 0;
        direction[7] = 0;
        direction[8] = 0;
        direction[dir] = 1;
    }
    
    direction[0] = dir;

}




-(void)touchesMoved:(NSSet *)touches
          withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];

    CGPoint pt = [touch locationInView:self.view];

    
    if(bottom1.tag == 121)
    {

        
        if(   CGRectContainsPoint(bottom1.frame, pt) && g_point.phase == 1   )
        {

            

            [self GmeViewMonitor:touch];
            
        }
        
            [self ABCDViewMonitor:touches];
        
        return;
    }
    
    
    
    if(CGRectContainsPoint([hand2 frame],pt))
    {
        CGPoint point = [touch  locationInView:self.view];
        CGRect  frame = hand1.frame;
        frame.origin = point;
        
        if(hand2.frame.origin.x+2>frame.origin.x||hand2.frame.origin.y+2>frame.origin.y||hand2.frame.size.width+hand2.frame.origin.x-35<frame.origin.x||hand2.frame.size.height+hand2.frame.origin.y-54<frame.origin.y)
        {
            return;
        }
        
        hand1.frame = frame;
        
    }
    
    if(CGRectContainsPoint([mouse2 frame],pt))
    {
        CGPoint point = [touch  locationInView:self.view];
        CGRect  frame =mouse1.frame;
        frame.origin = point;
        
        if(mouse2.frame.origin.x+2>frame.origin.x||mouse2.frame.origin.y+2>frame.origin.y||mouse2.frame.size.width+mouse2.frame.origin.x-39<frame.origin.x||mouse2.frame.size.height+mouse2.frame.origin.y-46<frame.origin.y)
        {
            return;
        }
        
        mouse1.frame = frame;
      
        
        CGFloat dx =  frame.origin.x - startPoint.x;
        CGFloat dy = frame.origin.y -startPoint.y;
      
        startPoint = CGPointMake(frame.origin.x, frame.origin.y);
        if(single != nil)
        {
            sendMouseEvent(2, dx*radioX, dy*radioY, single.cur_tvInfo.tv_ip, [single.cur_tvInfo.udpPort intValue]);
        }

    }
    
    
}




-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event//如系统决定取消此次触摸，那可能就不调用touchesEnded方法了，在这种情况下会调用touchesCancelled方法
{
    [self touchesEnded:touches withEvent:event];
    
}



- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
//    UITouch *touch = [touches anyObject];
    
//    CGPoint pt = [touch locationInView:self.view];
    
    
   
    
    if(bottom1.tag == 121 )
    {
    
        if(g_point.phase == 3 && g_point!=NULL)
        {
        //方向抬起
        
            [self setDirection:0];
        
            direction[1] = 0;
            direction[2] = 0;
            direction[3] = 0;
            direction[4] = 0;
            direction[5] = 0;
            direction[6] = 0;
            direction[7] = 0;
            direction[8] = 0;
  
            crank1.center = bottom1.center;
            g_point = NULL;
        }
        
        
        if(g_pointA !=NULL && g_pointA.phase == 3)
            
        {
            ABCD[0]=0;
            sendPSPEvent(1, "2061", 0, single.cur_tvInfo.tv_ip);
            g_pointA = NULL;
            [buttonA setImage:[UIImage imageNamed:@"jieji_anx1.png"]];
        }else if(g_pointB != NULL && g_pointB.phase == 3)
        {
            ABCD[1]=0;
            sendPSPEvent(1, "2062", 0, single.cur_tvInfo.tv_ip);
            [buttonB setImage:[UIImage imageNamed:@"jieji_any1.png"]];
            g_pointB = NULL;
        }else if(g_pointC != NULL && g_pointC.phase ==3)
        {
            ABCD[2]=0;
            sendPSPEvent(1, "2060", 0, single.cur_tvInfo.tv_ip);
            [buttonC setImage:[UIImage imageNamed:@"jieji_anb1.png"]];
            g_pointC=NULL;
        }else if(g_pointD != NULL && g_pointD.phase ==3)
        {
            ABCD[3]=0;
            [buttonD setImage:[UIImage imageNamed:@"jieji_ana1.png"]];
            sendPSPEvent(1, "2059", 0, single.cur_tvInfo.tv_ip);
            g_pointD=NULL;
        }
        
        return;
    }
    
    
    
}


-(void)GmeViewMonitor:(UITouch *)touch
{
    CGPoint pt = [touch locationInView:self.view];
   

    
  
    
    
    
        crank1.center = pt;
        if(pt.y < bottom2.frame.origin.y)
        {
            
            
            if(pt.x < bottom2.frame.origin.x && pt.y < bottom2.frame.origin.y)
            {
                
                
                if(direction[5] == 0)
                {
                    [self setDirection:5];
                    
                    sendPSPEvent(0, "3005", 0, single.cur_tvInfo.tv_ip);
                }
                
            }else if(direction[1] == 0)
            {
                NSLog(@"dir[1] =  %d",direction[1]);

                if(single.vibrate_flag2 == TRUE)
                {
                    NSLog(@"s震动");
                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                }
                if(single.sound_flag2 == TRUE)
                {
                    NSLog(@"s声音");
                    AudioServicesPlaySystemSound(soundId);
                }


                [self setDirection:1];
                sendPSPEvent(0, "2055", 0, single.cur_tvInfo.tv_ip);
            }
            
        }else if(pt.y > bottom2.frame.origin.y+bottom2.frame.size.height)
        {
            if(pt.x > bottom2.frame.origin.x+bottom2.frame.size.width)
            {

                NSLog(@"右下");
                
                if(direction[7] == 0)
                {
                    [self setDirection:7];
                    
                    sendPSPEvent(0, "3008", 0, single.cur_tvInfo.tv_ip);
                }
            }else if(direction[2] == 0)
            {

                if(single.vibrate_flag2 == TRUE)
                {
                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                }
                if(single.sound_flag2 == TRUE)
                {
                    AudioServicesPlaySystemSound(soundId);
                }

                NSLog(@"dir[2] =  %d",direction[2]);
                [self setDirection:2];
                sendPSPEvent(0, "2056", 0, single.cur_tvInfo.tv_ip);

            }
        }else if(pt.x < bottom2.frame.origin.x)
        {
            
            
            
            if(pt.y > bottom2.frame.origin.y+bottom2.frame.size.height-15)
            {

                NSLog(@"左下");
                
                if(direction[8] == 0)
                {
                    [self setDirection:8];
                    
                    sendPSPEvent(0, "3007", 0, single.cur_tvInfo.tv_ip);
                }
            }else if(direction[3] == 0)
            {

                if(single.vibrate_flag2 == TRUE)
                {
                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                }
                if(single.sound_flag2 == TRUE)
                {
                    AudioServicesPlaySystemSound(soundId);
                }

                NSLog(@"dir[3] =  %d",direction[3]);
                [self setDirection:3];
                sendPSPEvent(0, "2057", 0, single.cur_tvInfo.tv_ip);

            }
        }else if(pt.x > bottom2.frame.origin.x+bottom2.frame.size.width)
        {
            NSLog(@"%f %f ",pt.y,bottom2.frame.origin.y);
            if( pt.y-15 < bottom2.frame.origin.y)
            {

                NSLog(@"右上");
                
                if(direction[6] == 0)
                {
                    [self setDirection:6];
                    
                    sendPSPEvent(0, "3006", 0, single.cur_tvInfo.tv_ip);
                }
                
            }else if(direction[4] == 0)
            {

                if(single.vibrate_flag2 == TRUE)
                {
                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                }
                if(single.sound_flag2 == TRUE)
                {
                    AudioServicesPlaySystemSound(soundId);
                }

                NSLog(@"dir[4] =  %d",direction[4]);
                [self setDirection:4];
                sendPSPEvent(0, "2058", 0, single.cur_tvInfo.tv_ip);

          
            }
        }
    
    
        


        
}




-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    if( TRUE == single.flag )
    {
        [buttonConncet setTitle:@"已连接设备" forState: UIControlStateNormal];
    }else
    {
        [buttonConncet setTitle:@"未连接设备" forState: UIControlStateNormal];
    }
    
        
   


    
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self.view];
    
    if(bottom1.tag == 121)
    {
      
 
     
        
        
        for (UITouch *touchD in touches)

        {
            if(CGRectContainsPoint(bottom1.frame, pt) )
            {
                    g_point = touch;
            }
        }
    
      
    
    if(CGRectContainsPoint(bottom1.frame, pt))
    {

            [self GmeViewMonitor:touch];
        
    }
        
        
        
        
        
        [self ABCDViewMonitor:touches];
        [self lockerViewMonitor:touch];
        
        return;

    }

    
    

        
        

    if(CGRectContainsPoint([hand2 frame],pt))
    {
        CGPoint point = [touch  locationInView:self.view];
        CGRect  frame = hand1.frame;
        frame.origin = point;
        
        if(hand2.frame.origin.x+2>frame.origin.x||hand2.frame.origin.y+2>frame.origin.y||hand2.frame.size.width+hand2.frame.origin.x-35<frame.origin.x||hand2.frame.size.height+hand2.frame.origin.y-54<frame.origin.y)
        {
            return;
        }

        hand1.frame = frame;
    }
    
    if(CGRectContainsPoint([mouse2 frame],pt))
    {
        CGPoint point = [touch  locationInView:self.view];
        CGRect  frame =mouse1.frame;
        frame.origin = point;
  
        if(mouse2.frame.origin.x+2>frame.origin.x||mouse2.frame.origin.y+2>frame.origin.y||mouse2.frame.size.width+mouse2.frame.origin.x-39<frame.origin.x||mouse2.frame.size.height+mouse2.frame.origin.y-46<frame.origin.y)
        {
            return;
        }
        
        mouse1.frame = frame;

        radioX =  [single.cur_tvInfo.winW floatValue]/mouse2.frame.size.width;
        radioY =  [single.cur_tvInfo.winH floatValue]/mouse2.frame.size.height;
    }

    [self lockerViewMonitor:touch];
    
    

    

}

-(void)ABCDViewMonitor:(NSSet *)touches{        //对ABCD 四个按钮进行监听

    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self.view];

    if(CGRectContainsPoint([buttonA frame] , pt) && ABCD[0] == 0)
    {
        ABCD[0] =1;
        if(single.vibrate_flag2 == TRUE)
        {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        }
        if(single.sound_flag2 == TRUE)
        {
            AudioServicesPlaySystemSound(soundId);

        }
        
        for (UITouch *touchD in touches)
            
        {
            g_pointA = touchD;
        }
        
        sendPSPEvent(0, "2061", 0, single.cur_tvInfo.tv_ip);
        
        
      
        
        [buttonA setImage:[UIImage imageNamed:@"jieji_anx2.png"]];
    }else if( g_pointA.phase == 1  && (!CGRectContainsPoint([buttonA frame] , [g_pointA locationInView:self.view])))
    {
        g_pointA = NULL;
        [buttonA setImage:[UIImage imageNamed:@"jieji_anx1.png"]];
        sendPSPEvent(1, "2061", 0, single.cur_tvInfo.tv_ip);
        ABCD[0] = 0;
    }
    
    
    if(CGRectContainsPoint([buttonB frame] , pt) && ABCD[1] == 0)
    {
        ABCD[1]=2;
        if(single.vibrate_flag2 == TRUE)
        {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        }
        if(single.sound_flag2 == TRUE)
        {
            AudioServicesPlaySystemSound(soundId);
        }
         NSLog(@"b");
        sendPSPEvent(0, "2062", 0, single.cur_tvInfo.tv_ip);
        
        [buttonB setImage:[UIImage imageNamed:@"jieji_any2.png"]];
        
        for (UITouch *touchD in touches)
            
        {
            g_pointB = touchD;
        }
        
        
    }else if( g_pointB.phase == 1  && (!CGRectContainsPoint([buttonB frame] , [g_pointB locationInView:self.view])))
    {
        ABCD[1] = 0;
        [buttonB setImage:[UIImage imageNamed:@"jieji_any1.png"]];
        sendPSPEvent(1, "2062", 0, single.cur_tvInfo.tv_ip);
        g_pointB =NULL;
    }
    
    if(CGRectContainsPoint([buttonC frame] , pt) && ABCD[2] == 0)
    {
        ABCD[2]=3;
        if(single.vibrate_flag2 == TRUE)
        {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        }
        if(single.sound_flag2 == TRUE)
        {
            AudioServicesPlaySystemSound(soundId);
        }
        sendPSPEvent(0, "2060", 0, single.cur_tvInfo.tv_ip);
         NSLog(@"c");
        [buttonC setImage:[UIImage imageNamed:@"jieji_anb2.png"]];
        
     
        for (UITouch *touchD in touches)
        {
            g_pointC = touchD;
        }
        
        
    }else if( g_pointC.phase ==1  && (!CGRectContainsPoint([buttonC frame] , [g_pointC locationInView:self.view])))
    {
        
        [buttonC setImage:[UIImage imageNamed:@"jieji_anb1.png"]];
        sendPSPEvent(1, "2060", 0, single.cur_tvInfo.tv_ip);
        ABCD[2] = 0;
        g_pointC = NULL;
    }
    
    if(CGRectContainsPoint([buttonD frame] , pt) && ABCD[3] ==0 )
    {
        ABCD[3]=4;
        if(single.vibrate_flag2 == TRUE)
        {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        }
        if(single.sound_flag2 == TRUE)
        {
            AudioServicesPlaySystemSound(soundId);
        }
        
         NSLog(@"d");
        sendPSPEvent(0, "2059", 0, single.cur_tvInfo.tv_ip);
        [buttonD setImage:[UIImage imageNamed:@"jieji_ana2.png"]];
        
        
        for (UITouch *touchD in touches)
            
        {
            g_pointD = touchD;
        }
    }else if(g_pointD.phase == 1  && (!CGRectContainsPoint([buttonD frame] , [g_pointD locationInView:self.view])))
    {
        
        [buttonD setImage:[UIImage imageNamed:@"jieji_ana1.png"]];
        sendPSPEvent(1, "2059", 0, single.cur_tvInfo.tv_ip);
        g_pointD = NULL;
        ABCD[3] = 0;
    }

}












-(void)lockerViewMonitor:(UITouch *)touch           //对抽屉进行监听
{
    CGPoint pt = [touch locationInView:self.view];
    CGRect  frame =self.view.frame;
    frame.size.width=270;
    
    if(CGRectContainsPoint(frame , pt))
    {
        [UIView animateWithDuration:0.5 animations:^{
            [self.lockerView setFrame:CGRectMake(568, 0, 568, 320)];
            buttonA.alpha = 1;
        }];
    }

    
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }

    return self;
}

//不支持转屏
- (BOOL)shouldAutorotate{
    return NO;
}


-(void)initWall
{

        buttonA = (UIImageView *)[self.view  viewWithTag:131];
        buttonB = (UIImageView *)[self.view  viewWithTag:132];
        buttonC = (UIImageView *)[self.view  viewWithTag:133];
        buttonD = (UIImageView *)[self.view  viewWithTag:134];
        crank1 = (UIImageView*)[self.view viewWithTag:120];        //街机游戏摇柄
        bottom1 = (UIImageView *)[self.view viewWithTag:121];      //街机游戏底座
        single = [Singleton getInstance];
    
    
    
        hand2 = (UIImageView*)[self.view  viewWithTag:10];
        mouse2 = (UIImageView*)[self.view viewWithTag:11];
        hand1 = (UIImageView*)[self.view  viewWithTag:100];
        mouse1 = (UIImageView*)[self.view viewWithTag:101];
        
    
    
        
}





- (void)viewDidLoad
{
    [super viewDidLoad];
    
    settings = [[Settings alloc] init];
    NSArray *array = [settings readFromLocalFile2];
    BOOL f_vibrate = [[array objectAtIndex:0] boolValue];
    BOOL f_sound = [[array objectAtIndex:1] boolValue];
    if(f_vibrate == TRUE)
    {
        label1 = YES;
        [lockerButtonVibration setBackgroundImage:[UIImage imageNamed:@"kaiguan1.png"] forState:UIControlStateNormal];
    }
    else
    {
        label1 = NO;
        [lockerButtonVibration setBackgroundImage:[UIImage imageNamed:@"kaiguan2.png"] forState:UIControlStateNormal];
    }
    
    if(f_sound == TRUE)
    {
        label2 = YES;
        [lockerButtonVoice setBackgroundImage:[UIImage imageNamed:@"kaiguan1.png"] forState:UIControlStateNormal];
    }
    else
    {
        label2 = NO;
        [lockerButtonVoice setBackgroundImage:[UIImage imageNamed:@"kaiguan2.png"] forState:UIControlStateNormal];
    }

    path = [[NSBundle mainBundle] pathForResource:@"btn" ofType:@"wav"];
    if (path)
    {
        AudioServicesCreateSystemSoundID( (CFURLRef)[NSURL fileURLWithPath:path], &soundId);
    }


    
    //设置应用程序的状态栏到指定的方向
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
    //view旋转
    [self.view setTransform:CGAffineTransformMakeRotation(M_PI/2)];
    
    self.view.multipleTouchEnabled =YES;        //设置可以接受多点事件
    
    [self initWall];
    
    
    
    startPoint = mouse2.frame.origin;
}







-(void)viewWillAppear:(BOOL)animated
{
    //隐藏navigationController
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    //隐藏状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];}

- (void)viewWillDisappear:(BOOL)animated
{
    //显示状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    //显示navigationController
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}








- (void)viewDidUnload {
    self.settings = nil;
    [self setFunctionButton:nil];
    [self setGameButton:nil];
    [self setInsertButton:nil];
    [self setGameButton:nil];
    [self setInsertButton:nil];
    [self setLockerView:nil];
    [self setLockerButtonVibration:nil];
    [self setLockerButtonVibration:nil];
    [self setLockerButtonVoice:nil];
    [self setButtonAddVoice:nil];
    [self setButtonCutVoice:nil];
    [self setButtonSystem:nil];
    [self setButtonMenu:nil];
    [self setButtonOut:nil];
    [self setButtonConncet:nil];
    [self setSingle:nil];
    [self setImageMouse:nil];
    [super viewDidUnload];
}










- (IBAction)clikeOut:(id)sender {   buttonOut.backgroundColor = [UIColor colorWithRed:110/255.0 green:123/255.0 blue:139/255.0 alpha:1.0];
    
}

- (IBAction)clikeMenu:(id)sender {  buttonMenu.backgroundColor = [UIColor colorWithRed:110/255.0 green:123/255.0 blue:139/255.0 alpha:1.0];
}

- (IBAction)clikeSystem:(id)sender {    buttonSystem.backgroundColor = [UIColor colorWithRed:110/255.0 green:123/255.0 blue:139/255.0 alpha:1.0];
}

- (IBAction)clikeAddButtonUpOut:(id)sender {
    buttonCutVoice.backgroundColor = [UIColor whiteColor];}

- (IBAction)clikeCutButtonDown:(id)sender {
    buttonCutVoice.backgroundColor = [UIColor colorWithRed:110/255.0 green:123/255.0 blue:139/255.0 alpha:1.0];
}

- (IBAction)deddd:(id)sender {
    buttonAddVoice.backgroundColor = [UIColor whiteColor];
}

- (IBAction)clikeAddButtonDown:(id)sender {
    buttonAddVoice.backgroundColor = [UIColor colorWithRed:110/255.0 green:123/255.0 blue:139/255.0 alpha:1.0];
}

- (IBAction)clikeFunction:(id)sender {
    
    
    
    [UIView animateWithDuration:0.5 animations:^{
    [self.lockerView setFrame:CGRectMake(268, 0, 568, 320)];
        buttonA.alpha = 0;
}];
}

- (IBAction)clikeGame:(id)sender {
    
    sendPSPEvent(1, "2066", 0, single.cur_tvInfo.tv_ip);
}

- (IBAction)clikeInsert:(id)sender {
    
    sendPSPEvent(1, "2065", 0, single.cur_tvInfo.tv_ip);
}
- (IBAction)clikeGameDown:(id)sender {      sendPSPEvent(0, "2065", 0, single.cur_tvInfo.tv_ip);
}

- (IBAction)clikeInsertDown:(id)sender {    sendPSPEvent(0, "2066", 0, single.cur_tvInfo.tv_ip);
}

- (IBAction)clikeVibration:(id)sender {     //震动单击
 
    if(!label1)
    {
        single.vibrate_flag2 = NO;
        [lockerButtonVibration setBackgroundImage:[UIImage imageNamed:@"kaiguan2.png"] forState:UIControlStateNormal];
        label1 = YES;
    }else
    {
        single.vibrate_flag2 = YES;
        [lockerButtonVibration setBackgroundImage:[UIImage imageNamed:@"kaiguan1.png"] forState:UIControlStateNormal];
        label1 = NO;
    }
    if(settings != nil)
    {
        [settings writeToLocalFile2];
    }
}

- (IBAction)clikeVoice:(id)sender {
  
    if(!label2)
    {
        single.sound_flag2 = NO;
        [lockerButtonVoice setBackgroundImage:[UIImage imageNamed:@"kaiguan2.png"] forState:UIControlStateNormal];
        label2 = YES;
    }else
    {
        single.sound_flag2 = YES;
        [lockerButtonVoice setBackgroundImage:[UIImage imageNamed:@"kaiguan1.png"] forState:UIControlStateNormal];
        label2 = NO;
    }
    if(settings != nil)
    {
        [settings writeToLocalFile2];
    }
}



- (IBAction)returnTop:(id)sender {   [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)ClickNO:(id)sender
{
//    Singleton *single = [Singleton getInstance];
    TvInfo *tvInfo = single.cur_tvInfo;
    sendPSPEvent(0, "2009", 0, tvInfo.tv_ip);
    sendPSPEvent(1, "2009", 0, tvInfo.tv_ip);
    
}

- (IBAction)ClickOK:(id)sender
{
//    Singleton *single = [Singleton getInstance];
    TvInfo *tvInfo = single.cur_tvInfo;
    sendMouseEvent(0, 0, 0, tvInfo.tv_ip, [tvInfo.udpPort intValue]);
    sendMouseEvent(3, 0, 0, tvInfo.tv_ip, [tvInfo.udpPort intValue]);
}
@end
