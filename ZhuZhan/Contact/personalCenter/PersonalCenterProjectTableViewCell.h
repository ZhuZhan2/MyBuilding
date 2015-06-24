//
//  PersonalCenterProjectTableViewCell.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/6/24.
//
//

#import <UIKit/UIKit.h>

@interface PersonalCenterProjectTableViewCell : UITableViewCell
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIImageView *cutLine1;
@property(nonatomic,strong)UIImageView *cutLine2;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)NSString *companyName;
@property(nonatomic,strong)NSString *time;
@property(nonatomic,strong)NSString *projectDemo;
@end
