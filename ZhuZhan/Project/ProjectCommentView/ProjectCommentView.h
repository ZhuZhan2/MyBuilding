//
//  ProjectCommentView.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-4.
//
//

#import <UIKit/UIKit.h>
#import "ContactCommentModel.h"
#import "EGOImageView.h"

@protocol ProjectCommentViewDelegate <NSObject>

-(void)gotoContactDetail:(NSString *)aid;

@end
@interface ProjectCommentView : UIView{
    NSString *contactId;
}
@property(nonatomic,strong)EGOImageView* userImageView;
@property(nonatomic,strong)UILabel* userNameLabel;
@property(nonatomic,strong)UILabel* userCommentContent;
@property(nonatomic,weak)id<ProjectCommentViewDelegate>delegate;
-(instancetype)initWithCommentModel:(ContactCommentModel*)model;
@end
