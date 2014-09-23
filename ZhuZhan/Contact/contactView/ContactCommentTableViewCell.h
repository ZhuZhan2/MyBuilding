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
@interface ContactCommentTableViewCell : UITableViewCell{
    EGOImageView *headImageView;
    UILabel *contentLabel;
    UILabel *timeLabel;
}
@property(nonatomic,strong)ContactCommentModel *model;
@end
