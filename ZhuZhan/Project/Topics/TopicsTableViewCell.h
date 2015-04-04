//
//  TopicsTableViewCell.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-27.
//
//

#import <UIKit/UIKit.h>
#import "TopicsModel.h"
@interface TopicsTableViewCell : UITableViewCell{
    UIImageView *headImageView;
    UILabel *titleLabel;
    UILabel *contentLabel;
    UILabel *projectCount;
    UILabel *dateLabel;
}
@property(nonatomic,strong)TopicsModel *model;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier model:(TopicsModel *)model;
@end
