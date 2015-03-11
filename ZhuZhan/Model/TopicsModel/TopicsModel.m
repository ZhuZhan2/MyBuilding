//
//  TopicsModel.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-27.
//
//

#import "TopicsModel.h"
#import "ProjectStage.h"
@implementation TopicsModel
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.a_id = [ProjectStage ProjectStrStage:dict[@"topicId"]];
    self.a_title = [ProjectStage ProjectStrStage:dict[@"topicName"]];
    self.a_content = [ProjectStage ProjectStrStage:dict[@"topicDesc"]];
    if(![[ProjectStage ProjectStrStage:dict[@"topicImagesId"]] isEqualToString:@""]){
        self.a_image = [NSString stringWithFormat:@"%s%@",serverAddress,image([ProjectStage ProjectStrStage:dict[@"topicImagesId"]], @"project", @"", @"", @"")];
    }else{
        self.a_image = [ProjectStage ProjectStrStage:dict[@"topicImagesId"]];
    }
    self.a_projectCount = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"projectNum"]]];
    self.a_publishTime = [ProjectStage ProjectTimeStage:dict[@"createdTime"]];
}
@end
