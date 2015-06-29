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
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    _dict = dict;
    self.a_id = [ProjectStage ProjectStrStage:dict[@"projectImagesId"]];
    self.a_projectId = [ProjectStage ProjectStrStage:dict[@"projectId"]];
    if(![[ProjectStage ProjectStrStage:dict[@"projectImagesId"]] isEqualToString:@""]){
        self.a_imageCompressLocation = [NSString stringWithFormat:@"%@%@",[userDefaults objectForKey:@"serverAddress"],image([ProjectStage ProjectStrStage:dict[@"projectImagesId"]], @"project", @"", @"", @"")];
    }else{
        self.a_imageCompressLocation = [ProjectStage ProjectStrStage:dict[@"projectImagesId"]];
    }

    if(![[ProjectStage ProjectStrStage:dict[@"projectImagesId"]] isEqualToString:@""]){
        self.a_imageOriginalLocation = [NSString stringWithFormat:@"%@%@",[userDefaults objectForKey:@"serverAddress"],image([ProjectStage ProjectStrStage:dict[@"projectImagesId"]], @"project", @"", @"", @"")];
    }else{
        self.a_imageOriginalLocation = [ProjectStage ProjectStrStage:dict[@"projectImagesId"]];
    }

    self.a_imageCategory = [ProjectStage ProjectStrStage:dict[@"imageCategory"]];
    self.a_imageHeight=[ProjectStage ProjectStrStage:dict[@"imageHeight"]];;
    self.a_imageWidth=[ProjectStage ProjectStrStage:dict[@"imageWidth"]];
}
@end
