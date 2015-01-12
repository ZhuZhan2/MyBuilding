//
//  CompanyMemberCell.h
//  ZhuZhan
//
//  Created by 孙元侃 on 14/10/22.
//
//

#import <UIKit/UIKit.h>
#import "EmployeesModel.h"
#import "EGOImageView.h"
@interface CompanyMemberCell : UITableViewCell
@property(nonatomic,strong)EGOImageView* userImageView;
@property(nonatomic,strong)UIButton* rightBtn;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier needRightBtn:(BOOL)needRightBtn;
-(void)setModel:(EmployeesModel*)model indexPathRow:(NSInteger)indexPathRow;
@end
