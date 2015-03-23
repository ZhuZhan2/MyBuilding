//
//  AddFriendCell.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/9.
//
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
#import "EmployeesModel.h"

@interface AddFriendCell : UITableViewCell
@property(nonatomic,strong)EGOImageView* userImageView;
@property(nonatomic,strong)UIButton* rightBtn;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier needRightBtn:(BOOL)needRightBtn;
-(void)setModel:(EmployeesModel *)model indexPathRow:(NSInteger)indexPathRow needCompanyName:(BOOL)needCompanyName;

-(void)setUserName:(NSString*)userName time:(NSString*)time userImageUrl:(NSString*)userImageUrl isFinished:(BOOL)isFinished indexPathRow:(NSInteger)indexPathRow;
@end
