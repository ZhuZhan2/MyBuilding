//
//  ProductCommentView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 14-9-3.
//
//

#import "ProductCommentView.h"
#import "EGOImageView.h"

@interface ProductCommentView()
@property(nonatomic,strong)EGOImageView* userImageView;
@property(nonatomic,strong)UILabel* userNameLabel;
@property(nonatomic,strong)UILabel* userCommentContent;
@property(nonatomic,strong)UILabel* publishTime;
@end

@implementation ProductCommentView

-(instancetype)initWithCommentModel:(CommentModel*)commentModel{
    if ([super init]) {
        [self loadSelfWithCommentModel:commentModel];
    }
    return self;
}

-(void)loadSelfWithCommentModel:(CommentModel*)commentModel{
    //获取用户头像
    self.userImageView=[[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"首页_16.png"]];
    self.userImageView.frame=CGRectMake(20, 0, 50, 50);
    self.userImageView.showActivityIndicator=YES;
    [self addSubview:self.userImageView];
    
    
    
    //用户名称label
    
    //用户评论内容label
    
    //用户发表评论时间
    self.frame=CGRectMake(20, 0, 280, 80);
    self.backgroundColor=[UIColor whiteColor];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
@end

