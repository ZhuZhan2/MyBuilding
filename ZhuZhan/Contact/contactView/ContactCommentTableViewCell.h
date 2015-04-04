//
//  ContactCommentTableViewCell.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-3.
//
//

#import <UIKit/UIKit.h>
#import "ContactCommentModel.h"

@protocol ContactCommentTableViewDelegate <NSObject>

-(void)contactCommentHeadAction:(NSString *)aid userType:(NSString *)userType;

@end
@interface ContactCommentTableViewCell : UITableViewCell{
    UIImageView *headImageView;
    UILabel *contentLabel;
    UILabel *timeLabel;
    NSString *contactId;
    NSString *userType;
}
@property(nonatomic,strong)ContactCommentModel *model;
@property(nonatomic,weak)id<ContactCommentTableViewDelegate>delegate;
@end
