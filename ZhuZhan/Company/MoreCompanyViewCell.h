//
//  MoreCompanyViewCell.h
//  ZhuZhan
//
//  Created by 孙元侃 on 14-9-4.
//
//

#import <UIKit/UIKit.h>
@interface MoreCompanyViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView* myImageView;//公司图片
@property(nonatomic,strong)UILabel* companyNameLabel;//公司名称
@property(nonatomic,strong)UILabel* companyBusiness;//公司行业
@property(nonatomic,strong)UILabel* companyIntroduce;//公司介绍

+(MoreCompanyViewCell*)getCellWithTableView:(UITableView*)tableView style:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
