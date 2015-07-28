//
//  ProductPublishControllerTests.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/7/28.
//
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "FakeProductPublishController.h"
@interface ProductPublishControllerTests : XCTestCase
@property (nonatomic, strong)FakeProductPublishController* productPublishVC;
@property (nonatomic, strong)UITextView* titleTextView;
@property (nonatomic, strong)UITextView* contentTextView;
@property (nonatomic, strong)UIImage* cameraImage;
@end

@implementation ProductPublishControllerTests

- (void)setUp {
    [super setUp];
    self.productPublishVC = [[FakeProductPublishController alloc] init];
    [self.productPublishVC viewDidLoad];
}

- (void)tearDown {
    [super tearDown];
}

/**
 *  测试在正常输入的情况下可以正常发布
 */
- (void)testGotoPublishNormal{
    self.titleTextView.text = @"123";
    self.contentTextView.text = @"123";
    
    self.cameraImage = [UIImage new];
    BOOL isSuccess = [self.productPublishVC goToPublish];
    XCTAssertTrue(isSuccess);
}

- (UITextView *)titleTextView{
    return [self.productPublishVC valueForKey:@"_titleTextView"];
}

- (UITextView *)contentTextView{
    return [self.productPublishVC valueForKey:@"_contentTextView"];
}

- (UIImage *)cameraImage{
    return [self.productPublishVC valueForKey:@"_cameraImage"];
}

- (void)setCameraImage:(UIImage *)cameraImage{
    [self.productPublishVC setValue:cameraImage forKey:@"_cameraImage"];
}
@end
