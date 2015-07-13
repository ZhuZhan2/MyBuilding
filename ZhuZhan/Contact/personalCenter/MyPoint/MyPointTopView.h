//
//  MyPointTopView.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/7/13.
//
//

#import <UIKit/UIKit.h>

@protocol MyPointTopViewDelegate <NSObject>
-(void)gotoPointDetailView:(NSInteger)tag;
@end

@interface MyPointTopView : UIView
@property(nonatomic,weak)id<MyPointTopViewDelegate>delegate;
-(void)setPoint:(NSString *)point;
@end
