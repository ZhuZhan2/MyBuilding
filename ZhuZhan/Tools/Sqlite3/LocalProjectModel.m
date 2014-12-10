//
//  LocalProjectModel.m
//  ZhuZhan
//
//  Created by 汪洋 on 14/12/9.
//
//

#import "LocalProjectModel.h"

@implementation LocalProjectModel
//本地数据库
-(void)loadWithDB:(NSDictionary*)dic
{
    self.a_projectId = [dic valueForKey:@"projectId"];
    self.a_time = [dic valueForKey:@"time"];
}

//服务器数据
-(void)loadWithDictionary:(NSDictionary*)dic
{
    self.a_projectId = [dic valueForKey:@"projectId"];
    self.a_time = [dic valueForKey:@"time"];
}
@end
