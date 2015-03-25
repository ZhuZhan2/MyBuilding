//
//  CategoryModel.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/25.
//
//

#import "CategoryModel.h"

@implementation CategoryModel
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.a_id = dict[@"catalogId"];
    self.a_name = dict[@"name"];
}
@end
