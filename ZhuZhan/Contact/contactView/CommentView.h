//
//  CommentView.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-3.
//
//

#import <UIKit/UIKit.h>
#import "ActivesModel.h"
#import "HeadImageDelegate.h"
#import "ContactCommentTableViewCell.h"
#import "EGOImageView.h"
@protocol CommentViewDelegate <NSObject>

-(void)addCommentView:(NSIndexPath *)indexPath;
-(void)gotoDetailView:(NSIndexPath *)indexPath;
-(void)gotoContactDetail:(NSString *)aid userType:(NSString *)userType;
@end
@interface CommentView : UIView<UITableViewDelegate,UITableViewDataSource,ContactCommentTableViewDelegate>{
    NSIndexPath *indexpath;
    NSMutableArray *showArr;
}
@property(nonatomic,strong)NSIndexPath *indexpath;
@property(nonatomic,weak)id<CommentViewDelegate>delegate;
@property(nonatomic,weak)id<HeadImageDelegate>headImageDelegate;
@property(nonatomic,strong)NSMutableArray *showArr;
+(CommentView *)setFram:(ActivesModel *)model;
@end
