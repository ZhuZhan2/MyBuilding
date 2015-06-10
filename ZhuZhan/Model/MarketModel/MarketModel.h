//
//  MarketModel.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/6/4.
//
//

#import <Foundation/Foundation.h>

@interface MarketModel : NSObject
@property(nonatomic,strong)NSString *a_id;
@property(nonatomic,strong)NSString *a_loginName;
@property(nonatomic,strong)NSString *a_avatarUrl;
@property(nonatomic,strong)NSString *a_loginId;
@property(nonatomic,strong)NSString *a_createdTime;
@property(nonatomic,strong)NSString *a_reqTypeCn;
@property(nonatomic,strong)NSString *a_address;
@property(nonatomic,strong)NSString *a_reqDesc;
@property(nonatomic,strong)NSString *a_money;
@property(nonatomic,strong)NSString *a_bigTypeCn;
@property(nonatomic,strong)NSString *a_smallTypeCn;
@property(nonatomic,strong)NSString *a_commentCount;
@property(nonatomic,strong)NSString *a_city;
/*************************************
找项目	1
找材料	2
找关系	3
找合作	4
其他	    5
*************************************/
@property(nonatomic)int a_reqType;
@property(nonatomic)BOOL a_needRound;
@property(nonatomic)BOOL a_isSelf;
@property(nonatomic)BOOL a_isFriend;

@property(nonatomic,strong)NSDictionary *dict;
@end
