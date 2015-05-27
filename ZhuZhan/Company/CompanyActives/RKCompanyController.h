//
//  RKCompanyController.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/5/26.
//
//

#import "RKController.h"

@interface RKCompanyController : RKController
@property (nonatomic, copy)NSString* targetId;
- (instancetype)initWithNavi:(UINavigationController *)navi targetId:(NSString*)targetId;
@end
