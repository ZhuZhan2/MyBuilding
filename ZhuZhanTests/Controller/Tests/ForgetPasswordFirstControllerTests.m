//
//  ForgetPasswordFirstControllerTests.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/7/23.
//
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "FakeForgetPasswordFirstControllerViewController.h"
#import "PooCodeView.h"

/**
 *  忘记密码的单元测试
 */
@interface ForgetPasswordFirstControllerTests : XCTestCase{
    FakeForgetPasswordFirstControllerViewController *_view;
}
-(void)testPhoneNoErr;
@end

@implementation ForgetPasswordFirstControllerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _view = [[FakeForgetPasswordFirstControllerViewController alloc] init];
    [_view viewDidLoad];
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
//    BOOL result = [view phoneNoErr:@"13112345678"];
//    XCTAssertTrue(result);
//    BOOL result = objc_msgSend(_view, @selector(phoneNoErr:),@"13112345678");
//    NSLog(@"result===> %d",result);
//    XCTAssertTrue(result);
    
    //id result = [_view performSelector:@selector(textsting)];
    //NSLog(@"result===> %@",result);
    
//    SEL selector = NSSelectorFromString(@"textsting");
//    IMP imp = [_view methodForSelector:selector];
//    BOOL (*func)(id, SEL) = (void *)imp;
//    BOOL result = func(_view, selector);
//    NSLog(@"result===> %d",result);
    
    BOOL result = [_view phoneNoErr:@"13112345678"];
    XCTAssertTrue(result);
}

/**
 *  测试验证码是否有验证码
 */
-(void)testYZM{
    PooCodeView* codeView = [_view valueForKey:@"_codeView"];
    XCTAssertNotNil(codeView.changeString);
}

/**
 *  判断验证码4位
 */
-(void)testUserName{
    PooCodeView* codeView = [_view valueForKey:@"_codeView"];
    UITextField *textField = [_view valueForKey:@"_yzmTextField"];
    textField.text = codeView.changeString;
    XCTAssertEqual(textField.text.length, 4);
}
@end
