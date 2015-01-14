//
//  ParticularsModel.h
//  ZhuZhan
//
//  Created by 汪洋 on 14/10/28.
//
//

#import <Foundation/Foundation.h>

@interface ParticularsModel : NSObject
@property (nonatomic,strong) NSString *a_id;
//在职单位
@property (nonatomic,strong) NSString *a_company;
//入职时间
@property (nonatomic,strong) NSString *a_inDate;
//离职时间
@property (nonatomic,strong) NSString *a_outDate;
//个人简介
@property (nonatomic,strong) NSString *a_information;
//是否在职
@property (nonatomic,strong) NSString *a_isIn;

@property (nonatomic, strong) NSDictionary *dict;
@end
