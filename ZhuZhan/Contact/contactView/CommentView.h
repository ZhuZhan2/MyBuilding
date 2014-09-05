//
//  CommentView.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-3.
//
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"

@protocol CommentViewDelegate <NSObject>

-(void)addCommentView:(NSIndexPath *)indexPath;

@end
@interface CommentView : UIView{
    NSIndexPath *indexpath;
}
@property(nonatomic,weak)id<CommentViewDelegate>delegate;
+(CommentView *)setFram:(CommentModel *)model;
@property(nonatomic,strong)NSIndexPath *indexpath;
@end
