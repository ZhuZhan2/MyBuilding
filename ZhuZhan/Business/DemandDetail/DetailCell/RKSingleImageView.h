//
//  RKSingleImageView.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/18.
//
//

#import <UIKit/UIKit.h>
#import "RKImageModel.h"
@interface RKSingleImageView : UIView
+(RKSingleImageView*)singleImageViewWithImageSize:(CGSize)size model:(RKImageModel*)model;
-(CGPoint)editCenter;
@end
