//
//  BeadsRankViewCell.h
//  Bodhicitta
//
//  Created by 怀恩2 on 15/8/24.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RankingModel.h"

@interface BeadsRankViewCell : UITableViewCell

@property(nonatomic,strong) RankingModel * rankmodel;
-(void)setrankModel:(RankingModel *)rankmodel IndexPath:(NSIndexPath *) indexPath;
@property(nonatomic,strong) id up;
@end
