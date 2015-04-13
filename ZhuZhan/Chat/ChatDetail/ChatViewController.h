//
//  ChatViewController.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/5.
//
//

#import <UIKit/UIKit.h>
#import "ChatBaseViewController.h"

@interface ChatViewController : ChatBaseViewController
@property(nonatomic,strong)NSString *contactId;
@property(nonatomic,strong)NSString *type;
-(instancetype)initWithPopViewControllerIndex:(NSInteger)index;
@end
