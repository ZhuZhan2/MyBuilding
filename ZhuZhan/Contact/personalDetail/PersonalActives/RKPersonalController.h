//
//  RKPersonalController.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/5/22.
//
//

#import "RKController.h"

@interface RKPersonalController : RKController
@property (nonatomic, copy)NSString* targetId;
- (instancetype)initWithNavi:(UINavigationController *)navi targetId:(NSString*)targetId;
@end
