//
//  UserModel.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-11.
//
//

#import "UserModel.h"
static UserModel *model = nil;
@implementation UserModel
+ (instancetype)sharedUserModel {
    if(!model){
        model = [[UserModel alloc] init];
    }
    return model;
}
@end
