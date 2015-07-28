//
//  PublishViewControllerTests.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/7/27.
//
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "FakePublishViewController.h"
@interface PublishViewControllerTests : XCTestCase
@property (nonatomic, strong)FakePublishViewController* publishVC;
@end

@implementation PublishViewControllerTests

- (void)setUp {
    [super setUp];
    self.publishVC = [[FakePublishViewController alloc] init];
    [self.publishVC viewDidLoad];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

/**
 *  测试isAllSpace:可以正常判断非空内容
 */
- (void)testIsAllSpace{
    NSString* content = @"asdadsa";
    BOOL isAllSpace = [self.publishVC isAllSpace:content];
    XCTAssertFalse(isAllSpace);
}

/**
 *  测试isAllSpace:可以正常判断空内容
 */
- (void)testIsNotAllSpace{
    NSString* content = @"          ";
    BOOL isAllSpace = [self.publishVC isAllSpace:content];
    XCTAssertTrue(isAllSpace);
}

/**
 *  测试清空方法可以情况imageData的数据
 */
- (void)testClearAll{
    [self.publishVC setValue:[NSData new] forKey:@"_imageData"];
    [self.publishVC clearAll];
    XCTAssertFalse([self.publishVC valueForKey:@"_imageData"]);
}
@end
