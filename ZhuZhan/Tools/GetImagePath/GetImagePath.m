//
//  GetImagePath.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-19.
//
//

#import "GetImagePath.h"

@implementation GetImagePath
+(UIImage *)getImagePath:(NSString *)imageName{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:imagePath];
    return image;
}
@end
