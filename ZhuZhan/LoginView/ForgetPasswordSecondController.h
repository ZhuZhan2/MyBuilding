//
//  ForgetPasswordSecondController.h
//  ZhuZhan
//
//  Created by 孙元侃 on 14/12/15.
//
//

#import <UIKit/UIKit.h>

@interface ForgetPasswordSecondController : UIViewController{
    UITextField *_phoneNumberTextField;
    UITextField *_yzmTextField;
    UITextField *accountField;
}
@property(nonatomic,strong)NSString *userId;
@property(nonatomic,strong)NSString *cellPhone;
@end
