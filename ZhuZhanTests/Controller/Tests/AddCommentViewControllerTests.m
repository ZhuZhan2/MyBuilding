//
//  AddCommentViewControllerTests.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/7/27.
//
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "FakeAddCommentViewController.h"
@interface AddCommentViewControllerTests : XCTestCase
@property (nonatomic, strong)FakeAddCommentViewController* commentVC;
@property (nonatomic, strong)UITextView* contentTextView;
@end

@implementation AddCommentViewControllerTests

- (void)setUp {
    [super setUp];
    self.commentVC = [[FakeAddCommentViewController alloc] init];
    [self.commentVC viewDidLoad];
}

- (void)tearDown {
    [super tearDown];
}

/**
 *  测试最大字数
 */
- (void)testMaxCount{
    NSString* text = @"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
    @"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
    @"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
        @"123";
    self.contentTextView.text = text;
    [self.commentVC textViewDidChange:self.contentTextView];
    XCTAssertEqual(self.contentTextView.text.length, 300);
}

- (UITextView *)contentTextView{
    if (!_contentTextView) {
        _contentTextView = [self.commentVC valueForKey:@"textView"];
    }
    return _contentTextView;
}
@end
