//
//  MessageTableView.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/4/11.
//
//

#import <UIKit/UIKit.h>
@protocol MessageTableViewDelegate <UITableViewDelegate>
-(void)touchesBeganInMessageTableView;
@end
@interface MessageTableView : UITableView
@property(nonatomic,weak)id<MessageTableViewDelegate>delegate;
@end
