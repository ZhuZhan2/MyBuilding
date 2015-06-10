//
//  RequireCommentTableViewCell.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/6/10.
//
//

#import <UIKit/UIKit.h>
#import "ContactCommentModel.h"
@interface RequireCommentTableViewCell : UITableViewCell
@property(nonatomic,strong)UIButton *headBtn;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UIImageView *cutLine;
@property(nonatomic,strong)ContactCommentModel *model;
+ (CGFloat)carculateCellHeightWithModel:(ContactCommentModel *)cellModel;
@end
