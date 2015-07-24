//
//  LoginViewControllerTests.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/7/23.
//
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "FakeLoginViewController.h"

@interface LoginViewControllerTests : XCTestCase
@property (nonatomic, strong)FakeLoginViewController* loginVC;

@end

@implementation LoginViewControllerTests

- (void)setUp {
    [super setUp];
    self.loginVC = [[FakeLoginViewController alloc] init];
    [self.loginVC viewDidLoad];
}

- (void)tearDown {
    [super tearDown];
}

/**
 *  测试登陆框账号处必须有内容的限制
 */
- (void)testUserNameShouldHasContent{
    UITextField* userNameTextField = [self.loginVC valueForKey:@"_userNameTextField"];
    userNameTextField.text = @"";
    BOOL success = [self.loginVC gotoLogin];

    XCTAssertTrue(!success);
}

/**
 *  测试正确情况下可以正常发出登陆请求
 */
- (void)testCanPostLoginApi{
    UITextField* userNameTextField = [self.loginVC valueForKey:@"_userNameTextField"];
    UITextField* passWordTextField = [self.loginVC valueForKey:@"_passWordTextField"];
    userNameTextField.text = @"123";
    passWordTextField.text = @"123";

    BOOL success = [self.loginVC gotoLogin];
    XCTAssertTrue(success);
}
@end
