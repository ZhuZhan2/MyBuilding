//
//  AskPriceMessageModel.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/4/16.
//
//

#import <Foundation/Foundation.h>

@interface AskPriceMessageModel : NSObject
@property(nonatomic,strong)NSString *a_id;
@property(nonatomic,strong)NSString *a_title;
@property(nonatomic,strong)NSString *a_time;
@property(nonatomic,strong)NSString *a_content;
@property(nonatomic,strong)NSString *a_messageSourceId;
@property(nonatomic,strong)NSString *a_messageObjectId;
@property(nonatomic,strong)NSString *a_messageType;
@property(nonatomic,strong)NSString *a_status;
@property(nonatomic,strong)NSDictionary *dict;
@end
