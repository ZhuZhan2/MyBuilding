//
//  RKPersonalController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/5/22.
//
//

#import "RKPersonalController.h"

@implementation RKPersonalController
- (instancetype)initWithNavi:(UINavigationController *)navi targetId:(NSString *)targetId{
    if (self = [super init]) {
        self.navigationController = navi;
        self.targetId = targetId;
        [self setUp];
    }
    return self;
}
@end
