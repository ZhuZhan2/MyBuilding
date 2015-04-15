//
//  FriendModel.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/4/9.
//
//

#import "FriendModel.h"
#import "ProjectStage.h"
@implementation FriendModel
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.a_id = dict[@"loginId"];
    self.a_name = dict[@"loginName"];
    if(![[ProjectStage ProjectStrStage:dict[@"headImageId"]] isEqualToString:@""]){
        self.a_avatarUrl = [NSString stringWithFormat:@"%s%@",serverAddress,image([ProjectStage ProjectStrStage:dict[@"headImageId"]], @"login", @"", @"", @"")];
    }else{
        self.a_avatarUrl = [ProjectStage ProjectStrStage:dict[@"headImageId"]];;
    }
    if([dict[@"isFriend"] isEqualToString:@"0"]){
        self.a_isisFriend = NO;
    }else{
        self.a_isisFriend = YES;
    }
    if([dict[@"waiting"] isEqualToString:@"0"]){
        self.a_isWaiting = NO;
    }else{
        self.a_isWaiting = YES;
    }
}
@end
