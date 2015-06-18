//
//  ContactsActiveCellModel.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/1.
//
//

#import "ContactsActiveCellModel.h"
#import "CommentModel.h"
#import "ContactCommentModel.h"
@implementation ContactsActiveCellModel
- (NSMutableArray *)commentArr{
    if (!_commentArr) {
        _commentArr = [NSMutableArray array];
    }
    return _commentArr;
}

- (NSString *)content{
    if (!_content) {
        _content = @"";
    }
    return _content;
}

- (NSString *)secondContent{
    if (!_secondContent) {
        _secondContent = @"";
    }
    return _secondContent;
}

- (NSString *)thirdContent{
    if (!_thirdContent) {
        _thirdContent = @"";
    }
    return _thirdContent;
}

+ (ContactsActiveCellModel*)cellModelWithDataModel:(ActivesModel*)dataModel indexPath:(NSIndexPath*)indexPath{
    BOOL isActive = dataModel.a_type == 0;
    BOOL isProduct = dataModel.a_type == 1 || dataModel.a_type == 7;
    BOOL isProject = dataModel.a_type == 2 || dataModel.a_type == 5 || dataModel.a_type == 6;
    
    NSInteger category;
    if (isActive) {
        category = 0;
    }else if (isProduct){
        category = 1;
    }else if (isProject){
        category = 2;
    }else{
        category = 3;
    }
    
    ContactsActiveCellModel* model = [[ContactsActiveCellModel alloc] init];
    model.userImageUrl = dataModel.a_dynamicAvatarUrl;
    model.needRound = dataModel.a_isPersonal;
    model.title = dataModel.a_dynamicLoginName;
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy/MM/dd HH:mm";
    model.actionTime = [dateFormatter stringFromDate:dataModel.a_time];
    
    if (dataModel.a_type == 0) {
        model.content = dataModel.a_content;
    }
    model.mainImageUrl = dataModel.a_imageUrl;
    
    model.indexPath = indexPath;
    
    if (category == 0) {
        model.commentNumber = MIN(dataModel.a_commentNum, 99);
        [dataModel.a_commentsArr enumerateObjectsUsingBlock:^(ContactCommentModel* commentDataModel, NSUInteger idx, BOOL *stop) {
            CommentModel* commentCellModel = [[CommentModel alloc] init];
            commentCellModel.userImageUrl = commentDataModel.a_avatarUrl;
            commentCellModel.needRound = commentDataModel.a_isPersonal;
            commentCellModel.userName = commentDataModel.a_userName;
            
            NSDateFormatter* tmpDateFormatter = [[NSDateFormatter alloc] init];
            tmpDateFormatter.dateFormat = @"yyyy/MM/dd HH:mm";
            commentCellModel.actionTime = [tmpDateFormatter stringFromDate:commentDataModel.a_time];
            
            commentCellModel.content = commentDataModel.a_commentContents;
            
            [model.commentArr addObject:commentCellModel];
        }];
    }else{
        NSArray* actionNameArr = @[@"",@"发布产品",@"新建项目",[dataModel.a_content isEqualToString:@"修改了头像"]?@"更新了头像":@"更新了资料",@"获得了公司认证",@"更新了项目",@"项目有了新评论",@"产品有了新评论"];
        model.actionName = actionNameArr[dataModel.a_type];
        model.actionNameColor = (dataModel.a_type == 3 || dataModel.a_type == 4)?RGBCOLOR(51, 51, 51):BlueColor;
        if (dataModel.a_type == 7) {
            model.mainImageUrl = dataModel.a_productImage;
        }
        
        if (isProduct) {
            model.secondContent = dataModel.a_productName;
        }else if (isProject){
            model.secondContent = dataModel.a_projectName;
            NSString* address = [NSString stringWithFormat:@"%@ %@",dataModel.a_projectCity,dataModel.a_projectAddress];
            address = [address isEqualToString:@" "]?@"":address;
            model.thirdContent = address;
        }else if (dataModel.a_type == 4){
            model.secondContent = dataModel.a_content;
        }
    }
    return model;
}

@end
