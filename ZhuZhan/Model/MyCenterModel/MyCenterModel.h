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
@property (nonatomic,copy) NSString *a_userName;
//真是姓名
@property (nonatomic,copy) NSString *a_realName;
//职位
@property (nonatomic,copy) NSString *a_duties;
//性别
@property (nonatomic,copy) NSString *a_sex;
//电话
@property (nonatomic,copy) NSString *a_cellPhone;
//在职单位
@property (nonatomic,copy) NSString *a_company;
//邮件
@property (nonatomic,copy) NSString *a_email;
//头像
@property (nonatomic,copy) NSString *a_userImage;
//所在地
@property (nonatomic,copy) NSString *a_location;
//生日
@property (nonatomic,copy) NSString *a_birthday;
//星座
@property (nonatomic,copy) NSString *a_constellation;
//血型
@property (nonatomic,copy) NSString *a_bloodType;

@property (nonatomic, copy) NSDictionary *dict;
@end
