//
//  ContactTableViewCell.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-3.
//
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
#import "CommentModel.h"

@protocol ContactTableViewCellDelegate <NSObject>

-(void)ShowUserPanView:(UIButton *)button;

@end
@interface ContactTableViewCell : UITableViewCell{
    EGOImageView *headImageView;
    UIImageView *stageImage;
    UILabel *titleLabel;
    UILabel *nameLabel;
    UILabel *jobLabel;
}
@property(nonatomic,weak)CommentModel *model;
@property(nonatomic,strong)id<ContactTableViewCellDelegate>delegate;
@end
