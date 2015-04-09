//
//  RKSingleImageView.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/18.
//
//

#import <UIKit/UIKit.h>
#import "RKImageModel.h"

@protocol RKSingleImageDelegate <NSObject>
-(void)imageClick:(RKImageModel *)model;
@end

@interface RKSingleImageView : UIView
@property(nonatomic,strong)RKImageModel *model;
@property(nonatomic,weak)id<RKSingleImageDelegate>delegate;
+(RKSingleImageView*)singleImageViewWithImageSize:(CGSize)size model:(RKImageModel*)model isAskPrice:(BOOL)isAskPrice;
-(CGPoint)editCenter;
@end
