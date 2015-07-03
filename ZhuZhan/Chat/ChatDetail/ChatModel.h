//
//  ChatModel.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/5.
//
//

#import <Foundation/Foundation.h>

typedef enum{
    ChatMessageStatusSucess,
    ChatMessageStatusProcess,
    ChatMessageStatusFail
}ChatMessageStatus;

@interface ChatModel : NSObject
@property(nonatomic,copy)NSString* ID;
@property(nonatomic,copy)NSString* time;
@property(nonatomic,copy)NSString* userImageStr;
@property(nonatomic,copy)NSString* userNameStr;
@property(nonatomic,copy)NSString* chatContent;
@property (nonatomic)ChatMessageStatus messageStatus;
@property(nonatomic)BOOL isSelf;
@end
