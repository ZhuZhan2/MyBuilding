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
@interface ProjectCommentView : UIView
@property(nonatomic,strong)EGOImageView* userImageView;
@property(nonatomic,strong)UILabel* userNameLabel;
@property(nonatomic,strong)UILabel* userCommentContent;
-(instancetype)initWithCommentModel:(ContactCommentModel*)model;
@end
