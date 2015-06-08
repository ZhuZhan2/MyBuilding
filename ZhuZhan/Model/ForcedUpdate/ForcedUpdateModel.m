//
//  ForcedUpdateModel.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/8.
//
//

#import "ForcedUpdateModel.h"

@implementation ForcedUpdateModel
- (void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.a_createdTime = dict[@"createdTime"];
    self.a_deviceId = dict[@"deviceId"];
    self.a_deviceType = dict[@"deviceType"];
    self.a_downloadType = dict[@"downloadType"];
    self.a_downloadUrl = dict[@"downloadUrl"];
    self.a_forceUpdate = dict[@"forceUpdate"];
    self.a_releaseId = dict[@"releaseId"];
    self.a_releaseLog = dict[@"releaseLog"];
    self.a_releaseSize = dict[@"releaseSize"];
    self.a_releaseVersion = dict[@"releaseVersion"];
    self.a_updatedTime = dict[@"updatedTime"];
    self.a_updatedUser = dict[@"updatedUser"];
}
@end
