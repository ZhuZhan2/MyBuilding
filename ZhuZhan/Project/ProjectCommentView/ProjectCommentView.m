//
//  ProjectCommentView.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-4.
//
//

#import "ProjectCommentView.h"

@implementation ProjectCommentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(instancetype)initWithCommentModel:(ContactCommentModel *)model{
    if ([super init]) {
        [self loadSelfWithCommentModel:model];
        contactId = model.a_createdBy;
    }
    return self;
}

-(void)loadSelfWithCommentModel:(ContactCommentModel *)commentModel{
    //获取用户头像
    self.userImageView=[[EGOImageView alloc]initWithPlaceholderImage:[GetImagePath getImagePath:@"人脉_06a2"]];
    self.userImageView.layer.masksToBounds=YES;
    self.userImageView.layer.cornerRadius=5;
    self.userImageView.frame=CGRectMake(15, 15, 37, 37);
    self.userImageView.showActivityIndicator=YES;
    self.userImageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",commentModel.a_avatarUrl]];
    [self addSubview:self.userImageView];
    
    UIButton *headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [headBtn setFrame:CGRectMake(15, 15, 37, 37)];
    [headBtn addTarget:self action:@selector(headActon) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:headBtn];
    
    //用户名称label
    self.userNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(70, 10, 150, 20)];
    self.userNameLabel.text=commentModel.a_userName;
    self.userNameLabel.font=[UIFont systemFontOfSize:16];
    //self.userNameLabel.backgroundColor=[UIColor redColor];
    [self addSubview:self.userNameLabel];
    
    //用户评论内容label
    CGRect bounds=[commentModel.a_commentContents boundingRectWithSize:CGSizeMake(213, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    self.userCommentContent=[[UILabel alloc]initWithFrame:CGRectMake(70, 33, 213, bounds.size.height)];
    self.userCommentContent.numberOfLines=0;
    self.userCommentContent.font=[UIFont systemFontOfSize:14];
    self.userCommentContent.text=commentModel.a_commentContents;
    self.userCommentContent.textColor=RGBCOLOR(86, 86, 86);
    [self addSubview:self.userCommentContent];
    
    CGFloat height=0;
    if (self.userCommentContent.frame.size.height>=25) {
        height=bounds.size.height+40;
    }else{
        height=70;
    }
    self.frame=CGRectMake(6, 0, 308, height);
    self.backgroundColor=[UIColor whiteColor];
    
    UIImageView *delImage = [[UIImageView alloc] initWithFrame:CGRectMake(200, (height-20)/2, 21, 20)];
    delImage.image = [UIImage imageNamed:@"delComment"];
    [self addSubview:delImage];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(-6, height-1, 320, 1)];
    imageView.backgroundColor = [UIColor blackColor];
    imageView.alpha = 0.2;
    [self addSubview:imageView];
}

-(void)headActon{
    if([self.delegate respondsToSelector:@selector(gotoContactDetail:)]){
        [self.delegate gotoContactDetail:contactId];
    }
}
@end
