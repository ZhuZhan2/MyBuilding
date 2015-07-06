//
//  ForwardListViewController.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/7/1.
//
//

#import <UIKit/UIKit.h>

@protocol ForwardListViewControllerDelegate <NSObject>
- (void)forwardMessageIdSuccess:(NSString*)messageId targetId:(NSString*)targetId;
@end

@interface ForwardListViewController : UIViewController
@property (nonatomic, copy)NSString* messageId;
@property (nonatomic, weak)id<ForwardListViewControllerDelegate> delegate;
@end
