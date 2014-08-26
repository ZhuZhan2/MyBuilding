//
//  ProjectImageModel.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-26.
//
//

#import <Foundation/Foundation.h>

@interface ProjectImageModel : NSObject
@property (nonatomic,strong) NSString *a_id;
//项目id
@property (nonatomic,strong) NSString *a_projectId;
//小图
@property (nonatomic,strong) NSString *a_imageCompressLocation;
//大图
@property (nonatomic,strong) NSString *a_imageOriginalLocation;
//类型
@property (nonatomic,strong) NSString *a_imageCategory;

@property (nonatomic, copy) NSDictionary *dict;
@end
