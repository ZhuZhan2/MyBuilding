//
//  FakeLoginViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/7/23.
//
//

#import "FakeLoginViewController.h"

@interface FakeLoginViewController ()

@end

@implementation FakeLoginViewController
- (UITextField *)fakePassWordTextField{
    return _passWordTextField;
}

- (UITextField *)fakeUserNameTextField{
    return _userNameTextField;
}

- (void)setFakeUserNameTextField:(UITextField *)fakeUserNameTextField{
    _userNameTextField = fakeUserNameTextField;
}

- (void)setFakePassWordTextField:(UITextField *)fakePassWordTextField{
    _passWordTextField = fakePassWordTextField;
}
@end
