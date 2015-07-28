//
//  ForgetPasswordThirdControllerTests.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/7/24.
//
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "FakeForgetPasswordThirdViewController.h"

@interface ForgetPasswordThirdControllerTests : XCTestCase{
    FakeForgetPasswordThirdViewController *_view;
}

@end

@implementation ForgetPasswordThirdControllerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _view = [[FakeForgetPasswordThirdViewController alloc] init];
    [_view viewDidLoad];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    _view = nil;
}

/**
 *  测试密码只有数字，英文和@_-
 */
-(void)testIsRule{
    BOOL result = [_view isRule:@"1133eewq@-_"];
    XCTAssertTrue(result);
}


@end
