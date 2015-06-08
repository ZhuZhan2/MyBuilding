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

@property(nonatomic,strong)NSDictionary *dict;
@end
