//
//  RequirementDetailModel.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/9.
//
//

#import <Foundation/Foundation.h>

@interface RequirementDetailModel : NSObject
@property (nonatomic, copy)NSString* a_loginId;
@property (nonatomic, copy)NSString* a_loginImagesId;
@property (nonatomic, copy)NSString* a_loginName;
@property (nonatomic, copy)NSString* a_createdTime;
@property (nonatomic)BOOL a_isPsersonal;

@property (nonatomic, copy)NSString* a_requireType;
@property (nonatomic, copy)NSString* a_requireTypeName;

@property (nonatomic, copy)NSString* a_realName;
@property (nonatomic, copy)NSString* a_telphone;

@property (nonatomic, copy)NSString* a_moneyMax;
@property (nonatomic, copy)NSString* a_moneyMin;

@property (nonatomic, strong)NSString* a_bigTypeCn;
@property (nonatomic, strong)NSString* a_smallTypeCn;

@property (nonatomic, copy)NSString* a_reqDesc;

@property (nonatomic, strong)NSDictionary* dict;
/*
 bigType =         {
 };
 bigTypeCn = "";
 city = "\U91cd\U5e86\U5e02";
 commentsNum = 0;
 createdTime = "2015-06-09 14:04:24";
 isFriend = 0;
 isOpen = 00;
 loginId = "4870fa2a-ccfa-49b1-b09d-50b9a15d335e";
 loginImagesId = "cc70088f-6ea6-408f-b235-5888fffb1ecb";
 loginName = fj0003;
 moneyMax = "";
 moneyMin = "";
 province = "\U91cd\U5e86\U5e02";
 realName = "\U8303\U4fca";
 replyContent = "";
 replyId = "";
 replyTime = "";
 replyUserName = "";
 reqDesc = asdfasf;
 reqId = "7bc5ff40-6809-461c-ab08-a7ad883fa7a2";
 reqNo = "201506090010-03";
 reqType = 03;
 reqTypeCn = "\U627e\U5173\U7cfb";
 smallType =         (
 );
 smallTypeCn = "";
 telphone = "181****6134";
 userType = 01;
 */
@end
