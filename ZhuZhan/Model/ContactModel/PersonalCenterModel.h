//
//  PersonalCenterModel.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-28.
//
//

#import <Foundation/Foundation.h>

@interface PersonalCenterModel : NSObject
//消息的id
@property (nonatomic, copy) NSString *a_id;
//消息对象的id 如是项目就是项目id 是产品就是产品id 是动态就是动态id
@property (nonatomic, copy) NSString *a_messageSourceId;
//消息的时间
@property (nonatomic, copy) NSString *a_createdTime;
//消息所属人的信息
@property (nonatomic, copy) NSString *a_loginId;
@property (nonatomic, copy) NSString *a_loginName;
@property (nonatomic, copy) NSString *a_avatarUrl;
@property (nonatomic, copy) NSString *a_userType;

//messageType : 01动态 02项目 03产品 04公司认证 10需求 11积分
@property (nonatomic, copy) NSString *a_messageType;
//operationType : 01被评论 02认证通过 03认证不通过 04有回复 05申请付款通过 06申请付款不通过 07被关闭
@property (nonatomic, copy) NSString *a_operationType;

/**********************************
 0 动态被评论
 1 项目被评论
 2 项目认证通过
 3 项目认证不通过
 4 项目活动申请付款通过
 5 项目活动申请付款不通过
 6 产品被评论
 7 被公司认证通过
 8 需求被评论
 9 需求有回复
 10 积分被关闭
 **********************************/
@property (nonatomic)NSInteger a_type;

//消息图片的信息
@property (nonatomic, copy) NSString *a_imageUrl;//小图
@property (nonatomic, copy) NSString *a_imageOriginalUrl;//原图
@property (nonatomic, copy) NSString *a_imageWidth;
@property (nonatomic, copy) NSString *a_imageHeight;

//动态和产品和积分的文字信息
@property (nonatomic, copy) NSString *a_msgContent;

//项目的信息
@property (nonatomic, copy) NSString *a_projectName;
@property (nonatomic, copy) NSString *a_projectAddress;

//产品的信息
@property (nonatomic, copy) NSString *a_productName;

//公司认证的信息
@property (nonatomic, copy) NSString *a_companyName;

//发布的需求的信息
@property (nonatomic, copy) NSString *a_reqTypeStr;
@property (nonatomic, copy) NSString *a_reqDesc;
@property (nonatomic) BOOL a_isPubilc;
@property (nonatomic, copy) NSString *a_reqId;

@property (nonatomic, copy) NSDictionary *dict;
@end