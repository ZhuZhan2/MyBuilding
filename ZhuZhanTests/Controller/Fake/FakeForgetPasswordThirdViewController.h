//
//  FakeForgetPasswordThirdViewController.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/7/24.
//
//

#import "ForgetPasswordThirdController.h"

@interface FakeForgetPasswordThirdViewController : ForgetPasswordThirdController
-(BOOL)isRule:(NSString*)phone;
-(BOOL)isAllNumber:(NSString*)numbers;
-(BOOL)LetterNoErr:(NSString *)phone;
-(BOOL)NumberNoErr:(NSString *)phone;
-(BOOL)SymbolNoErr:(NSString *)phone;
@end
