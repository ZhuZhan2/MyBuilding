//
//  PersonalProjectTableViewCell.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-28.
//
//

#import <UIKit/UIKit.h>
#import "PersonalCenterModel.h"
@interface PersonalProjectTableViewCell : UITableViewCell{
    UIImageView *stageImage;
    UILabel *titleLabel;
    UILabel *contentLabel;
}
@property(nonatomic,strong)PersonalCenterModel *model;
@end
