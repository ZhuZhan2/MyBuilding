//
//  AddressBookViewCell.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/12.
//
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"
@interface AddressBookCellModel : NSObject
@property(nonatomic,copy)NSString* mainImageUrl;
@property(nonatomic,copy)NSString* mainLabelText;
@property(nonatomic)BOOL isHighlight;
@end

@protocol AddressBookViewCellDelegate <NSObject>
-(void)chooseAssistBtn:(UIButton*)btn indexPath:(NSIndexPath*)indexPath;
@end

@interface AddressBookViewCell : SWTableViewCell
-(void)setModel:(AddressBookCellModel*)model indexPath:(NSIndexPath*)indexPath;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier delegate:(id<AddressBookViewCellDelegate>)delegate;
+(UIView*)fullSeperatorLine;
@end
