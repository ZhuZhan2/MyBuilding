//
//  RKImageModel.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/24.
//
//

#import <Foundation/Foundation.h>

@interface RKImageModel : NSObject
@property(nonatomic,strong)UIImage* image;
@property(nonatomic,copy)NSString* imageUrl;
@property(nonatomic,copy)NSString* type;
@property(nonatomic,copy)NSString* bigImageUrl;
@property(nonatomic,copy)NSString* name;
@property(nonatomic)BOOL isUrl;
+(RKImageModel*)imageModelWithImage:(UIImage*)image imageUrl:(NSString*)imageUrl isUrl:(BOOL)isUrl type:(NSString *)type;
@end
