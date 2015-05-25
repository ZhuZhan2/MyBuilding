//
//  MyFocusProductCell.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/5/22.
//
//

#import <UIKit/UIKit.h>
#import "MyFocusProductCellModel.h"
@protocol MyFocusProductCellDelegate <NSObject>
- (void)focusBtnClicked:(NSIndexPath*)indexPath;
@end

@interface MyFocusProductCell : UITableViewCell
@property (nonatomic, strong)MyFocusProductCellModel* model;
@property (nonatomic, weak)id<MyFocusProductCellDelegate> delegate;
@property (nonatomic, copy)NSString* mainImageName;
+ (CGFloat)totalHeight;
@end
