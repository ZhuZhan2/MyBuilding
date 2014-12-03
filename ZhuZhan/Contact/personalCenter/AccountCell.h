//
//  AccountCell.h
//  ZhuZhan
//
//  Created by Jack on 14-9-4.
//
//

#import <UIKit/UIKit.h>
#import "ContactModel.h"
#import "SinglePickerView.h"
#import "LocateView.h"
@protocol  AccountCellDelegate <NSObject>

-(void)ModifyPassword:(NSString *)password;
- (void)getTextFieldFrame_yPlusHeight:(float)y;
-(void)AddDataToModel:(int)flag WithTextField:(UITextField *)textField;
-(void)AddBirthdayPicker:(UILabel *)label;
-(void)addLocation:(NSDictionary *)dic;
@end

@interface AccountCell : UITableViewCell<UITextFieldDelegate,UIActionSheetDelegate>{
    UITextField *userName;
    UITextField *password;
    UITextField *realName;
    UITextField *sex;
    UITextField *location;
    UILabel *birthday;
    UILabel *constellation;//星座
    UITextField *bloodType;
    UITextField *email;
    UILabel *cellPhone;
    UITextField *company;
    UITextField *position;
    SinglePickerView* singlepickerview;
    LocateView *locationview;
    
    UIButton *bgBtn;
}
@property (nonatomic,weak)id<AccountCellDelegate> delegate;
@property (nonatomic,strong)ContactModel *model;
@end
