//
//  BannerImagesModel.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/7/1.
//
//

#import "BannerImagesModel.h"

@implementation BannerImagesModel
-(void)setDict:(NSDictionary *)dict{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    _dict = dict;
    self.a_id = dict[@"bannerImagesId"];
    self.a_imageUrl = [NSString stringWithFormat:@"%@%@",[userDefaults objectForKey:@"serverAddress"],image(dict[@"bannerImagesId"], @"banner", @"640", @"200", @"")];
    self.a_webUrl = dict[@"targetUrl"];
}
@end
