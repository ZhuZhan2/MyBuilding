//
//  RegistViewControllerTests.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/7/24.
//
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "FakeRegistViewController.h"
@interface RegistViewControllerTests : XCTestCase
@property (nonatomic, strong)FakeRegistViewController* registVC;
@property (nonatomic, strong)UITextField* accountField;
@property (nonatomic, strong)UITextField* passwordField1;
@property (nonatomic, strong)UITextField* passwordField2;
@property (nonatomic, strong)UITextField* yzmField;
@property (nonatomic, strong)UITextField* phoneField;
@end

@implementation RegistViewControllerTests

- (void)setUp {
    [super setUp];
    self.registVC = [[FakeRegistViewController alloc] init];
    [self.registVC viewDidLoad];
    
    self.accountField.text = @"miao001";
    self.passwordField1.text = @"123456";
    self.passwordField2.text = @"123456";
    self.yzmField.text = @"1234";
    self.phoneField.text = @"18121256138";
}

- (void)tearDown {
    [super tearDown];
}

/**
 *  测试注册功能正常
 */
- (void)testCommomReisterNomal{
    BOOL isSuccess = [self.registVC commomRegister];
    XCTAssertTrue(isSuccess);
}

/**
 *  测试电话号码防错功能
 */
- (void)testCommomRegisterPhoneWrong{
    self.phoneField.text = @"12394";
    BOOL isSuccess = [self.registVC commomRegister];
    XCTAssertTrue(!isSuccess);
}

/**
 *  测试验证码防错功能
 */
- (void)testCommomRegisterYZMWrong{
    self.yzmField.text = @"";
    BOOL isSuccess = [self.registVC commomRegister];
    XCTAssertTrue(!isSuccess);
}

/**
 *  测试账号防错功能
 */
- (void)testCommomRegisterAccountWrong{
    self.accountField.text = @"";
    BOOL isSuccess = [self.registVC commomRegister];
    XCTAssertTrue(!isSuccess);
}

/**
 *  测试账号长度防错功能
 */
- (void)testCommomRegisterAccountRightLengthWrong{
    self.accountField.text = @"a12345678901234567890";
    BOOL isSuccess = [self.registVC commomRegister];
    XCTAssertTrue(!isSuccess);
}

/**
 *  测试账号内不能含有空格的防错功能
 */
- (void)testCommomRegisterAccountNotHasSpace{
    self.accountField.text = @"a12345678 90123456";
    BOOL isSuccess = [self.registVC commomRegister];
    XCTAssertTrue(!isSuccess);
}

/**
 *  测试账号不能全数字防错功能
 */
- (void)testCommomRegisterAccountNotAllNumber{
    self.accountField.text = @"12345678";
    BOOL isSuccess = [self.registVC commomRegister];
    XCTAssertTrue(!isSuccess);
}

/**
 *  测试账号内不能有特殊字符的防错功能
 */
- (void)testCommomRegisterAccountNotHasSpecialSymbol{
    self.accountField.text = @"a123456🐶78";
    BOOL isSuccess = [self.registVC commomRegister];
    XCTAssertTrue(!isSuccess);
}

/**
 *  测试密码长度的防错功能
 */
- (void)testCommomRegisterPasswordLength{
    self.passwordField1.text = @"a123";
    BOOL isSuccess = [self.registVC commomRegister];
    XCTAssertTrue(!isSuccess);
}

/**
 *  测试账号不能全空的防错功能
 */
- (void)testCommomRegisterInputAll{
    self.passwordField1.text = @"";
    BOOL isSuccess = [self.registVC commomRegister];
    XCTAssertTrue(!isSuccess);
}

/**
 *  测试两次密码不同的防错功能
 */
- (void)testPasswordSame{
    self.passwordField1.text = @"1234444";
    BOOL isSuccess = [self.registVC commomRegister];
    XCTAssertTrue(!isSuccess);
}

/**
 *  测试手机号码错误时验证码无法发送的防错功能
 */
- (void)testGetVerifitionCodePhoneError{
    self.phoneField.text = @"1234444";
    BOOL isSuccess = [self.registVC getVerifitionCode:nil];
    XCTAssertTrue(!isSuccess);
}

/**
 *  测试正常的手机号可以发送验证码
 */
- (void)testGetVerifitionCodePhoneNormal{
    BOOL isSuccess = [self.registVC getVerifitionCode:nil];
    XCTAssertTrue(isSuccess);
}

- (UITextField *)accountField{
    return [self.registVC valueForKey:@"accountField"];
}

- (UITextField *)passwordField1{
    return [self.registVC valueForKey:@"passWordField"];
}

- (UITextField *)passwordField2{
    return [self.registVC valueForKey:@"verifyPassWordField"];
}

- (UITextField *)yzmField{
    return [self.registVC valueForKey:@"_yzmTextField"];
}

- (UITextField *)phoneField{
    return [self.registVC valueForKey:@"_phoneNumberTextField"];
}
@end
