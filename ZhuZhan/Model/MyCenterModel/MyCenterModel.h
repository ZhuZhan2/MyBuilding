//
//  MyCenterModel.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-27.
//
//

#import <Foundation/Foundation.h>

@interface MyCenterModel : NSObject
@property (nonatomic,strong) NSString *a_id;
//用户名
@property (nonatomic,strong) NSString *a_userName;
//真是姓名
@property (nonatomic,strong) NSString *a_realName;
//职位
@property (nonatomic,strong) NSString *a_duties;
//性别
@property (nonatomic,strong) NSString *a_sex;
//电话
@property (nonatomic,strong) NSString *a_cellPhone;
//在职单位
@property (nonatomic,strong) NSString *a_company;
//邮件
@property (nonatomic,strong) NSString *a_email;
//头像
@property (nonatomic,strong) NSString *a_userImage;
//所在地
@property (nonatomic,strong) NSString *a_location;
//生日
@property (nonatomic,strong) NSString *a_birthday;
//星座
@property (nonatomic,strong) NSString *a_constellation;
//血型
@property (nonatomic,strong) NSString *a_bloodType;
//省
@property (nonatomic,strong) NSString *a_province;
//市
@property (nonatomic,strong) NSString *a_city;
//区
@property (nonatomic,strong) NSString *a_district;
@property (nonatomic,strong) NSString *a_isFriend;
@property(nonatomic,strong)NSString* a_backgroundImage;
@property(nonatomic,strong)NSString* a_userType;
@property(nonatomic,strong)NSString *a_isFocus;
@property (nonatomic, strong) NSDictionary *dict;
@end
