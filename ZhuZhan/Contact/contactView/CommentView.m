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
    UIImageView *topLineImage = [[UIImageView alloc] initWithFrame:CGRectMake(75, 0, 2, 5)];
    [topLineImage setBackgroundColor:[UIColor blackColor]];
    [commentView addSubview:topLineImage];
    topLineImage.alpha =0.2;
    
    EGOImageView *imageView = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"bg001.png"]];
    
    if(![model.a_imageUrl isEqualToString:@""]){
        if(![model.a_imageWidth isEqualToString:@""]){
            imageView.frame = CGRectMake(5, 5, 310,[model.a_imageHeight intValue]*1.0/([model.a_imageWidth intValue]*1.0/310));
            imageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%s%@",serverAddress,model.a_imageUrl]];
        }else{
            imageView.frame = CGRectMake(5, 5, 0, 0);
        }
    }else{
        imageView.frame = CGRectMake(5, 5, 0, 0);
    }
    
    [commentView addSubview:imageView];
    
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.numberOfLines =0;
    UIFont * tfont = [UIFont systemFontOfSize:14];
    contentLabel.font = tfont;
    contentLabel.textColor = [UIColor blackColor];
    contentLabel.lineBreakMode =NSLineBreakByCharWrapping ;
    contentLabel.text = [NSString stringWithFormat:@"%@:%@",model.a_name,model.a_content];
    
    NSString *string = [NSString stringWithFormat:@"%@:%@",model.a_name,model.a_content];
    //给一个比较大的高度，宽度不变
    CGSize size =CGSizeMake(300,1000);
    //    获取当前文本的属性
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
    //ios7方法，获取文本需要的size，限制宽度
    CGSize  actualsize =[string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    contentLabel.frame =CGRectMake(10,imageView.frame.size.height+10, actualsize.width, actualsize.height);
    [commentView addSubview:contentLabel];
    
    
    commentView.frame = CGRectMake(0, 0, 320, imageView.frame.size.height+contentLabel.frame.size.height+20);
    
    if(imageView.frame.size.height !=0){
        UIButton *commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        commentBtn.frame = CGRectMake(270, imageView.frame.size.height-40, 37, 37);
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
