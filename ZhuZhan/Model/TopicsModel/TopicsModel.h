//
//  TopicsModel.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-27.
//
//

#import <Foundation/Foundation.h>

@interface TopicsModel : NSObject
@property (nonatomic,strong) NSString *a_id;
//title
@property (nonatomic,strong) NSString *a_title;
//内容
@property (nonatomic,strong) NSString *a_content;
//图片
@property (nonatomic,strong) NSString *a_image;
//project数量
@property (nonatomic,strong) NSString *a_projectCount;
//发布时间
@property (nonatomic,strong) NSString *a_publishTime;

@property (nonatomic, strong) NSDictionary *dict;
@end
