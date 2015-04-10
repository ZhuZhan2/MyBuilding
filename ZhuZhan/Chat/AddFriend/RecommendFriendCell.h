//
//  RecommendFriendCell.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/4/9.
//
//

#import <UIKit/UIKit.h>
#import "FriendModel.h"
@interface RecommendFriendCell : UITableViewCell
@property(nonatomic,strong)UIImageView *headImage;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UIButton *addBtn;
@property(nonatomic,strong)UIView *cutLine;
@property(nonatomic,strong)FriendModel *model;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
