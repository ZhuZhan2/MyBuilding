//
//  ChatGroupMemberModel.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/4/13.
//
//

#import <Foundation/Foundation.h>

@interface ChatGroupMemberModel : NSObject
@property(nonatomic,strong)NSString *a_createdTime;
@property(nonatomic,strong)NSString *a_createdUser;
@property(nonatomic,strong)NSString *a_groupId;
@property(nonatomic,strong)NSString *a_loginId;
@property(nonatomic,strong)NSString *a_loginImagesId;
@property(nonatomic,strong)NSString *a_loginName;
@property(nonatomic,strong)NSString *a_nickName;
@property(nonatomic,strong)NSDictionary *dict;
@end
