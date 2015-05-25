//
//  AskPriceViewController.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/16.
//
//

#import "ChatBaseViewController.h"

@interface AskPriceViewController : ChatBaseViewController
-(instancetype)initWithOtherStr:(NSString*)otherStr;
@property(nonatomic)BOOL isFromCreated;
@end
