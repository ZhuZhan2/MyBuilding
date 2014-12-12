//
//  LoginModel.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-25.
//
//

#import <Foundation/Foundation.h>

@interface LoginModel : NSObject
//用户id
@property (nonatomic,copy) NSString *a_userId;
//deviceToken
@property (nonatomic,copy) NSString *a_deviceToken;
//userType
@property (nonatomic,copy) NSString *a_userType;
//userName
@property (nonatomic,copy) NSString *a_userName;
//loginStatus
@property (nonatomic,copy) NSString *a_loginStatus;
//是否有公司认证
@property (nonatomic,copy) NSString *a_hasCompany;
//是否有公司认证
@property (nonatomic,copy) NSString *a_userImage;
@property(nonatomic,copy)NSString* a_backgroundImage;
@property (nonatomic,copy) NSDictionary *dict;


//生成验证码
+ (NSURLSessionDataTask *)GenerateWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//注册
+ (NSURLSessionDataTask *)RegisterWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//登录
+ (NSURLSessionDataTask *)LoginWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//退出
+ (NSURLSessionDataTask *)LogoutWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block noNetWork:(void(^)())noNetWork;

//脸部登录
+ (NSURLSessionDataTask *)PostFaceLoginWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//脸部注册
+ (NSURLSessionDataTask *)RegisterFaceWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//用户注销
+ (NSURLSessionDataTask *)PostLogOutWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//完善用户信息
+ (NSURLSessionDataTask *)PostInformationImprovedWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//更新个人背景
+ (NSURLSessionDataTask *)UpdateUserParticularsWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//新增个人背景
+ (NSURLSessionDataTask *)AddUserParticularsWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//获取个人信息
+ (NSURLSessionDataTask *)GetUserInformationWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block userId:(NSString *)userId noNetWork:(void(^)())noNetWork;

//添加头像
+ (NSURLSessionDataTask *)AddUserImageWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//添加背景
+ (NSURLSessionDataTask *)AddBackgroundImageWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//获取头像
+ (NSURLSessionDataTask *)GetUserImagesWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block userId:(NSString *)userId noNetWork:(void(^)())noNetWork;

//修改密码
+ (NSURLSessionDataTask *)ChangePasswordWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;
@end
