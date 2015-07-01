//
//  ForwardChooseContactsController.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/7/1.
//
//

#import "ChatBaseViewController.h"

@protocol ForwardChooseContactsControllerDelegate <NSObject>
//
- (void)forwardChooseTargetId:(NSString*)targetId isGroup:(BOOL)isGroup targetName:(NSString*)targetName;
@end

@interface ForwardChooseContactsController : ChatBaseViewController
@property (nonatomic, weak)id<ForwardChooseContactsControllerDelegate> delegate;
@end
