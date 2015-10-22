//
//  BuddhaLevelCell.m
//  Bodhicitta
//
//  Created by 怀恩11 on 15/10/16.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "BuddhaLevelCell.h"
#import "HeaderFile.h"
#import "CheckBuddhaHallLevel.h"
@interface BuddhaLevelCell()
@property(nonatomic,strong)UIImageView *upRankImageView;
@property(nonatomic,strong)UIImageView *upBgImageView;
@property(nonatomic,strong)UIImageView *bottomRankImageView;
@property(nonatomic,strong)UIImageView *bottomBgImageView;
@property(nonatomic,strong)UIImageView *levelImageView;
@property(nonatomic,strong)UILabel *rankLabel;
@property(nonatomic,strong)UILabel *valueLabel;
@property(nonatomic,strong)UILabel *levelLabel;
@property(nonatomic,strong)UILabel *upNameLabel;
@property(nonatomic,strong)UILabel *bottomNameLabel;
@property(nonatomic,strong)UIImageView *headImageView;
@end

@implementation BuddhaLevelCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createSubViews];
    }
    return self;
}
- (void)createSubViews
{
    CALayer *layer = self.contentView.layer;
    //    layer.cornerRadius = 3;
    layer.masksToBounds = YES;
    self.backgroundColor = [UIColor redColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
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
    self.upBgImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    self.upBgImageView.image=[UIImage imageNamed:@"temple_rank_items_topthree_bg"];
    [self.contentView addSubview:self.upBgImageView];
    self.bottomBgImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    self.bottomBgImageView.image=[UIImage imageNamed:@"temple_rank_items_normal_bg.jpg"];
    [self.contentView addSubview:self.bottomBgImageView];
    self.rankLabel=[[UILabel alloc]initWithFrame:CGRectMake(width*0.15, height*0.1, 30, 25)];
    self.rankLabel.font=[UIFont systemFontOfSize:font];
    self.rankLabel.textColor=[UIColor blackColor];
    self.rankLabel.textColor=[UIColor orangeColor];
    [self.contentView addSubview:self.rankLabel];
    self.valueLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.rankLabel.frame.size.width+self.frame.origin.x+40, self.rankLabel.frame.origin.y, 80, 25)];
    self.valueLabel.font=[UIFont systemFontOfSize:font];
    self.valueLabel.textColor=[UIColor blackColor];
    [self.contentView addSubview:self.valueLabel];
    self.upRankImageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.valueLabel.frame.size.width+self.valueLabel.frame.origin.x+40, self.valueLabel.frame.origin.y, 50, 25)];
    self.upRankImageView.image=[UIImage imageNamed:@"top_three_temple_level_bg"];
    [self.contentView addSubview:self.upRankImageView];
    self.levelLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.valueLabel.frame.size.width+self.valueLabel.frame.origin.x+40, self.valueLabel.frame.origin.y, 50, 25)];
    self.levelLabel.font=[UIFont systemFontOfSize:font];
    self.levelLabel.textColor=[UIColor blackColor];
   [self.contentView addSubview:self.levelLabel];
    self.headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-80, 0, 40, 40)];
    [self.contentView addSubview:self.headImageView];
    self.upNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.headImageView.frame.origin.x, self.headImageView.frame.origin.y+self.headImageView.frame.size.height, self.headImageView.frame.size.width, 10)];
    [self.contentView addSubview:self.upNameLabel];
    
    
  self.bottomNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-80, self.levelLabel.frame.origin.y, 60, 25)];
    self.bottomNameLabel.font=[UIFont systemFontOfSize:font];
    self.bottomNameLabel.textColor=[UIColor blackColor];
    [self.contentView addSubview:self.bottomNameLabel];
   
}

-(void)setBuddhaModel:(BuddhaLevel *)model IndexPath:(NSIndexPath *) indexPath
{
    _model=model;
    AppDelegate  *appDelegate= (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSNumber * huaien = [appDelegate.accountBasicDict objectForKey:@"huaienID"];
    NSInteger value=model.templeIntegral;
    NSLog(@"积分制＝%ld",value);
    CheckBuddhaHallLevel *levelManager = [CheckBuddhaHallLevel   shareCheckBuddhaHallLevel];
    NSInteger   levelInteger = [levelManager checkBuddhaHallLevelWithValue:value];
    self.levelLabel.text=[NSString stringWithFormat:@"%ld级",levelInteger];
    NSInteger huaienID = [huaien  integerValue];
    self.valueLabel.text=[NSString stringWithFormat:@"%ld",model.templeIntegral];
    if (indexPath.row<3){
        self.upRankImageView.hidden=NO;
        self.valueLabel.textColor=[UIColor redColor];
        self.upBgImageView.hidden=NO;
        self.bottomBgImageView.hidden=YES;
        if([model.nickName isEqualToString:@""]){
            self.upNameLabel.text=[NSString stringWithFormat:@"%ld",model.huaienID];
        }else{
            self.upNameLabel.text=model.nickName;
        }
        if ([model.headImg hasPrefix:@"http"]){
             [self.headImageView setImageWithURL:[NSURL URLWithString:model.headImg]];
        }else{
            self.headImageView.image=[UIImage imageNamed:@"默认头像"];
        }
    }else{
        self.upRankImageView.hidden=YES;
        self.upBgImageView.hidden=YES;
        self.bottomBgImageView.hidden=NO;
    }
    if (indexPath.row==0){
        self.upRankImageView.hidden=NO;
        self.upRankImageView.image=[UIImage imageNamed:@"temple_rank_1.png"];
        self.rankLabel.text=@"";
        
    }else if (indexPath.row==1){
        self.upRankImageView.hidden=NO;
        self.upRankImageView.image=[UIImage imageNamed:@"temple_rank_2.png"];
        self.rankLabel.text=@"";
    }else if (indexPath.row==2){
        self.upRankImageView.hidden=NO;
        self.upRankImageView.image=[UIImage imageNamed:@"temple_rank_3.png"];
        self.rankLabel.text=@"";
    }else{
        self.valueLabel.textColor=WorkDayColor;
        self.upRankImageView.hidden=YES;
        self.rankLabel.text=[NSString stringWithFormat:@"%ld",(long)(indexPath.row)+1];
    }
    if (indexPath.row>3){
        if (model.huaienID==huaienID){
            self.rankLabel.textColor=[UIColor redColor];
            self.levelLabel.textColor = [UIColor redColor];
            self.valueLabel.textColor = [UIColor redColor];
            self.bottomNameLabel.textColor = [UIColor redColor];
        }
        else{
            self.rankLabel.textColor=WorkDayColor;
            self.levelLabel.textColor = WorkDayColor;
            self.valueLabel.textColor = WorkDayColor;
            self.bottomNameLabel.textColor = WorkDayColor;
        }
    }
    
  
    
}

@end
