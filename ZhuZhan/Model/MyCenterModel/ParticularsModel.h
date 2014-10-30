//
//  ParticularsModel.h
//  ZhuZhan
//
//  Created by 汪洋 on 14/10/28.
//
//

#import <Foundation/Foundation.h>

@interface ParticularsModel : NSObject
@property (nonatomic,copy) NSString *a_id;
//在职单位
@property (nonatomic,copy) NSString *a_company;
//入职时间
@property (nonatomic,copy) NSString *a_inDate;
//离职时间
@property (nonatomic,copy) NSString *a_outDate;
//个人简介
@property (nonatomic,copy) NSString *a_information;

@property (nonatomic, copy) NSDictionary *dict;
@end
