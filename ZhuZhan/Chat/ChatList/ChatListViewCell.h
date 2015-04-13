//
//  ChatListViewCell.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/9.
//
//

#import <UIKit/UIKit.h>
#import "ChatListModel.h"

@interface ChatListViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView* userImageView;
@property(nonatomic,strong)UILabel* rightLabel;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier needRightBtn:(BOOL)needRightBtn;
-(void)setModel:(ChatListModel *)model;
@end
