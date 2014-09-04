//
//  CommentModel.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-3.
//
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject
@property (nonatomic, copy) NSString *a_id;
@property (nonatomic, copy) NSString *a_name;
@property (nonatomic, copy) NSString *a_content;
@property (nonatomic, copy) NSString *a_imageUrl;
@property (nonatomic, copy) NSString *a_time;
@property (nonatomic, copy) NSString *a_type;
@property (nonatomic, copy) NSDictionary *dict;
@end
