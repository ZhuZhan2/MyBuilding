//
//  RKCompanyController.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/5/26.
//
//

#import "RKCompanyController.h"

@implementation RKCompanyController
- (instancetype)initWithNavi:(UINavigationController *)navi targetId:(NSString *)targetId{
    if (self = [super init]) {
        self.navigationController = navi;
        self.targetId = targetId;
        [self setUp];
    }
    return self;
}
@end
