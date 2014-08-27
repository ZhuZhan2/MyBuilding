//
//  RecordModel.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-7-22.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "RecordModel.h"

@implementation RecordModel
//本地数据库
-(void)loadWithDB:(NSDictionary*)dic
{
    self.a_name = [dic valueForKey:@"name"];
    self.a_time = [dic valueForKey:@"time"];
}

//服务器数据
-(void)loadWithDictionary:(NSDictionary*)dic
{
    self.a_name = [dic valueForKey:@"name"];
    self.a_time = [dic valueForKey:@"time"];
}
@end
