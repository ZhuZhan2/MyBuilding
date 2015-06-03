//
//  PersonalCenterCompanyTableViewCell.h
//  ZhuZhan
//
//  Created by 汪洋 on 14/12/22.
//
//

#import <UIKit/UIKit.h>
@interface PersonalCenterCompanyTableViewCell : UITableViewCell
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIImageView *cutLine1;
@property(nonatomic,strong)UIImageView *cutLine2;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UIImageView *headImage;
@property(nonatomic,strong)NSString *companyName;
@property(nonatomic,strong)NSString *imageUrl;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
