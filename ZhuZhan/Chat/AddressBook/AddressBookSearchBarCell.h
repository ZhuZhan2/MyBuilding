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

@interface AddressBookSearchBarCell : SWTableViewCell
-(void)setModel:(AddressBookSearchBarCellModel*)model indexPath:(NSIndexPath*)indexPath;
@end
