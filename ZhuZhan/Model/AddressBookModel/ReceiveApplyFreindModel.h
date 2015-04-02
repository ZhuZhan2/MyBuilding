//
//  ReceiveApplyFreindModel.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/23.
//
//

#import <Foundation/Foundation.h>

@interface ReceiveApplyFreindModel : NSObject
/*
 createdTime = "2015-03-23 13:21:12";
 createdUser = "4dab083a-3f09-4854-839a-f45995b6047f";
 imageId = "";
 loginName = wy0002;
 messageContent = "\U6211\U662fnull,\U6211\U60f3\U6dfb\U52a0\U4f60\U4e3a\U597d\U53cb";
 messageId = "41a51408-32f8-4d96-ba4e-eba615c8447f";
 messageObjectId = "ef190673-0f57-4a78-aa07-e86d3edf2262";
 messageType = 05;
 status = 04;
 */
@property(nonatomic,copy)NSString* a_createdTime;
@property(nonatomic,copy)NSString* a_createdUser;
@property(nonatomic,copy)NSString* a_imageId;
@property(nonatomic,copy)NSString* a_loginName;
@property(nonatomic,copy)NSString* a_messageContent;
@property(nonatomic,copy)NSString* a_messageId;
@property(nonatomic,copy)NSString* a_messageObjectId;
@property(nonatomic,copy)NSString* a_messageType;
@property(nonatomic,copy)NSString* a_status;
@property(nonatomic)BOOL a_isFinished;

@property(nonatomic,strong)NSDictionary* dic;
@end
