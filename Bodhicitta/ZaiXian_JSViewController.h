//
//  ZaiXian_JSViewController.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/7/2.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMSegmentedControl.h"
#import "ZhuYeMianViewController.h"
#import "RESideMenu.h"
#import "DuJingViewController.h"
#import "ChaoJingViewController.h"
#import "WisdomModel.h"

@interface ZaiXian_JSViewController : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>{
    
    UIScrollView * scrollview;
    UIImageView * backgroundImage;
    UITableView * tableview;
    UILabel * nameLa;
    UILabel * liuliangLa;
    UILabel * cishuLa;
    UIButton * yincangBt;
    UIButton * seachBt;
    UIButton * fanhuiBt;
    UIButton * paihangBt;
    UIButton * bookShelfBtn;
    int numOfRows;
    BOOL isClick;
    
}

@property(retain, nonatomic) NSIndexPath *selectIndex;

@property (retain, nonatomic) NSMutableArray *dataArray;

-(void)getClassicInterface;
@end