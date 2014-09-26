//
//  ContactCommentModel.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-4.
//
//

#import <Foundation/Foundation.h>

@interface ContactCommentModel : NSObject
@property (nonatomic, copy) NSString *a_id;
@property (nonatomic, copy) NSString *a_entityId;
@property (nonatomic, copy) NSString *a_userName;
@property (nonatomic, copy) NSString *a_createdBy;
@property (nonatomic, copy) NSString *a_commentContents;
@property (nonatomic, copy) NSString *a_avatarUrl;
@property (nonatomic, copy) NSDate *a_time;

@property (nonatomic, copy) NSDictionary *dict;

-(instancetype)initWithID:(NSString*)ID entityID:(NSString*)entityID createdBy:(NSString*)createdBy userName:(NSString*)userName commentContents:(NSString*)commentContents avatarUrl:(NSString*)avatarUrl time:(NSDate*)time;
@end
