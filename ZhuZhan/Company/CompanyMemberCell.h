//
//  CompanyMemberCell.h
//  ZhuZhan
//
//  Created by 孙元侃 on 14/10/22.
//
//

#import <UIKit/UIKit.h>
#import "EmployeesModel.h"
@interface CompanyMemberCell : UITableViewCell
@property(nonatomic,strong)UIImageView* userImageView;
@property(nonatomic,strong)UIButton* rightBtn;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier needRightBtn:(BOOL)needRightBtn;
-(void)setModel:(EmployeesModel *)model indexPathRow:(NSInteger)indexPathRow needCompanyName:(BOOL)needCompanyName;
@end
