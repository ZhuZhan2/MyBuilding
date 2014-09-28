//
//  AddCommentViewController.h
//  ZhuZhan
//
//  Created by 孙元侃 on 14-9-3.
//
//

#import <UIKit/UIKit.h>
@protocol AddCommentDelegate <NSObject>

-(void)cancelFromAddComment;
-(void)sureFromAddCommentWithComment:(NSString*)comment;

@end

@interface AddCommentViewController : UIViewController
@property(nonatomic,weak)id<AddCommentDelegate>delegate;
@end
