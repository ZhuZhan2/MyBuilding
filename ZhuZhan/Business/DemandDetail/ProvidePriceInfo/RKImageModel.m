//
//  RKImageModel.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/24.
//
//

#import "RKImageModel.h"

@implementation RKImageModel

static NSInteger number=0;

+(RKImageModel*)imageModelWithImage:(UIImage*)image imageUrl:(NSString*)imageUrl isUrl:(BOOL)isUrl type:(NSString *)type{
    RKImageModel* model=[RKImageModel new];
    model.image=image;
    model.imageUrl=imageUrl;
    model.isUrl=isUrl;
    model.type = type;
    
    number++;
    model.Id=[NSString stringWithFormat:@"%d",(int)number];
    return model;
}

@end
