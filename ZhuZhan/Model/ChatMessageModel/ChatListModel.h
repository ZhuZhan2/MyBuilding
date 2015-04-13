//
//  ChatListModel.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/4/11.
//
//

#import <Foundation/Foundation.h>

@interface ChatListModel : NSObject
@property(nonatomic,strong)NSString *a_chatlogId;
@property(nonatomic,strong)NSString *a_loginId;
@property(nonatomic,strong)NSString *a_groupId;
@property(nonatomic,strong)NSString *a_groupName;
//01用户 02群
@property(nonatomic,strong)NSString *a_type;
@property(nonatomic,strong)NSString *a_loginImageUrl;
@property(nonatomic,strong)NSString *a_loginName;
@property(nonatomic,strong)NSString *a_content;
@property(nonatomic,strong)NSString *a_msgCount;
@property(nonatomic)BOOL a_isShow;
@property(nonatomic,strong)NSDictionary *dict;
@end
