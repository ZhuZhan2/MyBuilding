//
//  CommentView.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-3.
//
//

#import <UIKit/UIKit.h>
#import "ActivesModel.h"

@protocol CommentViewDelegate <NSObject>

-(void)addCommentView:(NSIndexPath *)indexPath;
-(void)gotoDetailView:(NSIndexPath *)indexPath;
-(void)gotoShowView:(NSIndexPath *)indexPath;
@end
@interface CommentView : UIView<UITableViewDelegate,UITableViewDataSource>{
    NSIndexPath *indexpath;
    NSMutableArray *showArr;
}
@property(nonatomic,weak)id<CommentViewDelegate>delegate;
@property(nonatomic,strong)NSMutableArray *showArr;
+(CommentView *)setFram:(ActivesModel *)model;
@property(nonatomic,strong)NSIndexPath *indexpath;
@end
