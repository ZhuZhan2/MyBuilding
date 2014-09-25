//
//  CommentModel.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-4.
//
//

#import "CommentModel.h"
#import "ProjectStage.h"
#import "ContactCommentModel.h"
@implementation CommentModel
- (void)setDict:(NSDictionary *)dict{
//    _dict = dict;
//    
//    self.a_id = [ProjectStage ProjectStrStage:dict[@"actives"][@"entityId"]];;
//    self.a_name = [ProjectStage ProjectStrStage:dict[@"actives"][@"updatedBy"]];
//    self.a_time = [ProjectStage ProjectDateStage:dict[@"actives"][@"updateTime"]];
//    self.a_content = [ProjectStage ProjectStrStage:dict[@"actives"][@"activeContents"]];
//    self.a_imageUrl = [ProjectStage ProjectStrStage:dict[@"actives"][@"activeImage"]];
//    self.a_type = [ProjectStage ProjectStrStage:dict[@"actives"][@"category"]];
//    self.a_imageWidth = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"actives"][@"imageWidth"]]];
//    self.a_imageHeight = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"actives"][@"imageHeight"]]];
//    
//    self.a_commentsArr = [[NSMutableArray alloc] init];
//    if([dict[@"comments"] count] !=0){
//        for(NSDictionary *item in dict[@"comments"]){
//            ContactCommentModel *model = [[ContactCommentModel alloc] init];
//            [model setDict:item];
//            [self.a_commentsArr addObject:model];
//        }
//    }
    
    self.a_id = @"111";
    self.a_name = @"zzz";
    self.a_time = [ProjectStage ProjectDateStage:@""];
    self.a_content = @"asdfsadlasl;dkasl;dkasdasdkasl;dkla;sdk;lasdk;laskdl;askd;lsakdl;askdl;askd;laskd;laskd;laskd;laskd;laks;dlaks;dlaksd;lakd;laksdl;askdla;sdkas;ldkas;ldkasl;dklasllssslsslsslslslslslslslasdfasdf";
    self.a_imageUrl = @"/Pictures/UserImages/059d7897-f2ca-4847-b0b1-469e2f68d9c0.png";
    self.a_type = @"Product";
    self.a_imageWidth = @"300";
    self.a_imageHeight = @"300";
    self.a_userImageUrl=@"http://www.faceplusplus.com.cn/wp-content/themes/faceplusplus/assets/img/demo/4.jpg";

}
@end
