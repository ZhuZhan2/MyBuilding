//
//  ChatViewController.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/5.
//
//

#import <UIKit/UIKit.h>
#import "ChatBaseViewController.h"

@protocol ChatViewControllerDelegate <NSObject>
-(void)reloadList;
@end

@interface ChatViewController : ChatBaseViewController
@property(nonatomic,strong)NSString *contactId;
@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)NSString *titleStr;
@property(nonatomic,strong)NSString *fromView;
@property(nonatomic,weak)id<ChatViewControllerDelegate>delegate;
-(instancetype)initWithPopViewControllerIndex:(NSInteger)index;
@end
