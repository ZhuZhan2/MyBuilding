//
//  ContactCommentTableViewCell.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-3.
//
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
#import "ContactCommentModel.h"

@protocol ContactCommentTableViewDelegate <NSObject>

-(void)contactCommentHeadAction:(NSString *)aid;

@end
@interface ContactCommentTableViewCell : UITableViewCell{
    EGOImageView *headImageView;
    UILabel *contentLabel;
    UILabel *timeLabel;
    NSString *contactId;
}
@property(nonatomic,strong)ContactCommentModel *model;
@property(nonatomic,weak)id<ContactCommentTableViewDelegate>delegate;
@end
