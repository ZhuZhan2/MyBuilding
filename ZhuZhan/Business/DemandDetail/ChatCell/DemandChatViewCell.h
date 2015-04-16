//
//  DemandChatViewCell.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/19.
//
//

#import <UIKit/UIKit.h>

@interface DemandChatViewCellModel : NSObject
@property(nonatomic,copy)NSString* userName;
@property(nonatomic,copy)NSString* userDescribe;
@property(nonatomic,copy)NSString* time;
@property(nonatomic,copy)NSString* content;
@property(nonatomic)BOOL isHonesty;
@property(nonatomic)BOOL isSelf;
@end

@interface DemandChatViewCell : UITableViewCell
@property(nonatomic,strong)DemandChatViewCellModel* model;
+(CGFloat)carculateTotalHeightWithModel:(DemandChatViewCellModel*)model;
@end
