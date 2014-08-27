//
//  MyCenterModel.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-27.
//
//

#import <Foundation/Foundation.h>

@interface MyCenterModel : NSObject
@property (nonatomic,copy) NSString *a_id;
//用户名
@property (nonatomic,copy) NSString *a_name;
//职位
@property (nonatomic,copy) NSString *a_duties;
//性别
@property (nonatomic,copy) NSString *a_sex;
//电话
@property (nonatomic,copy) NSString *a_phone;
//在职单位
@property (nonatomic,copy) NSString *a_company;

@property (nonatomic, copy) NSDictionary *dict;
@end
