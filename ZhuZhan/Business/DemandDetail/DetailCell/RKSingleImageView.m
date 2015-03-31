//
//  RKSingleImageView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/18.
//
//

#import "RKSingleImageView.h"
#import "EGOImageView.h"
@implementation RKSingleImageView
+(RKSingleImageView *)singleImageViewWithImageSize:(CGSize)size model:(RKImageModel *)model{
    RKSingleImageView* view=[[RKSingleImageView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    EGOImageView* imageView=[[EGOImageView alloc]initWithPlaceholderImage:[GetImagePath getImagePath:@"人脉_06a2@2x"]];
    imageView.frame=view.bounds;
    if (model.isUrl) {
        imageView.imageURL=[NSURL URLWithString:model.imageUrl];
    }else{
        imageView.image=model.image;
    }
    [view addSubview:imageView];
    return view;
}

-(CGPoint)editCenter{
    CGFloat x=CGRectGetWidth(self.frame);
    CGFloat y=0;
    return CGPointMake(x, y);
}
@end
