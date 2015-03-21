//
//  ProvidePriceUploadView.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/20.
//
//

#import <UIKit/UIKit.h>

@protocol ProvidePriceUploadViewDelegate <NSObject>
-(void)upLoadBtnClickedWithNumber:(NSInteger)number;
@end

@interface ProvidePriceUploadView : UIView
+(ProvidePriceUploadView*)uploadViewWithFirstAccessory:(NSArray*)firstAccessory secondAccessory:(NSArray*)secondAccessory thirdAccessory:(NSArray*)thirdAccessory maxWidth:(CGFloat)maxWidth topDistance:(CGFloat)topDistance bottomDistance:(CGFloat)bottomDistance delegate:(id<ProvidePriceUploadViewDelegate>)delegate;
-(NSArray*)editCenters;
@end
