//
//  SearchContactTableViewCell.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/19.
//
//

#import <UIKit/UIKit.h>
#import "UserOrCompanyModel.h"

@interface SearchContactTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *companyName;
@property(nonatomic,strong)UIImageView *lineImageView;
@property(nonatomic,strong)UserOrCompanyModel *model;
+(UIView*)fullSeperatorLine;
@end
