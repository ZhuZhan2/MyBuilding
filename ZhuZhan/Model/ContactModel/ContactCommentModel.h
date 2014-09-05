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
@property (nonatomic, copy) NSString *a_name;
@property (nonatomic, copy) NSString *a_content;
@property (nonatomic, copy) NSString *a_imageUrl;
@property (nonatomic, copy) NSDate *a_time;
@property (nonatomic, copy) NSString *a_type;

@property (nonatomic, copy) NSDictionary *dict;
@end
