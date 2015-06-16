//
//  RequireCommentTableViewCell.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/6/10.
//
//

#import <UIKit/UIKit.h>
#import "ContactCommentModel.h"

@protocol RequireCommentTableViewCellDelegate <NSObject>
-(void)deleteComment:(NSIndexPath *)indexPath;
-(void)headClick:(NSIndexPath *)indexPath;
@end

@interface RequireCommentTableViewCell : UITableViewCell
@property(nonatomic,strong)UIButton *headBtn;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UIImageView *cutLine;
@property(nonatomic,strong)UIButton *delBtn;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,strong)ContactCommentModel *model;
@property(nonatomic,weak)id<RequireCommentTableViewCellDelegate>delegate;
+ (CGFloat)carculateCellHeightWithModel:(ContactCommentModel *)cellModel;
@end
