//
//  BuddhaddRankViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/10/15.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "BuddhaddRankViewController.h"
#import "HeaderFile.h"
#import "TempleImage.h"
#import "Buddhadd_MyRankViewController.h"
#import "BuddhaLevel.h"
#import "BuddhaLevelCell.h"
#import "TopThreeViewCell.h"
#import "CheckBuddhaHallLevel.h"
@interface BuddhaddRankViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView * tableview;
@property(nonatomic,strong)UILabel * leverLabel;
@property(nonatomic,strong)UILabel * gardLabel;
@property(nonatomic,strong)UILabel * rankLabel;
@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)TempleImage *templeModel;
@property(nonatomic,strong)NSMutableArray *levelArray;
@property(nonatomic,strong)UIImageView *titleImage;
@property(nonatomic,strong)UIImageView *conterImageView;
@property(nonatomic,strong)UIImageView * homeImageView;
@property(nonatomic,strong)BuddhaLevel *levelModel;
@property(nonatomic,strong)NSMutableArray *nickNameArray;
@property(nonatomic,strong)NSMutableArray *valueArray;
@property(nonatomic,strong)NSMutableArray *rankArray;
@property(nonatomic,strong)UIImageView *headImageView;
@end

@implementation BuddhaddRankViewController
//自定义
-(instancetype)initWithModel:(TempleImage* )model
{
    if (self = [super init]) {
        self.templeModel = model;
    }
    return self;
}
-(NSMutableArray *)valueArray
{
    if (_valueArray == nil) {
        _valueArray = [[NSMutableArray alloc]init];
    }
    return _valueArray;
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
    
    UIImageView * imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.homeImageView.frame.origin.y+self.homeImageView.frame.size.height, SCREEN_WIDTH, height+SCREEN_HEIGHT*0.48)];
    //背景图放在表格上
    imageview.image=[UIImage imageNamed:@"temple_rank_middle_bg.jpg"];
    [self.view addSubview:imageview];
    
    self.titleImage = [[UIImageView alloc]initWithFrame:CGRectMake(width*0.12,self.homeImageView.frame.size.height+self.homeImageView.frame.origin.y, width+width*0.4, height*0.3)];
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
    
    self.conterImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, imageview.frame.origin.y+imageview.frame.size.height, SCREEN_WIDTH, height*0.5)];
    self.conterImageView.image=[UIImage imageNamed:@"temple_rank_middle_bottom_bg.jpg"];
    [self.view addSubview: self.conterImageView];
    
    UIImageView * buttomImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,  self.conterImageView.frame.origin.y+ self.conterImageView.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT)];
    buttomImageView.userInteractionEnabled=YES;
    buttomImageView.image=[UIImage imageNamed:@"temple_rank_bottom_bg.jpg"];
    [self.view addSubview:buttomImageView];
    
    UIImageView * ownImageView = [[UIImageView alloc]initWithFrame:CGRectMake(width*0.05, height*0.05, width+width*0.54, height*0.4)];
    ownImageView.image=[UIImage imageNamed:@"temple_rank_myself_bg.jpg"];
    ownImageView.userInteractionEnabled=YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(phoneTapClick)];
    [ownImageView addGestureRecognizer:tap];
    [buttomImageView addSubview:ownImageView];
    
    _rankLabel = [[UILabel alloc]initWithFrame:CGRectMake(35, 15, 50, 20)];
    
    _rankLabel.textColor=buddhaddBottomColor;
    _rankLabel.font=[UIFont systemFontOfSize:font];
    [buttomImageView addSubview:_rankLabel];
    
    _leverLabel = [[UILabel alloc]initWithFrame:CGRectMake(_rankLabel.frame.origin.x+_rankLabel.frame.size.width+width*0.15, _rankLabel.frame.origin.y, 50, 20)];
    
    _leverLabel.textColor=buddhaddBottomColor;
    _leverLabel.font=[UIFont systemFontOfSize:font];
    [buttomImageView addSubview:_leverLabel];
    
    _gardLabel = [[UILabel alloc]initWithFrame:CGRectMake(_leverLabel.frame.origin.x+_leverLabel.frame.size.width+width*0.15, _rankLabel.frame.origin.y, 50, 20)];
    
    _gardLabel.textColor=buddhaddBottomColor;
    _gardLabel.font=[UIFont systemFontOfSize:font];
    [buttomImageView addSubview:_gardLabel];
    
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(_gardLabel.frame.origin.x+_gardLabel.frame.size.width+width*0.15, _rankLabel.frame.origin.y, width*0.5, 20)];
    
    _nameLabel.textColor=buddhaddBottomColor;
    _nameLabel.font=[UIFont systemFontOfSize:font];
    [buttomImageView addSubview:_nameLabel];
    [self loadBuddhaLevel];
    [self loadTempleData];
    
    
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
    return 60;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BuddhaLevel *model = self.levelArray[indexPath.row];
    NSString *cellId = @"cellId";
    TopThreeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[TopThreeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    [self setupRefresh];
    [cell setBuddhaModel:model IndexPath:indexPath];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.levelArray.count;;
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableview addHeaderWithTarget:self action:@selector(headerRereshing)];
#warning 自动刷新(一进入程序就下拉刷新)
    [self.tableview headerEndRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableview addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableview.headerPullToRefreshText = @"下拉可以刷新了";
    self.tableview.headerReleaseToRefreshText = @"松开马上刷新了";
    self.tableview.headerRefreshingText = @"正在帮你刷新中";
    
    self.tableview.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.tableview.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    self.tableview.footerRefreshingText = @"正在帮你加载中";
}
#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    // 2.2秒后刷新表格UI
    //    1.0 * NSEC_PER_SEC
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableview reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableview headerEndRefreshing];
    });
}

