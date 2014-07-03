//
//  connectTV.m
//  gameUI
//
//  Created by yibin chen on 14-06-09.
//  Copyright (c) 2014年 yibin chen. All rights reserved.
//

#import "connectTV.h"

@interface connectTV ()
{

     UIButton *but ;
}
@end

@implementation connectTV




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
    
        return 4;
        //返回书的数量  告诉系统有几本这样的书
}

//返回的是table view cell 的内容   我们调用的每一个单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellId=[[NSString alloc]initWithFormat:@"RecipeCell"];       //给创建的版本命名
    
    //创建table view cell 的一行并初始化他为可以重复使用
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId]; //往上移 上面的行消失掉 转到下面来作为容器
    if (nil==cell) {        //cell 为空说明他已经跳出界面 再次为他初始化  这样做可以在很大的程度上节省资源
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    

    
    //修改行的标签  也就是修改书名
    [[cell textLabel] setText:@"电视名字"];        //通过书本数组中的下表来找到该书
    
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;    //设置书的类型 为按钮类型的
    
    cell.detailTextLabel.text = [[NSString alloc]initWithFormat:@"电视ip地址"];
    

    but = [UIButton buttonWithType:UIButtonTypeCustom];
    
    but.frame = CGRectMake(cell.frame.origin.x+40,cell.frame.origin.y,60,25);


   // but.backgroundColor = [UIColor colorWithRed:249/255.0 green:168/255.0 blue:27/255.0 alpha:1.0];       //设置按钮背景颜色
    [but setTitle:@"连接设备" forState: UIControlStateNormal];
    but.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    
    [but setBackgroundImage:[UIImage imageNamed:@"sjyk_anniu1.9.png"] forState:UIControlStateNormal];
    
    //给button添加点击事件，action参数中写入事件执行方法
    [but addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    //在button的tag中添加你需要传递的参数，目前资料中只有这种方法
    //你可以传入任意类型的参数
  
    cell.accessoryView = but;
    
    
    
    return cell;
    
   
}






- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [super viewWillAppear:animated];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath        //选中状态
{
//    appRecord = [self.m_array objectAtIndex:indexPath.row];
//    label = YES;
    return indexPath;
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

- (void)dealloc {


    [super dealloc];
}
- (void)viewDidUnload {
 

    [super viewDidUnload];
}
- (IBAction)returnLeaf:(id)sender {     [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)action:(id)sender {  printf("连接设备");
}
@end
