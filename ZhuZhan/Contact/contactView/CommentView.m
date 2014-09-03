//
//  CommentView.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-3.
//
//

#import "CommentView.h"
#import "EGOImageView.h"
@implementation CommentView

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
+(CommentView *)setFram:(CommentModel *)model{
    CommentView *commentView = [[CommentView alloc] init];
    UIImageView *topLineImage = [[UIImageView alloc] initWithFrame:CGRectMake(75, 0, 2, 5)];
    [topLineImage setBackgroundColor:[UIColor blackColor]];
    [commentView addSubview:topLineImage];
    topLineImage.alpha =0.2;
    
    EGOImageView *imageView = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:model.imageUrl]];
    imageView.frame = CGRectMake(5, 5, 310, [UIImage imageNamed:model.imageUrl].size.height/2);
    [commentView addSubview:imageView];
    
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.numberOfLines =0;
    UIFont * tfont = [UIFont systemFontOfSize:14];
    contentLabel.font = tfont;
    contentLabel.textColor = [UIColor blackColor];
    contentLabel.lineBreakMode =NSLineBreakByCharWrapping ;
    contentLabel.text = [NSString stringWithFormat:@"%@:%@",model.name,model.content];
    
    NSString *string = [NSString stringWithFormat:@"%@:%@",model.name,model.content];
    //给一个比较大的高度，宽度不变
    CGSize size =CGSizeMake(300,1000);
    //    获取当前文本的属性
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
    //ios7方法，获取文本需要的size，限制宽度
    CGSize  actualsize =[string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    contentLabel.frame =CGRectMake(10,imageView.frame.size.height+10, actualsize.width, actualsize.height);
    [commentView addSubview:contentLabel];
    
    UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, imageView.frame.size.height+contentLabel.frame.size.height+20, 320, 1)];
    [lineImage setBackgroundColor:[UIColor blackColor]];
    [commentView addSubview:lineImage];
    lineImage.alpha =0.2;
    
    commentView.frame = CGRectMake(0, 0, 320, imageView.frame.size.height+contentLabel.frame.size.height+20);
    
    UIButton *commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commentBtn.frame = CGRectMake(270, imageView.frame.size.height-40, 37, 37);
    [commentBtn setImage:[UIImage imageNamed:@"人脉_66a"] forState:UIControlStateNormal];
    [commentView addSubview:commentBtn];
    return commentView;
}
@end
