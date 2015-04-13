//
//  AddressBookSearchBarCell.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/4/8.
//
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"
@interface AddressBookSearchBarCellModel : NSObject
@property(nonatomic,copy)NSString* mainImageUrl;
@property(nonatomic,copy)NSString* mainLabelText;
@property(nonatomic)BOOL isHighlight;
@end
@protocol AddressBookSearchBarCellDelegate <NSObject>
-(void)headSearchBarClick:(NSIndexPath*)indexPath;
@end
@interface AddressBookSearchBarCell : SWTableViewCell
@property(nonatomic,weak)id<AddressBookSearchBarCellDelegate>searchDelegate;
-(void)setModel:(AddressBookSearchBarCellModel*)model indexPath:(NSIndexPath*)indexPath;
@end
