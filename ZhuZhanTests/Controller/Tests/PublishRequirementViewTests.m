//
//  PublishRequirementViewTests.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/7/24.
//
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "FakePublishRequirementViewController.h"
#import "PublishRequirementProjectView.h"
#import "PublishRequirementMaterialView.h"
#import "PublishRequirementRelationView.h"
#import "PublishRequirementCooperationView.h"
#import "PublishRequirementOtherView.h"
#import "PublishRequirementContactsInfoView.h"
@interface PublishRequirementViewTests : XCTestCase
@property (nonatomic, strong)FakePublishRequirementViewController* publishRequirementVC;
@property (nonatomic, strong)PublishRequirementContactsInfoView* contactsInfoView;
@property (nonatomic, strong)PublishRequirementProjectView* projectView;
@property (nonatomic, strong)PublishRequirementMaterialView* materialView;
@property (nonatomic, strong)PublishRequirementRelationView* relationView;
@property (nonatomic, strong)PublishRequirementCooperationView* cooperationView;
@property (nonatomic, strong)PublishRequirementOtherView* otherView;
@property (nonatomic)NSInteger nowIndex;
@end

@implementation PublishRequirementViewTests

- (void)setUp {
    [super setUp];
    self.publishRequirementVC = [[FakePublishRequirementViewController alloc] init];
    [self.publishRequirementVC viewDidLoad];
    [self.publishRequirementVC.tableView reloadData];
    [self contactsInfoView];
    [self projectView];
    [self materialView];
    [self relationView];
    [self cooperationView];
    [self otherView];
}

/**
 *  测试发布项目时数据正常时可以正常发api
 */
- (void)testPublishRequirementProjectNormal{
    self.nowIndex = 0;
    BOOL isSuccess = [self.publishRequirementVC publishRequirement];
    XCTAssertTrue(isSuccess);
}

/**
 *  测试发布材料时数据正常时可以正常发api
 */
- (void)testPublishRequirementMaterialNormal{
    self.nowIndex = 1;
    BOOL isSuccess = [self.publishRequirementVC publishRequirement];
    XCTAssertTrue(isSuccess);
}

/**
 *  测试发布项目时数据正常时可以正常发api
 */
- (void)testPublishRequirementRelationNormal{
    self.nowIndex = 2;
    BOOL isSuccess = [self.publishRequirementVC publishRequirement];
    XCTAssertTrue(isSuccess);
}

/**
 *  测试发布项目时数据正常时可以正常发api
 */
- (void)testPublishRequirementCooperationNormal{
    self.nowIndex = 3;
    BOOL isSuccess = [self.publishRequirementVC publishRequirement];
    XCTAssertTrue(isSuccess);
}

/**
 *  测试发布项目时数据正常时可以正常发api
 */
- (void)testPublishRequirementOtherNormal{
    self.nowIndex = 4;
    BOOL isSuccess = [self.publishRequirementVC publishRequirement];
    XCTAssertTrue(isSuccess);
}

/**
 *  测试没有电话号码的情况
 */
- (void)testPublishRequirementNoTel{
    self.contactsInfoView.phoneNumber = @"";
    BOOL isSuccess = [self.publishRequirementVC publishRequirement];
    XCTAssertTrue(!isSuccess);
}

/**
 *  测试是否符号电话号码规则
 */
- (void)testPublishRequirementTelRule{
    self.contactsInfoView.phoneNumber = @"abc";
    BOOL isSuccess = [self.publishRequirementVC publishRequirement];
    XCTAssertTrue(!isSuccess);
}

/**
 *  测试真实姓名规则
 */
- (void)testPublishRequirementRealNameRule{
    self.contactsInfoView.realName = @"12312";
    BOOL isSuccess = [self.publishRequirementVC publishRequirement];
    XCTAssertTrue(!isSuccess);
}

- (void)tearDown {
    [super tearDown];
}

- (PublishRequirementContactsInfoView *)contactsInfoView{
    if (!_contactsInfoView) {
        _contactsInfoView = [self.publishRequirementVC valueForKey:@"_contactsInfoView"];

        _contactsInfoView.publishUserName = @"userName";
        _contactsInfoView.realName = @"产品大人";
        _contactsInfoView.phoneNumber = @"13918509902";
        _contactsInfoView.allUserSee = YES;
    }
    return _contactsInfoView;
}

- (PublishRequirementProjectView *)projectView{
    if (!_projectView) {
        _projectView = [self.publishRequirementVC valueForKey:@"_projectView"];

        _projectView.area = @"上海市 普陀区";
        _projectView.minMoney = @"1314";
        _projectView.maxMoney = @"999999";
        _projectView.requirementDescribe = @"我要一片天";
    }
    return _projectView;
}

- (PublishRequirementMaterialView *)materialView{
    if (!_materialView) {
       _materialView = [self.publishRequirementVC valueForKey:@"_materialView"];

        _materialView.bigCategory = @"213123123";
        _materialView.smallCategory = @"123213124";
        _materialView.requirementDescribe = @"我要一撞楼";
        [self.publishRequirementVC setValue:@"1231234" forKey:@"_smallCategoryId"];
        [self.publishRequirementVC setValue:@"12312412" forKey:@"_bigCategoryId"];

    }
    return _materialView;
}

- (PublishRequirementRelationView *)relationView{
    if (!_relationView) {
        _relationView = [self.publishRequirementVC valueForKey:@"_relationView"];

        _relationView.area = @"上海市 普陀区";
        _relationView.requirementDescribe = @"开发部威武";
    }
    return _relationView;
}

- (PublishRequirementCooperationView *)cooperationView{
    if (!_cooperationView) {
        _cooperationView = [self.publishRequirementVC valueForKey:@"_cooperationView"];

        _cooperationView.area = @"上海市 普陀区";
        _cooperationView.requirementDescribe = @"产品大人！您好！";
    }
    return _cooperationView;
}

- (PublishRequirementOtherView *)otherView{
    if (!_otherView) {
        _otherView = [self.publishRequirementVC valueForKey:@"_otherView"];
        
        _otherView.requirementDescribe = @"我是哈哈少年";
    }
    return _otherView;
}

- (NSInteger)nowIndex{
    return [[self.publishRequirementVC valueForKey:@"_nowIndex"] integerValue];
}

- (void)setNowIndex:(NSInteger)nowIndex{
    [self.publishRequirementVC setValue:@(nowIndex) forKey:@"_nowIndex"];
}
@end
