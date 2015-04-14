//
//  AddressBookFriendCell.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/9.
//
//

#import "ChatBaseViewController.h"

typedef enum AddressBookFriendCellAssistStyle{
    AddressBookFriendCellAssistNotFinished,
    AddressBookFriendCellAssistIsFinished,
    AddressBookFriendCellAssistNotExist
}AddressBookFriendCellAssistStyle;

@interface AddressBookFriendCellModel : NSObject
@property(nonatomic,copy)NSString* mainLabelText;
@property(nonatomic)AddressBookFriendCellAssistStyle assistStyle;
@end

@protocol AddressBookFriendCellDelegate <NSObject>
-(void)chooseAssistBtn:(UIButton*)btn indexPath:(NSIndexPath*)indexPath;
@end

@interface AddressBookFriendCell : UITableViewCell
-(void)setModel:(AddressBookFriendCellModel*)model indexPath:(NSIndexPath*)indexPath;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier delegate:(id<AddressBookFriendCellDelegate>)delegate;
@end
