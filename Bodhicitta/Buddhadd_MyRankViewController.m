//
//  Buddhadd_MyRankViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/10/15.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "Buddhadd_MyRankViewController.h"
#import "HeaderFile.h"
#import "BuddhaHallView.h"
#import "MyBuddhaHallViewController.h"
#include "BuddhaLevel.h"
#import "MyBuddhaLevelCell.h"

@interface Buddhadd_MyRankViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UIImageView *titleImage;
@property(nonatomic,strong)UIImageView *homeImageView;
@property(nonatomic,strong)UIImageView *conterImageView;
@property(nonatomic,strong)NSMutableArray *levelArray;
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)UIImageView *bgImageView;
@end

@implementation Buddhadd_MyRankViewController
-(instancetype)initWithModel:(TempleImage* )model
{
    if (self = [super init]) {
        self.templeModel = model;
    }
    return self;
}
-(NSMutableArray *)levelArray
{
    if (_levelArray == nil) {
        _levelArray = [[NSMutableArray alloc]init];
    }
    return _levelArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadBuddhaLevel];
    self.view.backgroundColor=[UIColor whiteColor];
    CGFloat width;
    CGFloat height ;
    CGFloat font ;
    if (fabs(SCREEN_HEIGHT-667) < 1) {
        width = 230;
        height =  100;
        font  = 16;
    }
    else
    {
        if (fabs(SCREEN_HEIGHT -568) < 1) {
            width = 180;
            height = 95;
            font = 14;
        }
        else if (fabs(SCREEN_HEIGHT - 736) < 1)
        {
            width = 230;
            height = 100;
            font = 16;
        }
        else
        {
            width = 180;
            height  = 100;
            font = 14;
        }
    }
    
    self.homeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height+height*0.4)];
    self.homeImageView.image=[UIImage imageNamed:@"temple_rank_top_bg.jpg"];
    self.homeImageView.userInteractionEnabled=YES;
    [self.view addSubview:self.homeImageView];
    
    UIButton * back = [[UIButton alloc]initWithFrame:CGRectMake(width*0.09, height*0.35, width*0.15, height*0.3)];
    [back setBackgroundImage:[UIImage imageNamed:@"返回上级"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.homeImageView addSubview:back];
    
    _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(width*0.35, height*0.45, SCREEN_WIDTH*0.5, height*0.1)];
    
    _titleLabel.text=self.templeModel.taskName;
    
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.backgroundColor=[UIColor clearColor];
    _titleLabel.font=[UIFont systemFontOfSize:font];
    [self.homeImageView addSubview:_titleLabel];
    
    self.bgImageView= [[UIImageView alloc]initWithFrame:CGRectMake(0, self.homeImageView.frame.origin.y+self.homeImageView.frame.size.height, SCREEN_WIDTH, height+SCREEN_HEIGHT*0.48)];
    //背景图放在表格上
    //self.bgImageView.backgroundColor=[UIColor redColor];
    self.bgImageView.image=[UIImage imageNamed:@"temple_rank_middle_bg.jpg"];
    [self.view addSubview:self.bgImageView];
    
    self.titleImage = [[UIImageView alloc]initWithFrame:CGRectMake(width*0.12,self.homeImageView.frame.size.height+self.homeImageView.frame.origin.y, width+width*0.4, height*0.3)];
    //self.titleImage=[[UIImageView alloc]initWithFrame:CGRectMake(width*0.12, 0, width+width*0.4, height*0.4)];
    self.titleImage.image=[UIImage imageNamed:@"temple_rank_middle_top_bg.jpg"];
    [self.view addSubview: self.titleImage];
    
    UILabel * rankLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 10, 50, 20)];
    rankLabel.text=@"排行";
    rankLabel.textColor=BuddhaddTitleColor;
    rankLabel.font=[UIFont systemFontOfSize:font];
    [self.titleImage addSubview:rankLabel];
    
    UILabel * leverLabel = [[UILabel alloc]initWithFrame:CGRectMake(rankLabel.frame.origin.x+rankLabel.frame.size.width+width*0.1, rankLabel.frame.origin.y, 50, 20)];
    leverLabel.text=@"积分";
    leverLabel.textColor=BuddhaddTitleColor;
    leverLabel.font=[UIFont systemFontOfSize:font];
    [self.titleImage addSubview:leverLabel];
    
    UILabel * gatdLabel = [[UILabel alloc]initWithFrame:CGRectMake(leverLabel.frame.origin.x+leverLabel.frame.size.width+width*0.1, rankLabel.frame.origin.y, 50, 20)];
    gatdLabel.text=@"等级";
    gatdLabel.textColor=BuddhaddTitleColor;
    gatdLabel.font=[UIFont systemFontOfSize:font];
    [self.titleImage addSubview:gatdLabel];
    
    UILabel * dedicatedLabel = [[UILabel alloc]initWithFrame:CGRectMake(gatdLabel.frame.origin.x+gatdLabel.frame.size.width+width*0.1, rankLabel.frame.origin.y, 80, 20)];
    dedicatedLabel.text=@"贡奉者";
    dedicatedLabel.textColor=BuddhaddTitleColor;
    dedicatedLabel.font=[UIFont systemFontOfSize:font];
    [self.titleImage addSubview:dedicatedLabel];
    
    self.conterImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.bgImageView.frame.origin.y+self.bgImageView.frame.size.height, SCREEN_WIDTH, height*0.5)];
    self.conterImageView.image=[UIImage imageNamed:@"temple_rank_middle_bottom_bg.jpg"];
    [self.view addSubview: self.conterImageView];
    
    UIImageView * buttomImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,  self.conterImageView.frame.origin.y+ self.conterImageView.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT)];
    buttomImageView.userInteractionEnabled=YES;
    buttomImageView.image=[UIImage imageNamed:@"temple_rank_bottom_bg.jpg"];
    [self.view addSubview:buttomImageView];
    [self createTableView];
    
    
}
- (void)selectBuddhImage:(TempleImage*)model
{
    
}
#pragma mark-----TableView主页面
- (void)createTableView
{
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(27, self.titleImage.frame.origin.y+self.titleImage.frame.size.height, SCREEN_WIDTH-54, self.conterImageView.frame.origin.y-self.titleImage.frame.origin.y-self.conterImageView.frame.size.height)];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"排行背景.png"]];
    _tableview.showsHorizontalScrollIndicator=NO;
    _tableview.showsVerticalScrollIndicator=NO;
    _tableview.separatorStyle =  UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableview];
    
}
#pragma mark ---tableView代理方法---
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0){
        
    }
    
    BuddhaLevel *model = self.levelArray[indexPath.row];
    
    NSString *cellId = @"cellId";
    MyBuddhaLevelCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[MyBuddhaLevelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    [_tableview headerEndRefreshing];
    [_tableview  footerEndRefreshing];
    [cell setBuddhaModel:model IndexPath:indexPath];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.levelArray.count;;
}
//按钮事件
-(void)backClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark-佛像排行

