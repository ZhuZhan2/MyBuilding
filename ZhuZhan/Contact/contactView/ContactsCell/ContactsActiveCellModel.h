//
//  ContactsActiveCellModel.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/1.
//
//

#import "BaseTableViewCellModel.h"
#import "CommentModel.h"
@interface ContactsActiveCellModel : BaseTableViewCellModel
@property (nonatomic, copy)NSString* userImageUrl;
@property (nonatomic, copy)NSString* title;
@property (nonatomic, copy)NSString* actionTime;
@property (nonatomic, copy)NSString* content;
@property (nonatomic, copy)NSString* mainImageUrl;


@property (nonatomic)NSInteger commentNumber;
@property (nonatomic, strong)NSMutableArray* commentArr;
@end
