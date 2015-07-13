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
/**
 *  从外部设置积分
 *
 *  @param point 传入的积分值
 */
-(void)setPoint:(NSString *)point;

/**
 *  从外部设置是否异常
 *
 *  @param status 异常的判断 00正常 01不正常
 */
-(void)setStatus:(NSString *)status;
@end
