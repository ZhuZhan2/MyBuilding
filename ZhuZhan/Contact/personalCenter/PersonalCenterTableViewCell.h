//
//  PersonalCenterTableViewCell.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/6/4.
//
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
#import "PersonalCenterModel.h"
@interface PersonalCenterTableViewCell : BaseTableViewCell
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIImageView *bigImageView;
@property(nonatomic,strong)UIImageView *cutline1;
@property(nonatomic,strong)UIImageView *cutline2;
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UILabel *typeLabel;
@property(nonatomic,strong)UILabel *timelabel;
@property(nonatomic,strong)PersonalCenterModel *personalCentermodel;
+ (CGFloat)carculateCellHeightWithModel:(PersonalCenterModel *)cellModel;
@end
