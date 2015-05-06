//
//  SearchMenuView.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/5/5.
//
//

#import <UIKit/UIKit.h>

@protocol SearchMenuViewDelegate <NSObject>
- (void)searchMenuViewClickedWithTitle:(NSString*)title index:(NSInteger)index;
@end

@interface SearchMenuView : UIView
+ (SearchMenuView*)searchMenuViewWithTitles:(NSArray*)titles originPoint:(CGPoint)originPoint;
@property (nonatomic, weak)id<SearchMenuViewDelegate> delegate;
@end
