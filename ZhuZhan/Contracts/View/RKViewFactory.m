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
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 147, 158)];
    imageView.center = CGPointMake(kScreenWidth*0.5, CGRectGetHeight(imageView.frame)*0.5+top);
    imageView.image = [GetImagePath getImagePath:@"search_empty2"];
    
    UIView* noDataView = [[UIView alloc]init];
    noDataView.backgroundColor = AllBackLightGratColor;
    [noDataView addSubview:imageView];
    return noDataView;
}

+ (UIView *)noDataViewWithTop:(CGFloat)top{
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
    CGFloat height = [self autoLabelWithMaxWidth:maxWidth font:label.font content:label.text];
    CGRect frame = label.frame;
    frame.size = CGSizeMake(maxWidth, height);
    label.frame = frame;
    label.numberOfLines = 0;
}

/**********************************************************
 函数描述：计算label所需要的高度
 输入参数：最大宽度，label的字体
 返回值：需要的高度
 **********************************************************/
+ (CGFloat)autoLabelWithMaxWidth:(CGFloat)maxWidth font:(UIFont*)font content:(NSString*)content{
    CGRect bounds = [content boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return CGRectGetHeight(bounds);
}

/**********************************************************
 函数描述：传入label和最大宽度和最大高度
 输出参数：自适应label
 **********************************************************/
+ (void)autoLabel:(UILabel*)label maxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHieght{
    CGFloat height = [self autoLabelWithMaxWidth:maxWidth maxHeight:maxHieght font:label.font content:label.text];
    
    CGRect frame = label.frame;
    frame.size = CGSizeMake(maxWidth, height);
    label.frame = frame;
    label.numberOfLines = 0;
}

/**********************************************************
 函数描述：计算label所需要的高度
 输入参数：最大宽度，最大高度，label的字体,字符串内容
 返回值：需要的高度
 **********************************************************/
+ (CGFloat)autoLabelWithMaxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight font:(UIFont*)font content:(NSString*)content{
    CGFloat height = [self autoLabelWithMaxWidth:maxWidth font:font content:content];
    return height>maxHeight?maxHeight:height;
}

/**********************************************************
 函数描述：计算label所需要的宽度
 输入参数：label的字体,字符串内容
 返回值：需要的宽度
 **********************************************************/
+ (CGFloat)autoLabelWithFont:(UIFont*)font content:(NSString*)content{
    CGFloat width = [content boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 40) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.width;
    return width;
}

/**********************************************************
 函数描述：计算label所需要的宽度
 输入参数：label
 **********************************************************/
+ (void)autoLabel:(UILabel*)label{
    CGFloat width = [self autoLabelWithFont:label.font content:label.text];
    CGRect frame = label.frame;
    frame.size.width = width;
    label.frame = frame;
}
@end
