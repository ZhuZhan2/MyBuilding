//
//  ProjectStageTests.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/7/16.
//
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "FakeProjectStage.h"
@interface ProjectStageTests : XCTestCase
@property (nonatomic, strong)NSMutableArray* allContent;
@property (nonatomic, strong)NSMutableArray* contacts;
@property (nonatomic, strong)NSMutableArray* images;

@end

@implementation ProjectStageTests

- (void)setUp {
    [super setUp];
    self.allContent = [NSMutableArray array];
    self.contacts = [NSMutableArray array];
    self.images = [NSMutableArray array];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    _allContent = nil;
    _contacts = nil;
    _images = nil;
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma nil nil x
//不测，实际不发生，并且情况太特殊，不关注结果
//- (void)testAllContentNilContactsNilImagesNilReturnNone{}
- (void)testAllContentNilContactsNilImages0ReturnNone{
    [self setDetailStageCount:-1 contactsCount:-1 imagesCount:0];
    NSString* returnStr = [self getReturnStr];
    XCTAssertTrue([returnStr isEqualToString:@"none"]);
}
- (void)testAllContentNilContactsNilImages1ReturnPart{
    [self setDetailStageCount:-1 contactsCount:-1 imagesCount:1];
    NSString* returnStr = [self getReturnStr];
    XCTAssertTrue([returnStr isEqualToString:@"all"]);
}

#pragma nil 0 x
- (void)testAllContentNilContacts0ImagesNilReturnNone{
    [self setDetailStageCount:-1 contactsCount:0 imagesCount:-1];
    NSString* returnStr = [self getReturnStr];
    XCTAssertTrue([returnStr isEqualToString:@"none"]);
}

- (void)testAllContentNilContacts0Images0ReturnNone{
    [self setDetailStageCount:-1 contactsCount:0 imagesCount:0];
    NSString* returnStr = [self getReturnStr];
    XCTAssertTrue([returnStr isEqualToString:@"none"]);
}

- (void)testAllContentNilContacts0Images1ReturnPart{
    [self setDetailStageCount:-1 contactsCount:0 imagesCount:1];
    NSString* returnStr = [self getReturnStr];
    XCTAssertTrue([returnStr isEqualToString:@"part"]);
}

#pragma nil 1 x
- (void)testAllContentNilContacts1ImagesNilReturnPart{
    [self setDetailStageCount:-1 contactsCount:1 imagesCount:-1];
    NSString* returnStr = [self getReturnStr];
    NSLog(@"returnStr = %@",returnStr);
    XCTAssertTrue([returnStr isEqualToString:@"part"]);
}

- (void)testAllContentNilContacts1Images0ReturnPart{
    [self setDetailStageCount:-1 contactsCount:1 imagesCount:0];
    NSString* returnStr = [self getReturnStr];
    XCTAssertTrue([returnStr isEqualToString:@"part"]);
}

- (void)testAllContentNilContacts1Images1ReturnPart{
    [self setDetailStageCount:-1 contactsCount:1 imagesCount:1];
    NSString* returnStr = [self getReturnStr];
    XCTAssertTrue([returnStr isEqualToString:@"part"]);
}

#pragma nil 3 x
- (void)testAllContentNilContacts3ImagesNilReturnAll{
    [self setDetailStageCount:-1 contactsCount:3 imagesCount:-1];
    NSString* returnStr = [self getReturnStr];
    XCTAssertTrue([returnStr isEqualToString:@"all"]);
}

- (void)testAllContentNilContacts3Images0ReturnPart{
    [self setDetailStageCount:-1 contactsCount:3 imagesCount:0];
    NSString* returnStr = [self getReturnStr];
    XCTAssertTrue([returnStr isEqualToString:@"part"]);
}

- (void)testAllContentNilContacts3Images1ReturnAll{
    [self setDetailStageCount:-1 contactsCount:3 imagesCount:1];
    NSString* returnStr = [self getReturnStr];
    XCTAssertTrue([returnStr isEqualToString:@"all"]);
}

#pragma 0 nil x
- (void)testDetailStage0ContactsNilImagesNilReturnNone{
    [self setDetailStageCount:0 contactsCount:-1 imagesCount:-1];
    NSString* returnStr = [self getReturnStr];
    XCTAssertTrue([returnStr isEqualToString:@"none"]);
}

- (void)testDetailStage0ContactsNilImages0ReturnNone{
    [self setDetailStageCount:0 contactsCount:-1 imagesCount:0];
    NSString* returnStr = [self getReturnStr];
    XCTAssertTrue([returnStr isEqualToString:@"none"]);
}

- (void)testDetailStage0ContactsNilImages1ReturnPart{
    [self setDetailStageCount:0 contactsCount:-1 imagesCount:1];
    NSString* returnStr = [self getReturnStr];
    XCTAssertTrue([returnStr isEqualToString:@"all"]);
}

#pragma 0 0 x
- (void)testDetailStage0Contacts0ImagesNilReturnNone{
    [self setDetailStageCount:0 contactsCount:0 imagesCount:-1];
    NSString* returnStr = [self getReturnStr];
    XCTAssertTrue([returnStr isEqualToString:@"none"]);
}

- (void)testDetailStage0Contacts0Images0ReturnNone{
    [self setDetailStageCount:0 contactsCount:0 imagesCount:0];
    NSString* returnStr = [self getReturnStr];
    XCTAssertTrue([returnStr isEqualToString:@"none"]);
}
- (void)testDetailStage0Contacts0Images1ReturnPart{
    [self setDetailStageCount:0 contactsCount:0 imagesCount:1];
    NSString* returnStr = [self getReturnStr];
    XCTAssertTrue([returnStr isEqualToString:@"part"]);
}

#pragma 0 1 x
- (void)testDetailStage0Contacts1ImagesNilReturnPart{
    [self setDetailStageCount:0 contactsCount:1 imagesCount:-1];
    NSString* returnStr = [self getReturnStr];
    XCTAssertTrue([returnStr isEqualToString:@"part"]);
}

- (void)testDetailStage0Contacts1Images0ReturnPart{
    [self setDetailStageCount:0 contactsCount:1 imagesCount:0];
    NSString* returnStr = [self getReturnStr];
    XCTAssertTrue([returnStr isEqualToString:@"part"]);
}

- (void)testDetailStage0Contacts1Images1ReturnPart{
    [self setDetailStageCount:0 contactsCount:1 imagesCount:1];
    NSString* returnStr = [self getReturnStr];
    XCTAssertTrue([returnStr isEqualToString:@"part"]);
}

#pragma 0 3 x
- (void)testDetailStage0Contacts3ImagesNilReturnPart{
    [self setDetailStageCount:0 contactsCount:3 imagesCount:-1];
    NSString* returnStr = [self getReturnStr];
    XCTAssertTrue([returnStr isEqualToString:@"all"]);
}

- (void)testDetailStage0Contacts3Images0ReturnPart{
    [self setDetailStageCount:0 contactsCount:3 imagesCount:0];
    NSString* returnStr = [self getReturnStr];
    XCTAssertTrue([returnStr isEqualToString:@"part"]);
}

- (void)testDetailStage0Contacts3Images1ReturnPart{
    [self setDetailStageCount:0 contactsCount:3 imagesCount:1];
    NSString* returnStr = [self getReturnStr];
    XCTAssertTrue([returnStr isEqualToString:@"all"]);
}

#pragma 1 nil x
- (void)testDetailStage1ContactsNilImagesNilReturnAll{
    [self setDetailStageCount:1 contactsCount:-1 imagesCount:-1];
    NSString* returnStr = [self getReturnStr];
    XCTAssertTrue([returnStr isEqualToString:@"all"]);
}

- (void)testDetailStage1ContactsNilImages0ReturnPart{
    [self setDetailStageCount:1 contactsCount:-1 imagesCount:0];
    NSString* returnStr = [self getReturnStr];
    XCTAssertTrue([returnStr isEqualToString:@"part"]);
}
- (void)testDetailStage1ContactsNilImages1ReturnAll{
    [self setDetailStageCount:1 contactsCount:-1 imagesCount:1];
    NSString* returnStr = [self getReturnStr];
    XCTAssertTrue([returnStr isEqualToString:@"all"]);
}

#pragma 1 0 x
- (void)testDetailStage1Contacts0ImagesNilReturnPart{
    [self setDetailStageCount:1 contactsCount:0 imagesCount:-1];
    NSString* returnStr = [self getReturnStr];
    XCTAssertTrue([returnStr isEqualToString:@"part"]);
}
- (void)testDetailStage1Contacts0Images0ReturnPart{
    [self setDetailStageCount:1 contactsCount:0 imagesCount:0];
    NSString* returnStr = [self getReturnStr];
    XCTAssertTrue([returnStr isEqualToString:@"part"]);
}
- (void)testDetailStage1Contacts0Images1ReturnPart{
    [self setDetailStageCount:1 contactsCount:0 imagesCount:1];
    NSString* returnStr = [self getReturnStr];
    XCTAssertTrue([returnStr isEqualToString:@"part"]);
}

#pragma 1 1 x
- (void)testDetailStage1Contacts1ImagesNilReturnPart{
    [self setDetailStageCount:1 contactsCount:1 imagesCount:-1];
    NSString* returnStr = [self getReturnStr];
    XCTAssertTrue([returnStr isEqualToString:@"part"]);
}

- (void)testDetailStage1Contacts1Images0ReturnPart{
    [self setDetailStageCount:1 contactsCount:1 imagesCount:0];
    NSString* returnStr = [self getReturnStr];
    XCTAssertTrue([returnStr isEqualToString:@"part"]);
}

- (void)testDetailStage1Contacts1Images1ReturnPart{
    [self setDetailStageCount:1 contactsCount:1 imagesCount:1];
    NSString* returnStr = [FakeProjectStage getPart:self.allContent contacts:self.contacts images:self.images];
    XCTAssertTrue([returnStr isEqualToString:@"part"]);
}

#pragma 1 3 x
- (void)testDetailStage1Contacts3ImagesNilReturnAll{
    [self setDetailStageCount:1 contactsCount:3 imagesCount:-1];
    NSString* returnStr = [self getReturnStr];
    XCTAssertTrue([returnStr isEqualToString:@"all"]);
}

- (void)testDetailStage1Contacts3Images0ReturnPart{
    [self setDetailStageCount:1 contactsCount:3 imagesCount:0];
    NSString* returnStr = [self getReturnStr];
    XCTAssertTrue([returnStr isEqualToString:@"part"]);
}

- (void)testDetailStage1Contacts3Images1ReturnAll{
    [self setDetailStageCount:1 contactsCount:3 imagesCount:1];
    NSString* returnStr = [FakeProjectStage getPart:self.allContent contacts:self.contacts images:self.images];
    XCTAssertTrue([returnStr isEqualToString:@"all"]);
}


- (void)testSet{
    [self setDetailStageCount:2 contactsCount:2 imagesCount:2];
    XCTAssertTrue(self.allContent.count == 4);
    XCTAssertTrue(self.contacts.count == 2);
    XCTAssertTrue(self.images.count == 2);
}

//如果界面需要联系人或图片则将其加入detailStage，不需要在不加入数组,传-1等于不要加入数组
/**
 *  @param count1 传需要展示的字段数量 所以传0和-1是一样的，测试用例错误，多写了
 *  @param count2 传实际有的联系人数量
 *  @param count3 传实际有的图片数量
 */
- (void)setDetailStageCount:(NSInteger)count1 contactsCount:(NSInteger)count2 imagesCount:(NSInteger)count3{
    if (count1 > 0) {
        for (int i=0;i<count1;i++) {
            NSString* str = @" ";
            [self.allContent addObject:str];
        }
    }
    
    if (count2 > 0) {
        for (int i=0;i<count2;i++) {
            NSArray* aContact = @[@"12",@"11",@"1",@"1",@"1"];
            [self.contacts addObject:aContact];
        }
    }
    
    if (count3 > 0) {
        for (int i=0;i<count3;i++) {
            NSString* str = @" ";
            [self.images addObject:str];
        }
    }
    
    if (count2 != -1) {
        [self.allContent addObject:self.contacts];
    }else{
        self.contacts = nil;
    }
    
    if (count3 != -1) {
        [self.allContent addObject:self.images];
    }else{
        self.images = nil;
    }
}

- (NSString*)getReturnStr{
    return [FakeProjectStage getPart:self.allContent contacts:self.contacts images:self.images];
}
@end
