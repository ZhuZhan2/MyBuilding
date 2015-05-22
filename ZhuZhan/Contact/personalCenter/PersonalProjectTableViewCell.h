//
//  PersonalProjectTableViewCell.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-28.
//
//

#import <UIKit/UIKit.h>
#import "PersonalCenterModel.h"
@interface PersonalProjectTableViewCell : UITableViewCell
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIImageView *cutLine1;
@property(nonatomic,strong)UIImageView *cutLine2;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)PersonalCenterModel *model;
@end
