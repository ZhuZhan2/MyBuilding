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
@synthesize indexpath = _indexpath;
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
    CGFloat height=0;
    //上分割线
    UIImageView *topLineImage = [[UIImageView alloc] initWithFrame:CGRectMake(75, 0, 2, 5)];
    [topLineImage setBackgroundColor:[UIColor blackColor]];
    [commentView addSubview:topLineImage];
    topLineImage.alpha =0.2;
    height+=topLineImage.frame.size.height;
    
    //动态图像
    if(![model.a_imageUrl isEqualToString:@""]){
        EGOImageView *imageView = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"bg001.png"]];
        imageView.frame = CGRectMake(5, 5, 310,[model.a_imageHeight floatValue]/[model.a_imageWidth floatValue]*310);
        imageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%s%@",serverAddress,model.a_imageUrl]];
        [commentView addSubview:imageView];
        height+=imageView.frame.size.height;
    }
    
    
    //动态描述
    if (![model.a_content isEqualToString:@""]) {
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.numberOfLines =0;
        UIFont * tfont = [UIFont systemFontOfSize:14];
        contentLabel.font = tfont;
        contentLabel.textColor = [UIColor blackColor];
        contentLabel.lineBreakMode =NSLineBreakByCharWrapping ;
        
        //用户名颜色
        NSString * text = [NSString stringWithFormat:@"%@:%@",model.a_name,model.a_content];
        NSMutableAttributedString* attributedText=[[NSMutableAttributedString alloc]initWithString:text];
        NSRange range=NSMakeRange(0, model.a_name.length+1);
        [attributedText addAttributes:@{NSForegroundColorAttributeName:BlueColor} range:range];
        
        //动态文字内容
        contentLabel.attributedText=attributedText;
        
        
        BOOL imageUrlExist=![model.a_imageUrl isEqualToString:@""];
        //给一个比较大的高度，宽度不变
        CGSize size =CGSizeMake(imageUrlExist?300:250,CGFLOAT_MAX);
        // 获取当前文本的属性
        NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
        //ios7方法，获取文本需要的size，限制宽度
        CGSize actualsize =[text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
        contentLabel.frame =CGRectMake(imageUrlExist?10:60,10, actualsize.width, actualsize.height);
        
        UIView* view=[[UIView alloc]initWithFrame:CGRectMake(5, height, 310, contentLabel.frame.size.height+20)];
        view.backgroundColor=[UIColor whiteColor];
        [view addSubview:contentLabel];
        [commentView addSubview:view];
        height+=contentLabel.frame.size.height;
    }
    
    
    //设置总的frame
    commentView.frame = CGRectMake(0, 0, 320, height+20);
    
    if(height !=0){
        UIButton *commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        commentBtn.frame = CGRectMake(270, height-40, 37, 37);
        [commentBtn setImage:[UIImage imageNamed:@"人脉_66a"] forState:UIControlStateNormal];
        [commentBtn addTarget:commentView action:@selector(commentClick) forControlEvents:UIControlEventTouchUpInside];
        [commentView addSubview:commentBtn];
    }
    return commentView;
}

-(void)commentClick{
    if([self.delegate respondsToSelector:@selector(addCommentView:)]){
        [self.delegate addCommentView:_indexpath];
    }
}

-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexpath = indexPath;
}
@end
