//
//  TopicsTableViewCell.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-27.
//
//

#import <UIKit/UIKit.h>
#import "TopicsModel.h"
#import "EGOImageView.h"
@interface TopicsTableViewCell : UITableViewCell{
    EGOImageView *headImageView;
    UILabel *titleLabel;
    UILabel *contentLabel;
    UILabel *projectCount;
    UILabel *dateLabel;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier model:(TopicsModel *)model;
@end
