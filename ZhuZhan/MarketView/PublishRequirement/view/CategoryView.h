//
//  CategoryView.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/4.
//
//

#import <UIKit/UIKit.h>

@protocol CategoryViewDelegate <NSObject>
@optional
- (void)categoryViewClickedWithCategory:(NSString*)category index:(NSInteger)index;
@end

@interface CategoryView : UIView
+ (CategoryView*)categoryViewWithCategoryArr:(NSArray*)categoryArr;
@property (nonatomic, weak)id<CategoryViewDelegate> delegate;
@property (nonatomic, strong)UIView* bottomView;
- (void)singleCategoryViewClickedWithIndex:(NSInteger)index;
@end
