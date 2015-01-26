//
//  RecommendContactTableViewCell.h
//  ZhuZhan
//
//  Created by 汪洋 on 14/12/18.
//
//

#import <UIKit/UIKit.h>
#import "EmployeesModel.h"
#import "EGOImageView.h"
@interface RecommendContactTableViewCell : UITableViewCell
@property(nonatomic,strong)EGOImageView* userImageView;
@property(nonatomic,strong)UIButton* rightBtn;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier needRightBtn:(BOOL)needRightBtn;
-(void)setModel:(EmployeesModel *)model indexPathRow:(NSInteger)indexPathRow needCompanyName:(BOOL)needCompanyName;
@end
