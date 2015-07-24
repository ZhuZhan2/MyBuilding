//
//  UpdataPassWordViewControllerTests.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/7/15.
//
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "FakeUpdataPassWordViewController.h"
@interface UpdataPassWordViewControllerTests : XCTestCase
@property (nonatomic, strong)FakeUpdataPassWordViewController* updatePassWordVC;
@end

#define contentHeight (kScreenHeight==480?431:519)

@implementation UpdataPassWordViewControllerTests

- (void)setUp {
    [super setUp];
    self.updatePassWordVC = [[FakeUpdataPassWordViewController alloc] init];
    [self.updatePassWordVC viewDidLoad];
}

- (void)tearDown {
    [super tearDown];
}

/**
 *  测试一个字符串不能全数字
 */
- (void)testNumberNoErr{
    NSString* phone = @"123456789";
    BOOL isAllNumber = [self.updatePassWordVC NumberNoErr:phone];
    XCTAssertTrue(!isAllNumber);
}

/**
 *  测一个字符串不能是全英文
 */
- (void)testLetterNoErr{
    NSString* phone = @"abcsdads";
    BOOL isAllEn = [self.updatePassWordVC LetterNoErr:phone];
    XCTAssertTrue(!isAllEn);
}

/**
 *  测试新密码field可以正常接收字符串
 */
- (void)testNewPassWordTextFieldNormal{
    UITextField* tf = [self.updatePassWordVC valueForKey:@"newPassWordTextField"];
    BOOL isNormal = [self.updatePassWordVC textField:tf shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:@"12345678901234567890"];
    XCTAssertTrue(isNormal);
}

/**
 *  测试确认新密码field可以正常接收字符串
 */
- (void)testNewAgainPassWordTextFieldNormal{
    UITextField* tf = [self.updatePassWordVC valueForKey:@"newAgainPassWordTextField"];
    BOOL isNormal = [self.updatePassWordVC textField:tf shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:@"12345678901234567890"];
    XCTAssertTrue(isNormal);
}

/**
 *  测试新密码field的限制最长字符串长度的功能
 */
- (void)testNewPassWordTextFieldMaxTextCount{
    UITextField* tf = [self.updatePassWordVC valueForKey:@"newPassWordTextField"];
    [self.updatePassWordVC textField:tf shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:@"123456789012345678901"];
    XCTAssertEqual(tf.text.length, 20);
}

/**
 *  测试确认新密码field可以正常接收字符串
 */
- (void)testNewAgainPassWordTextFieldMaxTextCount{
    UITextField* tf = [self.updatePassWordVC valueForKey:@"newAgainPassWordTextField"];
    [self.updatePassWordVC textField:tf shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:@"123456789012345678901"];
    XCTAssertEqual(tf.text.length, 20);
}

/**
 *  测试旧密码field可以正常resign第一响应者
 */
- (void)testOldPassWordTextFieldReturnBtnCanResign{
    UITextField* tf = [self.updatePassWordVC valueForKey:@"oldPassWordTextField"];
    [tf becomeFirstResponder];

    [self.updatePassWordVC textFieldShouldReturn:tf];
    XCTAssertTrue(!tf.isFirstResponder);
}

/**
 *  测试title可以正常接收赋值
 */
- (void)testTitle{
    XCTAssertTrue([self.updatePassWordVC.title isEqualToString:@"修改密码"]);
}

/**
 *  测试确认按钮可以正常初始化
 */
- (void)testConfirmBtnSuccessInit{
    UIButton* btn = [self.updatePassWordVC valueForKey:@"confirmBtn"];
    XCTAssertNotNil(btn);
}

/**
 *  测试确认新密码field可以正常初始化
 */
- (void)testNewAgainPassWordTextFieldSuccessInit{
    UITextField* tf = [self.updatePassWordVC valueForKey:@"newAgainPassWordTextField"];
    XCTAssertNotNil(tf);
}

/**
 *  测试新密码field可以正常初始化
 */
- (void)testNewPassWordTextFieldSuccessInit{
    UITextField* tf = [self.updatePassWordVC valueForKey:@"newPassWordTextField"];
    XCTAssertNotNil(tf);
}

/**
 *  测试旧密码field可以正常初始化
 */
- (void)testOldPassWordTextFieldSuccessInit{
    UITextField* tf = [self.updatePassWordVC valueForKey:@"oldPassWordTextField"];
    XCTAssertNotNil(tf);
}

/**
 *  测试UpdataPassWordViewController可以正常初始化
 */
- (void)testUpdatePassWordVCSuccessInit{
    UpdataPassWordViewController* vc = [[UpdataPassWordViewController alloc] init];
    XCTAssertTrue([vc isKindOfClass:[UpdataPassWordViewController class]]);
}
@end
