//
//  ProjectCommentModel.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-4.
//
//

#import <Foundation/Foundation.h>

@interface ProjectCommentModel : NSObject
@property (nonatomic,copy) NSString *a_id;
@property (nonatomic,copy) NSString *a_name;
@property (nonatomic,copy) NSString *a_imageUrl;
@property (nonatomic,copy) NSString *a_content;
@property (nonatomic,copy) NSString *a_type;
@property (nonatomic,copy) NSDate *a_time;

@property (nonatomic,copy) NSDictionary *dict;
-(instancetype)initWithEntityID:(NSString*)entityID userName:(NSString*)userName commentContents:(NSString*)commentContents userImage:(NSString*)userImage time:(NSDate*)time;
@end
