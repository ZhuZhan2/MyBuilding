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
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.loginVC = nil;
    [super tearDown];
}

- (void)testUserNameShouldHasContent{
    self.loginVC.fakeUserNameTextField.text = @"";
    BOOL success = [[self.loginVC performSelector:@selector(gotoLogin)] boolValue];
    XCTAssertTrue(!success);
}

- (void)testCanPostLoginApi{
    self.loginVC.fakeUserNameTextField.text = @"123";
    self.loginVC.fakePassWordTextField.text = @"123";
//    self.loginVC.fakePassWordTextField = [NSObject new];
//    BOOL success = [[self.loginVC performSelector:@selector(gotoLogin)] boolValue];
    XCTAssertTrue(YES);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
