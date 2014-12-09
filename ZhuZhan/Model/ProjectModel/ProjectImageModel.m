//
//  ProjectImageModel.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-26.
//
//

#import "ProjectImageModel.h"
#import "ProjectStage.h"
@implementation ProjectImageModel
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.a_id = [ProjectStage ProjectStrStage:dict[@"id"]];
    self.a_projectId = [ProjectStage ProjectStrStage:dict[@"projectId"]];
    if(![[ProjectStage ProjectStrStage:dict[@"imageCompressLocation"]] isEqualToString:@""]){
        self.a_imageCompressLocation = [NSString stringWithFormat:@"%s%@",serverAddress,[ProjectStage ProjectStrStage:dict[@"imageCompressLocation"]]];
    }else{
        self.a_imageCompressLocation = [ProjectStage ProjectStrStage:dict[@"imageCompressLocation"]];
    }
    if(![[ProjectStage ProjectStrStage:dict[@"imageOriginalLocation"]] isEqualToString:@""]){
        self.a_imageOriginalLocation = [NSString stringWithFormat:@"%s%@",serverAddress,[ProjectStage ProjectStrStage:dict[@"imageOriginalLocation"]]];
    }else{
        self.a_imageOriginalLocation = [ProjectStage ProjectStrStage:dict[@"imageOriginalLocation"]];
    }
    self.a_imageCategory = [ProjectStage ProjectStrStage:dict[@"imageCategory"]];
    self.a_imageHeight=[ProjectStage ProjectStrStage:dict[@"imageHeight"]];;
    self.a_imageWidth=[ProjectStage ProjectStrStage:dict[@"imageWidth"]];
}
@end
