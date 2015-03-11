//
//  DiscussionGroupView.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/10.
//
//

#import <UIKit/UIKit.h>

@interface DiscussionGroupModel : NSObject
@property(nonatomic,copy)NSString* imageUrl;
@property(nonatomic,copy)NSString* memberName;
@end

@protocol DiscussionGroupViewDelegate <NSObject>
-(void)finishEditWithTitle:(NSString*)title;
-(DiscussionGroupModel*)addMemberWithNumber:(NSInteger)number;
-(void)setNewNotificaiton:(BOOL)newNotification;
-(void)finishBtnClicked;
@end

@interface DiscussionGroupView : UIButton
+(DiscussionGroupView*)discussionGroupViewWithTitle:(NSString*)title members:(NSArray*)members newNotification:(BOOL)newNotificaiton delegate:(id<DiscussionGroupViewDelegate>)delegate;
@end
