//
//  RecommendContactTableViewCell.h
//  ZhuZhan
//
//  Created by 汪洋 on 14/12/18.
//
//

#import <UIKit/UIKit.h>
#import "EmployeesModel.h"
@interface RecommendContactTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView* userImageView;
@property(nonatomic,strong)UIButton* rightBtn;
@property (nonatomic, strong)UIButton* rightBtn2;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier needRightBtn:(BOOL)needRightBtn;
-(void)setModel:(EmployeesModel *)model indexPathRow:(NSInteger)indexPathRow needCompanyName:(BOOL)needCompanyName;
@end