#pragma mark ----佛堂排行
-(void)loadBuddhaLevel{
    [ProgressHUD showOnView:self.view];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSNumber *miyao=[appDelegate.accountBasicDict objectForKey:@"secretKey"];
    appDelegate.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary * dic = @{@"secretKey":miyao,@"taskCode":self.templeModel.taskCode};
    NSDictionary * budDic = @{@"params":[NSString stringWithFormat:@"%@",dic]};
    
    [appDelegate.sessionManager GET:[NSString stringWithFormat:@"%@%@",__kBaseURLString,ptxGetTempleOrder] parameters:budDic success:^(NSURLSessionDataTask *task, id responseObject)
     {
         id  jsonData=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"佛堂＝%@",jsonData);
         NSArray *buddaArray=jsonData[@"data"];
         for (int i=0;i<buddaArray.count;i++){
             NSDictionary *dict=buddaArray[i];
             NSNumber *templeIntegral=dic[@"templeIntegral"];
             NSLog(@"积分＝%@",templeIntegral);
             // [self.valueArray addObject:nickName];
             BuddhaLevel *model=[[BuddhaLevel alloc]init];
             [model setValuesForKeysWithDictionary:dict];
             [self.levelArray addObject:model];
             
         }
         
         //        if (self.levelArray.count>3){
         //            [self.levelArray removeObjectsInRange:NSMakeRange(0, 3)];
         //        }else{
         //              [self.levelArray removeObjectsInRange:NSMakeRange(0, self.levelArray.count)];
         //        }
         [ProgressHUD  hideAfterSuccessOnView:self.view];
         [self.tableview reloadData];
         
         [self createTableView];
         
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         
     }];
    
}
@end