- (void)footerRereshing
{
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableview reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableview footerEndRefreshing];
    });
}


//按钮事件
-(void)backClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)phoneTapClick{
    
    
    Buddhadd_MyRankViewController * myrank = [[Buddhadd_MyRankViewController alloc]initWithModel:self.templeModel];
    [self.navigationController pushViewController:myrank animated:YES];
    
}
#pragma mark ----佛堂排行
-(void)loadBuddhaLevel{
    
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
             BuddhaLevel *model=[[BuddhaLevel alloc]init];
             [model setValuesForKeysWithDictionary:dict];
             [self.levelArray addObject:model];
             
         }
         
         
         [self createTableView];
         
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         
     }];
    
}
#pragma mark ---私人佛堂接口-----
//佛堂
-(void)loadTempleData
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *url = [NSString stringWithFormat:@"%@%@",__kBaseURLString,ptxGetTempleIntegralOrderByID];
    NSNumber * huaien = [appDelegate.accountBasicDict objectForKey:@"huaienID"];
    NSNumber *miyao=[appDelegate.accountBasicDict objectForKey:@"secretKey"];
    NSDictionary  *paramter = @{@"secretKey":miyao,@"huaienID":huaien,@"taskCode":self.templeModel.taskCode};
    NSDictionary  *dict = @{@"params":[NSString stringWithFormat:@"%@",paramter]};
    [appDelegate.sessionManager POST: url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"私人佛堂排名=%@",jsonData);
        NSNumber  *valueNum=jsonData[@"templeIntegral"];
        NSInteger value=[valueNum integerValue];
        CheckBuddhaHallLevel *levelManager = [CheckBuddhaHallLevel   shareCheckBuddhaHallLevel];
        NSInteger   levelInteger = [levelManager checkBuddhaHallLevelWithValue:value];
        self.gardLabel.text=[NSString stringWithFormat:@"%ld级",levelInteger];
        
        self.rankLabel.text=[NSString stringWithFormat:@"%@",jsonData[@"userOrder"]];
        
        //        self.leverLabel.text=jsonData[@"templeIntegral"];
        self.leverLabel.text=[NSString stringWithFormat:@"%@",jsonData[@"templeIntegral"]];
        if(jsonData[@"nickName"])
        {
            self.nameLabel.text=[NSString stringWithFormat:@"%@",huaien];
        }else{
            self.nameLabel.text=[NSString stringWithFormat:@"%@",jsonData[@"nickName"]];
        }
       
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}

@end
