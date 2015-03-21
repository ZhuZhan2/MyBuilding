//
//  RKLeftAndRightView.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/20.
//
//

#import <UIKit/UIKit.h>

@interface RKLeftAndRightView : UIView
+(RKLeftAndRightView*)upAndDownViewWithUpContent:(NSString*)upContent downContent:(NSString*)downContent topDistance:(CGFloat)topDistance bottomDistance:(CGFloat)bottomDistance maxWidth:(CGFloat)maxWidth;
@end
