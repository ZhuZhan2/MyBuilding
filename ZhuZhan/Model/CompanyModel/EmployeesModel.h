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
@property (nonatomic,copy) NSString *a_id;
//名字
@property (nonatomic,copy) NSString *a_userName;
//职位
@property (nonatomic,copy) NSString *a_duties;
//是否关注过这个人
@property (nonatomic,copy) NSString *a_isFocused;
//头像
@property (nonatomic,copy) NSString *a_userIamge;
//部门
@property (nonatomic,copy) NSString *a_department;

@property (nonatomic, copy) NSDictionary *dict;
@end
