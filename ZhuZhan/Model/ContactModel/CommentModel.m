//
//  CommentModel.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-3.
//
//

#import "CommentModel.h"

@implementation CommentModel
- (void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.name = dict[@"name"];
    self.time = dict[@"time"];
    self.content = dict[@"content"];
    self.imageUrl = dict[@"imageUrl"];
    self.type = dict[@"type"];
}
@end
