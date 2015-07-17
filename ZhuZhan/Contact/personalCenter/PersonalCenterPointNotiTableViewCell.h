//
//  PersonalCenterPointNotiTableViewCell.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/7/17.
//
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
#import "PersonalCenterModel.h"

@interface PersonalCenterPointNotiTableViewCell : BaseTableViewCell
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIImageView *cutline1;
@property(nonatomic,strong)UIImageView *cutline2;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)PersonalCenterModel *personalCenterModel;
+ (CGFloat)carculateCellHeightWithModel:(PersonalCenterModel *)cellModel;
@end
