//
//  ForgetPasswordSecondControllerTests.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/7/24.
//
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "FakeForgetPasswordSecondViewController.h"

@interface ForgetPasswordSecondControllerTests : XCTestCase{
    FakeForgetPasswordSecondViewController *_view;
}

@end

@implementation ForgetPasswordSecondControllerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _view = [[FakeForgetPasswordSecondViewController alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    _view = nil;
}

/**
 *  测试是否为手机号码
 */
-(void)testPhoneNoErr{
    BOOL result = [_view phoneNoErr:@"13112345678"];
    XCTAssertTrue(result);
}

@end
