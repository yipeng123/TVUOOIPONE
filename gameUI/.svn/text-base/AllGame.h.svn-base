//
//  AllGame.h
//  gameUI
//
//  Created by yibin chen on 14-06-03.
//  Copyright (c) 2014年 yibin chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FetchJson.h"
#import "StartUI.h"
#import "Singleton.h"
#import "Cpp/MyJniTransport.h"
#import "LabelconncetTV.h"

static int GameNameLabel = 10;

@interface AllGame : UIViewController<UITableViewDelegate,UITableViewDataSource,ProcessJson,StartUI>
{
    Singleton *single;
    UITableView *tableview;
    UITableView *Mytableview;
    GameInfo *appRecord;
    NSMutableArray * g_array;
    NSMutableArray * t_array;
    NSMutableArray * m_array;
    NSMutableArray * c_array;
    NSMutableArray * z_array;

}



@property (retain, nonatomic) Singleton *single;
@property(retain,strong)NSMutableArray * m_array;
@property(retain,strong)NSMutableArray * g_array;
@property(retain,strong)NSMutableArray * t_array;
@property(retain,strong)NSMutableArray * c_array;
@property(retain,strong)NSMutableArray * z_array;

@property (strong,nonatomic)UITableView *tableview;
@property (strong,nonatomic)UITableView *Mytableview;
@property(nonatomic,strong)UIButton * m_tableviewButton;
@property(nonatomic,strong)GameInfo * appRecord;


@property (retain, nonatomic) IBOutlet UIButton *allGameButton;
@property (retain, nonatomic) IBOutlet UIButton *streetGameButton;
@property (retain, nonatomic) IBOutlet UIButton *redGameButton;
@property (retain, nonatomic) IBOutlet UILabel *gameLabelName;      //uitabelview name标签



- (IBAction)ClickAllGame:(id)sender;
- (IBAction)ClickStreeGame:(id)sender;
- (IBAction)ClickRedGame:(id)sender;


- (IBAction)hongGame:(id)sender;
- (IBAction)jieGame:(id)sender;
- (IBAction)suoGame:(id)sender;
- (IBAction)xinGame:(id)sender;





@end
