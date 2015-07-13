//
//  ChatImageModel.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/7/8.
//
//

#import "ChatImageModel.h"

@implementation ChatImageModel
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.imageId = dict[@"imageId"];
    self.ImageData = dict[@"data"];
}
@end
