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
    _dict = dict;
    
    self.a_id = [ProjectStage ProjectStrStage:dict[@"actives"][@"entityId"]];;
    self.a_name = [ProjectStage ProjectStrStage:dict[@"actives"][@"updatedBy"]];
    self.a_time = [ProjectStage ProjectDateStage:dict[@"actives"][@"updatedTime"]];
    self.a_content = [ProjectStage ProjectStrStage:dict[@"actives"][@"activeContents"]];
    self.a_imageUrl = [ProjectStage ProjectStrStage:dict[@"actives"][@"activeImage"]];
    self.a_type = [ProjectStage ProjectStrStage:dict[@"actives"][@"category"]];
    self.a_imageWidth = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"actives"][@"imageWidth"]]];
    self.a_imageHeight = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"actives"][@"imageHeight"]]];
    
    self.a_commentsArr = [[NSMutableArray alloc] init];
    if([dict[@"comments"] count] !=0){
        for(NSDictionary *item in dict[@"comments"]){
            ContactCommentModel *model = [[ContactCommentModel alloc] init];
            [model setDict:item];
            [self.a_commentsArr addObject:model];
        }
    }
}
@end
