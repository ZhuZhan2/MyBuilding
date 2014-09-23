//
//  ActivesModel.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-17.
//
//

#import <Foundation/Foundation.h>

@interface ActivesModel : NSObject
@property (nonatomic, copy) NSString *a_id;
@property (nonatomic, copy) NSString *a_entityId;
@property (nonatomic, copy) NSString *a_entityUrl;
@property (nonatomic, copy) NSString *a_projectName;
@property (nonatomic, copy) NSString *a_projectStage;
@property (nonatomic, copy) NSString *a_content;
@property (nonatomic, copy) NSString *a_title;
@property (nonatomic, copy) NSString *a_userName;
@property (nonatomic, copy) NSString *a_avatarUrl;
@property (nonatomic, copy) NSString *a_imageUrl;
@property (nonatomic, copy) NSString *a_imageWidth;
@property (nonatomic, copy) NSString *a_imageHeight;
@property (nonatomic, copy) NSDate *a_time;
@property (nonatomic, copy) NSString *a_category;
@property (nonatomic, copy) NSString *a_eventType;
@property (nonatomic, strong) NSMutableArray *a_commentsArr;
@property (nonatomic, copy) NSDictionary *dict;
@end
