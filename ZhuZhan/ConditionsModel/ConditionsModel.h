//
//  ConditionsModel.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-1.
//
//

#import <Foundation/Foundation.h>

@interface ConditionsModel : NSObject
@property (nonatomic,copy) NSString *a_id;
//搜索条件名字
@property (nonatomic,copy) NSString *a_searchName;
//搜索条件内容
@property (nonatomic,copy) NSString *a_searchConditions;
//保存的人的id
@property (nonatomic,copy) NSString *a_createBy;

@property (nonatomic, copy) NSDictionary *dict;
@end
