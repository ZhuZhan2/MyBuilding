//
//  UserModel.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-11.
//
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
@property(nonatomic,copy)NSString *userId;
@property(nonatomic,copy)NSString *userName;
@property(nonatomic,copy)NSString *userImageUrl;
@property(nonatomic,copy)NSString *userBackGroundUrl;
+ (instancetype)sharedUserModel;
@end
