//
//  RKStageChooseViewTests.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/7/16.
//
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "FakeStageChooseView.h"
@interface RKStageChooseViewTests : XCTestCase<RKStageChooseViewDelegate>
@property (nonatomic, strong)FakeStageChooseView* stageChooseView;
@property (nonatomic)BOOL hasRecord;
@end

@implementation RKStageChooseViewTests

- (void)setUp {
    [super setUp];
    self.stageChooseView = (FakeStageChooseView*)[FakeStageChooseView stageChooseViewWithStages:@[@"1",@"2"] numbers:nil delegate:self underLineIsWhole:YES normalColor:nil highlightColor:nil];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

/**
 *  测试模拟点击第二个按钮之后可以正常将值切换
 */
- (void)testStageLabelClickedWithSequence{
    [self.stageChooseView stageLabelClickedWithSequence:1];
    XCTAssertEqual(self.stageChooseView.nowStageNumber, 1);
}

/**
 *  测试FakeStageChooseView可以正常初始化
 */
- (void)testInit{
    XCTAssertNotNil(self.stageChooseView);
}
@end
