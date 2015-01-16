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
@end

@implementation ProductCommentView

-(instancetype)initWithCommentImageUrl:(NSString*)userImageUrl userName:(NSString*)userName commentContent:(NSString*)commentContent{
    if ([super init]) {
        [self loadSelfWithCommentImageUrl:userImageUrl userName:userName commentContent:commentContent];
    }
    return self;
}

-(void)loadSelfWithCommentImageUrl:(NSString*)userImageUrl userName:(NSString*)userName commentContent:(NSString*)commentContent{
    //获取用户头像
    self.userImageView=[[EGOImageView alloc]initWithPlaceholderImage:[GetImagePath getImagePath:@"人脉_06a2"]];
    self.userImageView.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@",userImageUrl]];
    self.userImageView.layer.masksToBounds=YES;
    self.userImageView.layer.cornerRadius=3;
    self.userImageView.frame=CGRectMake(15, 15, 37, 37);
    [self addSubview:self.userImageView];
    
    //用户名称label
    self.userNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(70, 7, 200, 20)];
    self.userNameLabel.text=userName;
    self.userNameLabel.font=[UIFont systemFontOfSize:16];
    //self.userNameLabel.backgroundColor=[UIColor redColor];
    [self addSubview:self.userNameLabel];
    
    //用户评论内容label
    CGRect bounds=[commentContent boundingRectWithSize:CGSizeMake(213, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
    self.userCommentContent=[[UILabel alloc]initWithFrame:CGRectMake(70, 30, 213, bounds.size.height)];
    self.userCommentContent.numberOfLines=0;
    self.userCommentContent.font=[UIFont systemFontOfSize:13];
    self.userCommentContent.text=commentContent;
    self.userCommentContent.textColor=RGBCOLOR(86, 86, 86);
    [self addSubview:self.userCommentContent];
    NSLog(@"=====>%@",commentContent);
    
    CGFloat height=0;
    if (self.userCommentContent.frame.size.height>=25) {
        height=bounds.size.height+40;
    }else{
        height=70;
    }
    
    self.frame=CGRectMake(5, 0, 310, height);
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

