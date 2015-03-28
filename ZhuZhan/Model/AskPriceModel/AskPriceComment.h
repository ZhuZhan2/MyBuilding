//
//  AskPriceComment.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/27.
//
//

#import <Foundation/Foundation.h>

@interface AskPriceComment : NSObject
@property(nonatomic,strong)NSString *a_id;
//发评论人的名字
@property(nonatomic,strong)NSString *a_name;
//内容
@property(nonatomic,strong)NSString *a_contents;
//流水号
@property(nonatomic,strong)NSString *a_tradeCode;
//询价id
@property(nonatomic,strong)NSString *a_tradeId;
 //不知道什么东西
@property(nonatomic,strong)NSString *a_tradeUserAndCommentUser;
//发起人id
@property(nonatomic,strong)NSString *a_createdBy;
//时间
@property(nonatomic,strong)NSString *a_createdTime;
//报价id
@property(nonatomic,strong)NSString *a_quoteId;
//大v
@property(nonatomic,strong)NSString *a_isVerified;
@property(nonatomic)BOOL a_isSelf;
@property(nonatomic,strong)NSDictionary *dict;
@end
