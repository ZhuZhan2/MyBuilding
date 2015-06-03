//
//  ContactsActiveCell.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/1.
//
//

#import "BaseTableViewCell.h"
#import "ContactsActiveCellModel.h"

@protocol ContactsActiveCellDelegate <NSObject>
- (void)contactsUserImageClickedWithIndexPath:(NSIndexPath*)indexPath;
- (void)contactsCommentBtnClickedWithIndexPath:(NSIndexPath*)indexPath;
@end

@interface ContactsActiveCell :BaseTableViewCell
@property (nonatomic, weak)id<ContactsActiveCellDelegate> delegate;
+ (CGFloat)carculateCellHeightWithModel:(ContactsActiveCellModel *)cellModel;
- (void)setModel:(ContactsActiveCellModel *)model isActive:(BOOL)isActive;
@end
