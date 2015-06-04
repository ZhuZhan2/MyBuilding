//
//  SingleCategoryView.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/4.
//
//

#import <UIKit/UIKit.h>

@class SingleCategoryView;
@protocol SingleCategoryViewDelegate <NSObject>
- (void)singleCategoryViewClicked:(SingleCategoryView*)singleCategoryView;
@end

@interface SingleCategoryView : UILabel
+ (SingleCategoryView*)singleCategoryViewWithCategory:(NSString*)category width:(CGFloat)width height:(CGFloat)height;
@property (nonatomic, weak)id<SingleCategoryViewDelegate> delegate;
@property (nonatomic, setter=setSelected:)BOOL isSelected;
@end
