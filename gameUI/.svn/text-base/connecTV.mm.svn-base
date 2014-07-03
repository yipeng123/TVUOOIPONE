//
//  connecTV.m
//  gameUI
//
//  Created by yibin chen on 14-06-10.
//  Copyright (c) 2014年 yibin chen. All rights reserved.
//

#import "connecTV.h"
#import "MyJniTransport.h"

int rowlabel = 999 ;
int num=0;

static CGFloat radian;


@interface connecTV ()
{
    NSTimer * t_timer;
    UIButton *but ;
   
}
@end

@implementation connecTV

@synthesize rotateView;
@synthesize rotateImage;
@synthesize rotateLabel;




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


//设置table view的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

//设置分段的行数  只可以少 不可以多
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = [_tvInfos count];
    if(count==0){
        return 1;
    }
    NSLog(@"本手机的mac地址是: %@", [DeviceInfo getMacAddress]);
    return count;
    //返回书的数量  告诉系统有几本这样的书
}

//返回的是table view cell 的内容   我们调用的每一个单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellId=[[NSString alloc]initWithFormat:@"RecipeCell"];       //给创建的版本命名
    
    int nodeCount = [_tvInfos count];
    
	if (nodeCount == 0 && indexPath.row == 0)
	{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil)
		{
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
										   reuseIdentifier:cellId] autorelease];
            cell.detailTextLabel.textAlignment = UITextAlignmentCenter;
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
		cell.detailTextLabel.text = [NSString stringWithFormat:@"正在查找设备..."];
        
		return cell; //记录为0则直接返回，只显示数据加载中…
    }

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil)
	{
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
									   reuseIdentifier:cellId] autorelease];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if(nodeCount>0){
       TvInfo* appRecord = [_tvInfos objectAtIndex:indexPath.row];
        
		cell.textLabel.text = appRecord.name;
        char *str = parseIp(appRecord.tv_ip);
        NSString *ipStr = [NSString stringWithFormat:@"%s", str];
        cell.detailTextLabel.text = ipStr;
        //[tableview setSeparatorColor:[UIColor redColor ]];  //设置分割线的颜色
        //向下滑动,停止时加载图标  
        but = [UIButton buttonWithType:UIButtonTypeCustom];
        
        but.frame = CGRectMake(cell.frame.origin.x+40,cell.frame.origin.y+50,60,25);
        if(true == single.flag && indexPath.row == rowlabel)
        {
            [but setTitle:@"断开连接" forState: UIControlStateNormal];
        }else
        {
            [but setTitle:@"连接设备" forState: UIControlStateNormal];
        }
        
        but.titleLabel.font = [UIFont systemFontOfSize: 13.0];
        [but setTag:indexPath.row];
        
        //给button添加点击事件，action参数中写入事件执行方法
        //[but addTarget:indexPath.row addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
      
        [but addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];  
        
        [but setBackgroundImage:[UIImage imageNamed:@"sjyk_anniu1.9.png"] forState:UIControlStateNormal];
        //在button的tag中添加你需要传递的参数，目前资料中只有这种方法
        //你可以传入任意类型的参数
        
        cell.accessoryView = but;
    }
 
    return cell;
    
    
}

//回调函数
- (void) startGame:(NSString*) gameId
              type:(int)gameType
         direction:(int)gameDirection
{
}


- (void) showTvInfo
{
    _tvInfos =  [[Singleton getInstance] ip_array];
    [tableview reloadData];
}
- (void) connectStatue:(NSArray*)argument
{
    
    //argument的第一个元素是ip  第二个是连接状态isConnected  第三个是 连接个数num
    if(([[argument objectAtIndex:1] intValue] == 1) && [[argument objectAtIndex:2] intValue] <= 2)
    {
        
        Singleton *single = [Singleton getInstance];
        single.flag = TRUE;
        [t_rotaeTime invalidate];//////
        t_rotaeTime = nil;
        [UIView animateWithDuration:0.001 animations:^{
            
            [self.rotateView setFrame:CGRectMake(320, 100, 260, 160)];
            
        }];
        single.pNum = [[argument objectAtIndex:2] intValue];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        rotateLabel.text = @"与设备连接失败";
        [t_rotaeTime invalidate];
        t_rotaeTime = nil;
        rotateView.alpha = 0;
        _PromptButton.alpha = 1;
        _PromptLabel.alpha = 1;
        
        [t_rotaeTime invalidate];//////
        t_rotaeTime = nil;
    }
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   
    
    return indexPath;
}



- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [super viewWillAppear:animated];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    
}


//-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath        //选中状态
//{
//    return indexPath;
//}




- (void)viewDidLoad
{
     [super viewDidLoad];
    single =  [Singleton getInstance];
    _tvInfos = [[NSMutableArray alloc] init];
    _tvInfos =  [single ip_array];
   
    tableview =(UITableView *) [self.view viewWithTag:990];  
    [single setDelegate1:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    [rotateView release];
    [rotateImage release];
    [rotateLabel release];
    [_PromptLabel release];
    [_PromptButton release];
    [super dealloc];
}
- (void)viewDidUnload {
 
    [self setRotateView:nil];
    [self setRotateImage:nil];
    [self setRotateLabel:nil];
    [self setPromptLabel:nil];
    [self setPromptButton:nil];
    [super viewDidUnload];
}

-(void) rotaeImage:(id)sender
{
    
    
    radian += 90*M_PI/180;
    
    [UIView animateWithDuration:0.1 animations:^{
        
        rotateImage.transform = CGAffineTransformMakeRotation(radian);
        
    }];
    
}





-(void)action:(id)sender{
    int i = [sender tag];
    
    if( single.flag == true)
    {
//        single.conn_withTv = TRUE;
//        single.flag = FALSE;
        rowlabel = 999;
//        startThread();
        
        single.conn_withTv = FALSE;
        single.flag = FALSE;
        closeClient();
        
        startThread();
        single.conn_withTv = TRUE;
   
    }else
    {
        TvInfo *tvinfo = [single.ip_array objectAtIndex:i];
        single.row = [NSNumber numberWithInt:i];
        //另起线程发起连接
        [NSThread detachNewThreadSelector:@selector(connSrv:)
                             toTarget:self
                           withObject:tvinfo];
    
        rotateLabel.text = @"尝试与电视连接";
        [UIView animateWithDuration:0.1 animations:^{
        
        [self.rotateView setFrame:CGRectMake(30, 100, 260, 160)];
        
        }];
        rowlabel = i;
        
        num = 0;
        t_rotaeTime = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(rotaeImage:) userInfo:nil repeats:YES];
    }
   
}

- (void) connSrv:(TvInfo*)tvinfo
{
    int port = [tvinfo.udpPort intValue];
    int ip = tvinfo.tv_ip;
    connectServer(port, ip);
}

- (IBAction)returnLay:(id)sender {     
     [self.navigationController popViewControllerAnimated:YES];
}



- (void) haveInstalledArrayInfo:(NSString *)games
{
    
}



//如果电视启动了游戏   会回调此函数
- (void) startGame
{
    NSLog(@"jjjjjjjj");
}
@end
