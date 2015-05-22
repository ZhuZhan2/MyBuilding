//
//  MyFocusUserTableViewCell.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/5/22.
//
//

#import <UIKit/UIKit.h>
#import "MyCenterModel.h"

@protocol MyFocusUserTableViewCellDelegate <NSObject>
-(void)addFocused:(NSIndexPath *)indexPath;
-(void)userHeadClick:(NSIndexPath *)indexPath;
@end

@interface MyFocusUserTableViewCell : UITableViewCell
@property(nonatomic,strong)NSString *isFocused;
@property(nonatomic,strong)NSString *contractId;
@property(nonatomic,strong)UIButton *userHeadBtn;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *companyLabel;
@property(nonatomic,strong)UIButton *isFocusBtn;
@property(nonatomic,strong)MyCenterModel *model;
@property(nonatomic,strong)UIImageView *cutLine;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,weak)id<MyFocusUserTableViewCellDelegate>delegate;
@end
