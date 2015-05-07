//
//  RecommendFriendCell.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/4/9.
//
//

#import <UIKit/UIKit.h>
#import "FriendModel.h"
@protocol RecommendFriendCellDelegate <NSObject>
-(void)headClick:(int)index;
-(void)addFriend;
-(void)reload;
@end

@interface RecommendFriendCell : UITableViewCell
@property(nonatomic,strong)UIButton *headBtn;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UIButton *addBtn;
@property(nonatomic,strong)UIView *cutLine;
@property(nonatomic,strong)FriendModel *model;
@property(nonatomic)int indexPathRow;
@property(nonatomic,weak)id<RecommendFriendCellDelegate>delegate;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
