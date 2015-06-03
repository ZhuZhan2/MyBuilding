//
//  ProjectCommentView.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-4.
//
//

#import <UIKit/UIKit.h>
#import "ContactCommentModel.h"

@protocol ProjectCommentViewDelegate <NSObject>

-(void)gotoContactDetail:(NSString *)aid isPersonal:(BOOL)isPersonal;

@end
@interface ProjectCommentView : UIView{
    NSString *contactId;
}
@property(nonatomic,strong)UIImageView* userImageView;
@property(nonatomic,strong)UILabel* userNameLabel;
@property(nonatomic,strong)UILabel* userCommentContent;
@property(nonatomic,weak)id<ProjectCommentViewDelegate>delegate;
@property (nonatomic, strong)ContactCommentModel* model;
-(instancetype)initWithCommentModel:(ContactCommentModel*)model;
@end
