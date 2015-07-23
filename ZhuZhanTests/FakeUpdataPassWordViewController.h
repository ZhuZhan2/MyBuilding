//
//  FakeUpdataPassWordViewController.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/7/15.
//
//

#import "UpdataPassWordViewController.h"

@interface FakeUpdataPassWordViewController : UpdataPassWordViewController<UITextFieldDelegate,UIAlertViewDelegate>
/**
 UITextField *oldPassWordTextField;
 UITextField *newPassWordTextField;
 UITextField *newAgainPassWordTextField;
 UIButton *confirmBtn;
 */

- (void)viewDidLoad;
-(void)leftBtnClick;
-(void)viewWillDisappear:(BOOL)animated;
-(void)viewWillAppear:(BOOL)animated;
- (BOOL)textFieldShouldReturn:(UITextField *)textField ;
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
-(void)updataPassWordAction;
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
-(BOOL)LetterNoErr:(NSString *)phone;
-(BOOL)NumberNoErr:(NSString *)phone;
-(BOOL)SymbolNoErr:(NSString *)phone;
@end
