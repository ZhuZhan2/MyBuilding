//
//  EmployeesModel.h
//  ZhuZhan
//
//  Created by 汪洋 on 14/10/22.
//
//

#import <Foundation/Foundation.h>

@interface EmployeesModel : NSObject
//ID
@property (nonatomic,strong) NSString *a_id;
//名字
@property (nonatomic,strong) NSString *a_userName;
//职位
@property (nonatomic,strong) NSString *a_duties;
//是否关注过这个人
@property (nonatomic,strong) NSString *a_isFocused;
//头像
@property (nonatomic,strong) NSString *a_userIamge;
//部门
@property (nonatomic,strong) NSString *a_department;
//公司名称
@property (nonatomic,strong) NSString *a_company;
@property (nonatomic, strong) NSDictionary *dict;
@end
