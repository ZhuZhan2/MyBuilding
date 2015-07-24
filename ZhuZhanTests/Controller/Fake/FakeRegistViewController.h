//
//  FakeRegistViewController.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/7/24.
//
//

#import "RegistViewController.h"

@interface FakeRegistViewController : RegistViewController
-(BOOL)getVerifitionCode:(UIButton*)btn;
- (BOOL)commomRegister;
@end
