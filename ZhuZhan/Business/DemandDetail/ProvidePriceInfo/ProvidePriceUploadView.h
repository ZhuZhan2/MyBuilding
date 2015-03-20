//
//  ProvidePriceUploadView.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/20.
//
//

#import <UIKit/UIKit.h>

@interface ProvidePriceUploadView : UIView
+(ProvidePriceUploadView*)uploadViewWithFirstAccessorys:(NSArray*)firstAccessorys secondAccessory:(NSArray*)secondAccessory thirdAccessory:(NSArray*)thirdAccessory maxWidth:(CGFloat)maxWidth topDistance:(CGFloat)topDistance bottomDistance:(CGFloat)bottomDistance;
@end
