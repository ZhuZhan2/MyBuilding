//
//  ChatContentView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/6.
//
//

#import "ChatContentView.h"

@interface ChatContentView ()
@property(nonatomic,strong)UILabel* contentLabel;
@property(nonatomic,copy)NSString* text;
@property(nonatomic)BOOL isSelf;
@end

#define chatContentLabelWidth 190
#define chatContentFont [UIFont systemFontOfSize:15]
#define chatContentColor(isSelf) isSelf?[UIColor whiteColor]:[UIColor blackColor];

#define sideDistance 9
#define topDistance 9
#define bottomDistance 9


@implementation ChatContentView
- (instancetype)init{
    if (self = [super init]) {
        [self addSubview:self.contentLabel];
        //[self setUp];
    }
    return self;
}

- (void)setText:(NSString *)text isSelf:(BOOL)isSelf{
    self.text=text;
    self.isSelf=isSelf;
    self.contentLabel.text=text;
    [self setUpContentLabel];
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    UIImage* image=[GetImagePath getImagePath:self.isSelf?@"自己会话框最小@2x":@"他人会话框最小"];
    image=[image stretchableImageWithLeftCapWidth:image.size.width*.5 topCapHeight:image.size.height*.5];
    self.image=image;
}

-(void)setUpContentLabel{
    self.contentLabel.textColor=chatContentColor(self.isSelf);

    CGSize size=[ChatContentView carculateChatContentLabelSizeWithContentStr:self.text];
    CGFloat contentLabelY=topDistance;
    CGFloat contentLabelX=sideDistance+(self.isSelf?(-1):(1))*2;
    self.contentLabel.frame=CGRectMake(contentLabelX, contentLabelY, size.width, size.height);
    
    CGFloat selfWidth=CGRectGetWidth(self.contentLabel.frame)+2*sideDistance;
    CGFloat selfHeight=CGRectGetHeight(self.contentLabel.frame)+topDistance+bottomDistance;
    self.frame=CGRectMake(0, 0, selfWidth, selfHeight);

    //self.contentLabel.backgroundColor=[UIColor grayColor];
    //self.backgroundColor=[UIColor redColor];
}

-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel=[[UILabel alloc]init];
        _contentLabel.numberOfLines=0;
        _contentLabel.font=chatContentFont;
    }
    return _contentLabel;
}

+(CGSize)carculateChatContentLabelSizeWithContentStr:(NSString*)contentStr{
    CGSize size=[contentStr boundingRectWithSize:CGSizeMake(chatContentLabelWidth, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:chatContentFont} context:nil].size;
    return size;
}

+(CGFloat)carculateChatContentViewHeightWithContentStr:(NSString*)contentStr{
    CGSize size=[contentStr boundingRectWithSize:CGSizeMake(chatContentLabelWidth, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:chatContentFont} context:nil].size;
    return size.height+16;
}

-(CGFloat)maxWidth{
    return chatContentLabelWidth+2*sideDistance;
}
@end
