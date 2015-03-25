//
//  RKImageModel.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/24.
//
//

#import "RKImageModel.h"

@implementation RKImageModel
+(RKImageModel*)imageModelWithImage:(UIImage*)image imageUrl:(NSString*)imageUrl isUrl:(BOOL)isUrl{
    RKImageModel* model=[RKImageModel new];
    model.image=image;
    model.imageUrl=imageUrl;
    model.isUrl=isUrl;
    return model;
}

@end
