//
//  RKViewFactory.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/26.
//
//

#import "RKViewFactory.h"

@implementation RKViewFactory
+ (UIView *)noHistorySearchResultsViewWithTop:(CGFloat)top{
    UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 152, 158)];
    imageView.center = CGPointMake(kScreenWidth*0.5, CGRectGetHeight(imageView.frame)*0.5+top);
    imageView.image = [GetImagePath getImagePath:@"search_empty"];
    
    UIView* noDataView = [[UIView alloc]init];
    noDataView.backgroundColor = [UIColor whiteColor];
    [noDataView addSubview:imageView];
    return noDataView;
}

+ (UIView *)noSearchResultsViewWithTop:(CGFloat)top{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 154, 123)];
    imageView.center = CGPointMake(kScreenWidth*0.5, CGRectGetHeight(imageView.frame)*0.5+top);
    imageView.image = [GetImagePath getImagePath:@"暂无内容"];
    
    UIView* noDataView = [[UIView alloc]init];
    noDataView.backgroundColor = AllBackLightGratColor;
    [noDataView addSubview:imageView];
    return noDataView;
}

+ (void)imageViewWithImageView:(UIImageView*)imageView imageUrl:(NSString*)imageUrl defaultImageName:(NSString*)defaultImageName{
    imageView.backgroundColor = [UIColor grayColor];
    imageView.userInteractionEnabled = YES;
    imageView.clipsToBounds = YES;
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[GetImagePath getImagePath:defaultImageName] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) return;
        UIImage* newImage = [self reSizeImage:image toSize:imageView.frame.size];
        imageView.image = newImage;
    }];
}

+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    CGFloat x = -(image.size.width/2-reSize.width)/2;
    CGFloat y = -(image.size.height/2-reSize.height)/2;
    [image drawInRect:CGRectMake(x, y, image.size.width/2, image.size.height/2)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}
@end
