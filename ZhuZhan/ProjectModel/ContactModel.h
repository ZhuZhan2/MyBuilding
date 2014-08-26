//
//  ContactModel.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-26.
//
//

#import <Foundation/Foundation.h>

@interface ContactModel : NSObject
@property (nonatomic,strong) NSString *a_id;
//联系人
@property (nonatomic,strong) NSString *a_contactName;
//电话
@property (nonatomic,strong) NSString *a_mobilePhone;
//拍卖单位
@property (nonatomic,strong) NSString *a_accountName;
//单位地址
@property (nonatomic,strong) NSString *a_accountAddress;
//项目ID
@property (nonatomic,strong) NSString *a_projectId;
//项目名称
@property (nonatomic,strong) NSString *a_projectName;
//岗位
@property (nonatomic,strong) NSString *a_duties;
//类别
@property (nonatomic,strong) NSString *a_category;

@property (nonatomic, copy) NSDictionary *dict;
@end
