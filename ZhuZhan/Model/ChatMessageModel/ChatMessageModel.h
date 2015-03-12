//
//  ChatMessageModel.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/10.
//
//

#import <Foundation/Foundation.h>
typedef enum {
    chatTypeMe = 0, // 自己发的
    chatTypeOther = 1 //别人发得
} ChatType;
@interface ChatMessageModel : NSObject
@property(nonatomic)ChatType a_type;
@property(nonatomic,strong)NSString *a_id;
@property(nonatomic,strong)NSString *a_name;
@property(nonatomic,strong)NSString *a_avatarUrl;
@property(nonatomic,strong)NSString *a_message;
@property(nonatomic,strong)NSString *a_time;
@property(nonatomic,strong)NSString *a_userId;
@property(nonatomic,strong)NSString *a_hasChatId;
@property(nonatomic,strong)NSDictionary *dict;
@end
