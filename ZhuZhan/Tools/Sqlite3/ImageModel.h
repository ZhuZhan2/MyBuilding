//
//  ImageModel.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/4/14.
//
//

#import <Foundation/Foundation.h>

@interface ImageModel : NSObject
@property(nonatomic,strong)NSString *imageId;
@property(nonatomic,strong)NSData *ImageData;
@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)NSDictionary *dict;
@end
