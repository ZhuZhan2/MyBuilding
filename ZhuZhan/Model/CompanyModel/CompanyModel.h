//
//  CompanyModel.h
//  ZhuZhan
//
//  Created by 汪洋 on 14/10/20.
//
//

#import <Foundation/Foundation.h>

@interface CompanyModel : NSObject
//公司ID
@property (nonatomic,copy) NSString *a_id;
//公司名字
@property (nonatomic,copy) NSString *a_companyName;
//公司行业
@property (nonatomic,copy) NSString *a_companyIndustry;
//公司被关注数
@property (nonatomic,copy) NSString *a_companyFocusNumber;
//公司员工数
@property (nonatomic,copy) NSString *a_companyEmployeeNumber;
//公司简介
@property (nonatomic,copy) NSString *a_companyDescription;
//公司图片
@property (nonatomic,copy) NSString *a_companyLogo;
//是否被关注
@property (nonatomic,copy) NSString *a_focused;
//公司联系人
@property (nonatomic,copy) NSString *a_companyContactName;
//公司联系人电话
@property (nonatomic,copy) NSString *a_companyContactCellphone;
//公司联系人邮箱
@property (nonatomic,copy) NSString *a_companyContactEmail;
//公司所在地
@property (nonatomic,copy) NSString *a_companyLocation;

@property (nonatomic, copy) NSDictionary *dict;
@end
