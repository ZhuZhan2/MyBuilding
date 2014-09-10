//
//  ContactModel.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-25.
//
//

#import <Foundation/Foundation.h>

@interface ContactModel : NSObject



//电子邮件
@property (nonatomic,copy) NSString * email;

//手机号码
@property (nonatomic,copy) NSString * cellPhone;

//联系方式图标数组
@property (nonatomic,copy) NSArray * contactImageIconArr;

//所在公司
@property (nonatomic,copy) NSString * companyName;

//beginTime
@property (nonatomic,copy) NSString * beginTime;
//endtime
@property (nonatomic,copy) NSString * endTime;
//个人背景
@property (nonatomic,copy) NSString * personalBackground;


//新添加的好友数组
@property (nonatomic,copy) NSArray * addFriendArr;

//用户更新心情
@property (nonatomic,copy) NSString * userMood;

//用户更新图片
@property (nonatomic,copy) UIImage * updatePicture;

//用户名
@property (nonatomic,strong)NSString  *userName;

//密码
@property (nonatomic,strong)NSString  *password;

//真实姓名
@property (nonatomic,strong)NSString *realName;

//性别
@property (nonatomic,strong)NSString *sex;

//所在地
@property (nonatomic,strong)NSString *location;

//生日
@property (nonatomic,strong)NSString *birthday;

//星座
@property (nonatomic,strong)NSString *constellation;//星座

//血型
@property (nonatomic,strong)NSString *bloodType;


//职位
@property (nonatomic,strong)NSString *position;

//***********************************************************************************


//新增好友
+ (NSURLSessionDataTask *)AddfriendsWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic;

//处理好友请求
+ (NSURLSessionDataTask *)ProcessrequestWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic;

//增加关注
+ (NSURLSessionDataTask *)AddfocusWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic;

//增加标签
+ (NSURLSessionDataTask *)AddtagWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic;

//获取所有动态
+ (NSURLSessionDataTask *)AllActivesWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block userId:(NSString *)userId startIndex:(int)startIndex;
@end
