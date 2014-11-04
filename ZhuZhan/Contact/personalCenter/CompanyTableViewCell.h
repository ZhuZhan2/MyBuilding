//
//  CompanyTableViewCell.h
//  ZhuZhan
//
//  Created by 汪洋 on 14/11/4.
//
//

#import <UIKit/UIKit.h>
#import "CompanyModel.h"
@protocol CompanyTableViewCellDelegate <NSObject>
-(void)gotoUpdataPassWord;
@end

@interface CompanyTableViewCell : UITableViewCell<UITextFieldDelegate>{
    UITextField *companyNameTextField;
    UITextField *passWordTextField;
    UITextField *addressTextField;
    UITextField *industryTextField;
    UITextField *contactTextField;
    UITextField *phoneTextField;
    UITextField *emailTextField;
}
@property(nonatomic,weak)id<CompanyTableViewCellDelegate>delegate;
@property(nonatomic,strong)CompanyModel *model;
@end
