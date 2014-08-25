//
//  ProjectApi.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-25.
//
//

#import "ProjectApi.h"
#import "projectModel.h"
@implementation ProjectApi
//RESPONSE:
//{
//    d =     {
//        data =         (
//                        {
//                            actureStartTime = "<null>";
//                            airCondition = 0;
//                            beginIndex = 0;
//                            createBy = "f483bcfc-3726-445a-97ff-ac7f207dd888";
//                            decorationProcess = "\U65e0\U88c5\U4fee";
//                            decorationSituation = "\U62db\U6807";
//                            electorWeakInstallation = "\U62db\U6807";
//                            elevator = 0;
//                            endIndex = 10;
//                            endRecord = 10;
//                            exceptFigureFinishTime = "2024-08-22T17:59:29.703";
//                            exceptFigureStartTime = "2014-08-22T17:59:29.703";
//                            exceptFinishTime = "2024-08-22T17:59:29.683";
//                            exceptStartTime = "2014-08-22T17:59:29.683";
//                            externalWallMeterial = 0;
//                            fireControl = fir;
//                            foreignInvestment = 0;
//                            green = no;
//                            heating = 0;
//                            id = "b5da014a-0796-4cad-9847-32dccd95f81a";
//                            investment = "10.2";
//                            isSaveBack = 0;
//                            landAddress = "this is details address";
//                            landArea = "1111.2";
//                            landCity = "\U4e0a\U6d77";
//                            landDistrict = "\U4e0a\U6d77";
//                            landName = "This is landName";
//                            landPlotRatio = "10.3";
//                            landProvince = "\U4e0a\U6d77";
//                            landStreet = "";
//                            landUsages = No;
//                            latitude = "2222.22";
//                            longitude = "199.3";
//                            mainDesignStage = No;
//                            ownerType = "<null>";
//                            pageIndex = 1;
//                            pageSize = 10;
//                            projectAddress = No;
//                            projectDiscription = Dis;
//                            projectKeyWords = "<null>";
//                            projectName = testProjectProgress;
//                            recordCount = 0;
//                            stealStructure = 0;
//                            storeyArea = "1222.4";
//                            storeyHeight = "192.3";
//                            updateBy = "<null>";
//                            updateTime = "2014-08-22T17:58:29.06";
//                        }
//                        );
//        status =         {
//            statusCode = 1300;
//        };
//    };
//}
+ (NSURLSessionDataTask *)GetListWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block startIndex:(int)startIndex{
    NSString *urlStr = [NSString stringWithFormat:@"api/PiProjectController/AllProjects?pageSize=5&index=%d",startIndex];
    return [[AFAppDotNetAPIClient sharedClient] GET:urlStr parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        //NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"d"][@"status"][@"statusCode"]]isEqualToString:@"1300"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            for(NSDictionary *item in JSON[@"d"][@"data"]){
                projectModel *model = [[projectModel alloc] init];
                [model setDict:item];
                [mutablePosts addObject:model];
            }
            if (block) {
                block([NSMutableArray arrayWithArray:mutablePosts], nil);
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:JSON[@"d"][@"status"][@"errors"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block([NSMutableArray array], error);
        }
    }];
}

+ (NSURLSessionDataTask *)SingleProjectWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block projectId:(NSString *)projectId{
    NSString *urlStr = [NSString stringWithFormat:@"api/PiProjectController/Projects?projectId=%@",projectId];
    return [[AFAppDotNetAPIClient sharedClient] GET:urlStr parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"d"][@"status"][@"statusCode"]]isEqualToString:@"1300"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            //[mutablePosts addObject:JSON[@"d"][@"data"]];
            if (block) {
                block([NSMutableArray arrayWithArray:mutablePosts], nil);
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:JSON[@"d"][@"status"][@"errors"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block([NSMutableArray array], error);
        }
    }];
}


+ (NSURLSessionDataTask *)AddProjectWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic{
    NSString *urlStr = [NSString stringWithFormat:@"api/PiProjectController/AddProject"];
    return [[AFAppDotNetAPIClient sharedClient] POST:urlStr parameters:dic success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"d"][@"status"][@"statusCode"]]isEqualToString:@"1300"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            //[mutablePosts addObject:JSON[@"d"][@"data"]];
            if (block) {
                block([NSMutableArray arrayWithArray:mutablePosts], nil);
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:JSON[@"d"][@"status"][@"errors"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block([NSMutableArray array], error);
        }
    }];
}

+ (NSURLSessionDataTask *)UpdateProjectWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic{
    NSString *urlStr = [NSString stringWithFormat:@"api/PiProjectController/UpdateProject"];
    return [[AFAppDotNetAPIClient sharedClient] POST:urlStr parameters:dic success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"d"][@"status"][@"statusCode"]]isEqualToString:@"1300"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            //[mutablePosts addObject:JSON[@"d"][@"data"]];
            if (block) {
                block([NSMutableArray arrayWithArray:mutablePosts], nil);
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:JSON[@"d"][@"status"][@"errors"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block([NSMutableArray array], error);
        }
    }];
}

//NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//[dic setObject:@"" forKey:@"keywords"];
//[dic setObject:@"" forKey:@"landDistrict"];
//[dic setObject:@"" forKey:@"landProvince"];
//[dic setObject:@"" forKey:@"landCity"];
+ (NSURLSessionDataTask *)AdvanceSearchProjectsWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic startIndex:(int)startIndex{
    NSString *urlStr = [NSString stringWithFormat:@"api/PiProjectController/AdvanceSearchProjects?pageSize=5&index=%d&keywords=%@&landDistrict=%@&landProvince=%@&landCity=%@",startIndex,dic[@"keywords"],dic[@"landDistrict"],dic[@"landProvince"],dic[@"landCity"]];
    return [[AFAppDotNetAPIClient sharedClient] GET:urlStr parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"d"][@"status"][@"statusCode"]]isEqualToString:@"1300"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            //[mutablePosts addObject:JSON[@"d"][@"data"]];
            if (block) {
                block([NSMutableArray arrayWithArray:mutablePosts], nil);
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:JSON[@"d"][@"status"][@"errors"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block([NSMutableArray array], error);
        }
    }];
}

+ (NSURLSessionDataTask *)GetPiProjectCommentWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block projectId:(NSString *)projectId{
    NSString *urlStr = [NSString stringWithFormat:@"api/PiProject/GetPiProjectComments?projectId=%@",projectId];
    return [[AFAppDotNetAPIClient sharedClient] GET:urlStr parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"d"][@"status"][@"statusCode"]]isEqualToString:@"1300"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            //[mutablePosts addObject:JSON[@"d"][@"data"]];
            if (block) {
                block([NSMutableArray arrayWithArray:mutablePosts], nil);
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:JSON[@"d"][@"status"][@"errors"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block([NSMutableArray array], error);
        }
    }];
}

//POST:
//{
//      "projectId": ":projectId" 必填
//      "commnetContents":"评论内容"
//      "createdBy":"创建人"
//      "deletedBy":"删除人"
//      "deletedTime": "删除时间"
//}
//
//RESPONSE:
//{
//    "d": {
//        "status": {
//            "statusCode": 1300
//        }
//    }
//}
+ (NSURLSessionDataTask *)PostAddPiProjectCommentsWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic{
    NSString *urlStr = [NSString stringWithFormat:@"api/PiProject/PostAddPiProjectComments"];
    return [[AFAppDotNetAPIClient sharedClient] POST:urlStr parameters:dic success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"d"][@"status"][@"statusCode"]]isEqualToString:@"1300"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            //[mutablePosts addObject:JSON[@"d"][@"data"]];
            if (block) {
                block([NSMutableArray arrayWithArray:mutablePosts], nil);
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:JSON[@"d"][@"status"][@"errors"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block([NSMutableArray array], error);
        }
    }];
}

+ (NSURLSessionDataTask *)GetPiProjectLogsWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block projectId:(NSString *)projectId{
    NSString *urlStr = [NSString stringWithFormat:@"api/PiProject/GetPiProjectLogs?projectId=%@",projectId];
    return [[AFAppDotNetAPIClient sharedClient] GET:urlStr parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"d"][@"status"][@"statusCode"]]isEqualToString:@"1300"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            //[mutablePosts addObject:JSON[@"d"][@"data"]];
            if (block) {
                block([NSMutableArray arrayWithArray:mutablePosts], nil);
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:JSON[@"d"][@"status"][@"errors"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block([NSMutableArray array], error);
        }
    }];
}

//POST:
//{
//    "SearchName":"ownertype",
//    "CreateBy":"wmj",
//    "SearchConditions":"是够大方司法局"
//}
+ (NSURLSessionDataTask *)SearchConditionWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic{
    NSString *urlStr = [NSString stringWithFormat:@"api/PiProjectController/SearchConditionr"];
    return [[AFAppDotNetAPIClient sharedClient] POST:urlStr parameters:dic success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"d"][@"status"][@"statusCode"]]isEqualToString:@"1300"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            //[mutablePosts addObject:JSON[@"d"][@"data"]];
            if (block) {
                block([NSMutableArray arrayWithArray:mutablePosts], nil);
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:JSON[@"d"][@"status"][@"errors"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block([NSMutableArray array], error);
        }
    }];
}

//POST:
//{
//    "id":"搜索条件Id",
//}
+ (NSURLSessionDataTask *)SearchCountAddWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic{
    NSString *urlStr = [NSString stringWithFormat:@"api/PiProjectController/SearchCountAdd"];
    return [[AFAppDotNetAPIClient sharedClient] POST:urlStr parameters:dic success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"d"][@"status"][@"statusCode"]]isEqualToString:@"1300"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            //[mutablePosts addObject:JSON[@"d"][@"data"]];
            if (block) {
                block([NSMutableArray arrayWithArray:mutablePosts], nil);
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:JSON[@"d"][@"status"][@"errors"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block([NSMutableArray array], error);
        }
    }];
}

//NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//[dic setObject:@"" forKey:@"distict"]; 所在区域
//[dic setObject:@"" forKey:@"createBy"]; 创建人
+ (NSURLSessionDataTask *)GetSearchConditionsWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic{
    NSString *urlStr = [NSString stringWithFormat:@"api/PiProjectController/GetSearchConditions?distict=%@&createBy=%@",dic[@"distict"],dic[@"createBy"]];
    return [[AFAppDotNetAPIClient sharedClient] GET:urlStr parameters:dic success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"d"][@"status"][@"statusCode"]]isEqualToString:@"1300"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            //[mutablePosts addObject:JSON[@"d"][@"data"]];
            if (block) {
                block([NSMutableArray arrayWithArray:mutablePosts], nil);
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:JSON[@"d"][@"status"][@"errors"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
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
