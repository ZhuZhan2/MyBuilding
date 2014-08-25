//
//  projectModel.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-25.
//
//

#import "projectModel.h"

@implementation projectModel
- (void)setDict:(NSDictionary *)dict{
    /*_dict = dict;
    self.a_id = dict[@"id"];
    self.a_landName = dict[@"landName"];
    self.a_district = dict[@"landDistrict"];
    self.a_ = [NSString stringWithFormat:@"%@",dict[@"likes"]];
    self.youlikeit = [NSString stringWithFormat:@"%@",dict[@"youlikeit"]];
    self.created = dict[@"created"];
    self.createdby = dict[@"createdby"];
    self.comments = dict[@"comments"];*/
}


+ (NSURLSessionDataTask *)GetListWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block{
    NSString *urlStr = [NSString stringWithFormat:@"api/PiProjectController/AllProjects?pageSize=10&index=1"];
    return [[AFAppDotNetAPIClient sharedClient] GET:urlStr parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"status"][@"statusCode"]]isEqualToString:@"1300"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            //[mutablePosts addObject:JSON[@"result"]];
            if (block) {
                block([NSMutableArray arrayWithArray:mutablePosts], nil);
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:JSON[@"status"][@"text"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block([NSMutableArray array], error);
        }
    }];
}
@end
