//
//  FriendModel.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/4/9.
//
//

#import <Foundation/Foundation.h>

@interface FriendModel : NSObject
@property(nonatomic,strong)NSString *a_id;
@property(nonatomic,strong)NSString *a_name;
@property(nonatomic,strong)NSString *a_avatarUrl;
@property(nonatomic)BOOL a_isisFriend;
@property(nonatomic,strong)NSDictionary *dict;
@end
