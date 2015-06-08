//
//  PersonalCenterModel.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-28.
//
//

#import <Foundation/Foundation.h>

@interface PersonalCenterModel : NSObject
@property (nonatomic, copy) NSString *a_id;
@property (nonatomic, copy) NSString *a_entityId;
@property (nonatomic, copy) NSString *a_entityUrl;
@property (nonatomic, copy) NSString *a_entityName;
@property (nonatomic, copy) NSString *a_projectStage;
@property (nonatomic, copy) NSString *a_content;
@property (nonatomic, copy) NSString *a_imageUrl;
@property (nonatomic, copy) NSString *a_imageOriginalUrl;
@property (nonatomic, copy) NSString *a_imageWidth;
@property (nonatomic, copy) NSString *a_imageHeight;
@property (nonatomic, copy) NSString *a_time;
@property (nonatomic, copy) NSString *a_category;
@property (nonatomic, copy) NSString *a_avatarUrl;
@property (nonatomic, copy) NSString *a_userName;
@property (nonatomic, copy) NSString *a_userType;
@property (nonatomic, copy) NSString *a_address;
@property (nonatomic, copy) NSDictionary *dict;
@end
