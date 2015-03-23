//
//  AskPriceModel.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/20.
//
//

#import <Foundation/Foundation.h>

@interface AskPriceModel : NSObject
@property(nonatomic,strong)NSString *a_id;
//流水号
@property(nonatomic,strong)NSString *a_tradeCode;
//状态
@property(nonatomic,strong)NSString *a_tradeStatus;
//询价人id
@property(nonatomic,strong)NSString *a_createdBy;
//询价人名字
@property(nonatomic,strong)NSString *a_requestName;
//参与人
@property(nonatomic,strong)NSString *a_invitedUser;
@property(nonatomic,strong)NSArray *a_invitedUserArr;
//大类
@property(nonatomic,strong)NSString *a_productBigCategory;
//分类
@property(nonatomic,strong)NSString *a_productCategory;
//描述
@property(nonatomic,strong)NSString *a_remark;
@property(nonatomic,strong)NSDictionary *dict;
@end

@interface InvitedUserModel : NSObject
@property(nonatomic,strong)NSString *a_id;
@property(nonatomic,strong)NSString *a_name;
@property(nonatomic,strong)NSString *a_status;
@property(nonatomic,strong)NSDictionary *dict;
@end
