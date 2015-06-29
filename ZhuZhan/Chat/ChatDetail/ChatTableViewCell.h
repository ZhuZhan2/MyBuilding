//
//  ChatTableViewCell.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/5.
//
//

#import <UIKit/UIKit.h>
#import "ChatModel.h"
@protocol ChatTableViewCellDelegate <NSObject>
-(void)gotoContactDetailView:(NSString *)contactId;
- (void)longPressClicked:(UILongPressGestureRecognizer*)longPress;
@end

@interface ChatTableViewCell : UITableViewCell
@property(nonatomic,strong)ChatModel* model;
@property(nonatomic,weak)id<ChatTableViewCellDelegate>delegate;
+(CGFloat)carculateTotalHeightWithContentStr:(NSString*)contentStr isSelf:(BOOL)isSelf;
+(UILabel *)sendTimeLabel;
@end
