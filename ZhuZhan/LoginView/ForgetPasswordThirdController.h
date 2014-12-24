//
//  ForgetPasswordThirdController.h
//  ZhuZhan
//
//  Created by 孙元侃 on 14/12/15.
//
//

#import <UIKit/UIKit.h>

@interface ForgetPasswordThirdController : UIViewController<UITextFieldDelegate>{
    UITextField *passWordField;
    UITextField *verifyPassWordField;
}
@property(nonatomic,strong)NSString *userId;
@property(nonatomic,strong)NSString *cellPhone;
@property(nonatomic,strong)NSString *barCode;
@end
