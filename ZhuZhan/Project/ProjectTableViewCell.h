//
//  ProjectTableViewCell.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-26.
//
//

#import <UIKit/UIKit.h>
#import "projectModel.h"
@interface ProjectTableViewCell : UITableViewCell{
    NSString *stage;
    UILabel *nameLabel;
    UILabel *investmentLabel;
    UILabel *investmentcountLabel;
    UILabel *areaLabel;
    UILabel *areacountLabel;
    UIImageView *progressImage;
    UILabel *startdateLabel;
    UILabel *enddateLabel;
    UILabel *addressLabel;
    int flag;
}
@property(nonatomic,weak)projectModel *model;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier model:(projectModel *)model fromView:(NSString *)fromView;
@end
