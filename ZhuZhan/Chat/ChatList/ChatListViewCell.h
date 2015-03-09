//
//  ChatListViewCell.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/9.
//
//

#import <UIKit/UIKit.h>

#import "EGOImageView.h"
#import "EmployeesModel.h"

@interface ChatListViewCell : UITableViewCell
@property(nonatomic,strong)EGOImageView* userImageView;
@property(nonatomic,strong)UILabel* rightLabel;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier needRightBtn:(BOOL)needRightBtn;
-(void)setModel:(EmployeesModel *)model;
@end
