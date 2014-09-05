//
//  MoreCompanyViewCell.m
//  ZhuZhan
//
//  Created by 孙元侃 on 14-9-4.
//
//

#import "MoreCompanyViewCell.h"

@implementation MoreCompanyViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(MoreCompanyViewCell *)getCellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    MoreCompanyViewCell* cell=[tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (!cell.myImageView) {
        //公司图片
        cell.myImageView=[[UIImageView alloc]initWithFrame:CGRectMake(5, 0, 94, 94)];
        
        //公司名称
        cell.companyNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(99, 18, 210, 15)];
        cell.companyNameLabel.textColor=RGBCOLOR(62, 127, 226);
        cell.companyNameLabel.font=[UIFont boldSystemFontOfSize:15];
        
        //公司行业
        cell.companyBusiness=[[UILabel alloc]initWithFrame:CGRectMake(99, 39, 210, 15)];
        cell.companyBusiness.font=[UIFont boldSystemFontOfSize:13];
        cell.companyBusiness.textColor=RGBCOLOR(98, 98, 98);
        
        //公司介绍
        cell.companyIntroduce=[[UILabel alloc]initWithFrame:CGRectMake(99, 58, 210, 15)];
        cell.companyIntroduce.font=[UIFont boldSystemFontOfSize:13];
        cell.companyIntroduce.textColor=RGBCOLOR(98, 98, 98);
        cell.companyIntroduce.numberOfLines=2;
        
        [cell addSubview:cell.myImageView];
        [cell addSubview:cell.companyNameLabel];
        [cell addSubview:cell.companyBusiness];
        [cell addSubview:cell.companyIntroduce];

    }
    return cell;
}
@end
