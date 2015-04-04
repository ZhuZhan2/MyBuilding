//
//  RKSingleImageView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/18.
//
//

#import "RKSingleImageView.h"
@implementation RKSingleImageView
+(RKSingleImageView *)singleImageViewWithImageSize:(CGSize)size model:(RKImageModel *)model isAskPrice:(BOOL)isAskPrice{
    RKSingleImageView* view=[[RKSingleImageView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    view.model = model;
    UIImage *image = nil;
    if([model.type isEqualToString:@"xlsx"]){
        image = [GetImagePath getImagePath:@"xlsx"];
    }else if ([model.type isEqualToString:@"docx"]){
        image = [GetImagePath getImagePath:@"word"];
    }else{
        image = [GetImagePath getImagePath:@"人脉_06a2"];
    }
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:view.bounds];
    if (model.isUrl) {
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[GetImagePath getImagePath:@"人脉_06a2"]];
    }else{
        imageView.image=model.image;
    }
    [view addSubview:imageView];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = imageView.frame;
    [btn addTarget:view action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    btn.enabled = isAskPrice;
    return view;
}

-(CGPoint)editCenter{
    CGFloat x=CGRectGetWidth(self.frame);
    CGFloat y=0;
    return CGPointMake(x, y);
}

-(void)btnAction{
    if([self.delegate respondsToSelector:@selector(imageClick:)]){
        [self.delegate imageClick:self.model.imageUrl];
    }
}
@end
