//
//  ContactsActiveCellModel.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/1.
//
//

#import "BaseTableViewCellModel.h"
#import "CommentModel.h"
#import "ActivesModel.h"
@interface ContactsActiveCellModel : BaseTableViewCellModel
@property (nonatomic, copy)NSString* userImageUrl;
@property (nonatomic, copy)NSString* title;
@property (nonatomic, copy)NSString* actionName;
@property (nonatomic, strong)UIColor* actionNameColor;
@property (nonatomic, copy)NSString* actionTime;
@property (nonatomic, copy)NSString* content;//最大三行
@property (nonatomic, copy)NSString* secondContent;//最大二行
@property (nonatomic, copy)NSString* thirdContent;//最大二行

@property (nonatomic, copy)NSString* mainImageUrl;


@property (nonatomic, strong)NSIndexPath* indexPath;

@property (nonatomic)NSInteger commentNumber;
@property (nonatomic, strong)NSMutableArray* commentArr;

+ (ContactsActiveCellModel*)cellModelWithDataModel:(ActivesModel*)dataModel indexPath:(NSIndexPath*)indexPath;
@end
