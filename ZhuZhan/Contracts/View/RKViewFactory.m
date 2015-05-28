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
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 130, 177)];
    imageView.center = CGPointMake(kScreenWidth*0.5, CGRectGetHeight(imageView.frame)*0.5+top);
    imageView.image = [GetImagePath getImagePath:@"nodata"];
    
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
        UIImage* newImage = [self resizeImage:image toSize:imageView.frame.size];
        imageView.image = newImage;
    }];
}

+ (UIImage *)resizeImage:(UIImage *)image toSize:(CGSize)reSize{
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, reSize.width, reSize.height)];
    view.clipsToBounds = YES;
    
    CGSize imageSize = CGSizeMake(image.size.width/2, image.size.height/2);
    
    CGFloat x = (reSize.width-imageSize.width)/2;
    CGFloat y = (reSize.height-imageSize.height)/2;

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, imageSize.width, imageSize.height)];
    imageView.image=image;
    [view addSubview:imageView];
    
    return [self convertViewAsImage:view];
}

+ (UIImage *)convertViewAsImage:(UIView *)aview {
    UIGraphicsBeginImageContext(aview.bounds.size);
    [aview.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**********************************************************
 函数描述：传入label和最大宽度
 输出参数：自适应label
 **********************************************************/
+ (void)autoLabel:(UILabel*)label maxWidth:(CGFloat)maxWidth{
    CGRect bounds = [label.text boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label.font} context:nil];
    CGRect frame = label.frame;
    frame.size = CGSizeMake(maxWidth, bounds.size.height);
    label.frame = frame;
    label.numberOfLines = 0;
}
@end
