//
//  MapSearchViewController.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/7/7.
//
//

#import <UIKit/UIKit.h>

@interface MapSearchViewController : UIViewController

@end

//没有定位的页面
@protocol LocationErrorViewDelegate <NSObject>
-(void)reloadMap;
@end
@interface LocationErrorView : UIView
@property(nonatomic,weak)id<LocationErrorViewDelegate> delegate;
- (id)initWithFrame:(CGRect)frame;
@end