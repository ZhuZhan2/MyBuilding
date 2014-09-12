//
//  AccountCell.h
//  ZhuZhan
//
//  Created by Jack on 14-9-4.
//
//

#import <UIKit/UIKit.h>
#import "ContactModel.h"

@protocol  AccountCellDelegate <NSObject>

-(void)ModifyPassword:(NSString *)password;
- (void)getTextFieldFrame_yPlusHeight:(float)y;

@end
@interface AccountCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic,strong)UITextField *userName;
@property (nonatomic,strong)UITextField *password;
@property (nonatomic,strong)UITextField *realName;
@property (nonatomic,strong)UITextField *sex;
@property (nonatomic,strong)UITextField *location;
@property (nonatomic,strong)UITextField *birthday;
@property (nonatomic,strong)UITextField *constellation;//星座
@property (nonatomic,strong)UITextField *bloodType;
@property (nonatomic,strong)UITextField *email;
@property (nonatomic,strong)UILabel *cellPhone;
@property (nonatomic,strong)UITextField *company;
@property (nonatomic,strong)UITextField *position;
@property (nonatomic,strong)id<AccountCellDelegate> delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithModel:(ContactModel *)model;
@end
