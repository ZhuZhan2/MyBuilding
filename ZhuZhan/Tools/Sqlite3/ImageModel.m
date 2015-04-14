//
//  ImageModel.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/4/14.
//
//

#import "ImageModel.h"

@implementation ImageModel
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.ImageData = dict[@"data"];
    self.type = dict[@"type"];
}
@end
