//
//  TopicsDetailTableViewCell.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-27.
//
//

#import <UIKit/UIKit.h>
#import "TopicsModel.h"
#import "EGOImageView.h"
#import "YLLabel.h"
@interface TopicsDetailTableViewCell : UITableViewCell{
    EGOImageView *headImageView;
    UILabel *titleLabel;
    //UILabel *contentLabel;
    UIButton *moreBtn;
    UIImageView *arrow;
    YLLabel *contentLabel;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier model:(TopicsModel *)model;
@end
