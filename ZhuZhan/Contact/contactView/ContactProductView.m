//
//  ContactProductView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 14/12/23.
//
//

#import "ContactProductView.h"
#import "ContactEGOView.h"
@interface ContactProductView()
@property(nonatomic,copy)NSString* usrImgUrl;
@property(nonatomic,copy)NSString* productImgUrl;
@property(nonatomic,copy)NSString* productContent;
@end

@implementation ContactProductView
-(instancetype)initWithUsrImgUrl:(NSString*)usrImgUrl productImgUrl:(NSString*)productImgUrl productContent:(NSString*)productContent{
    if (self=[super initWithFrame:CGRectZero]) {
        self.usrImgUrl=usrImgUrl;
        self.productImgUrl=productImgUrl;
        self.productContent=productContent;
        //[NSString stringWithFormat:@"%@你妹你妹你妹extra================ddddddddddddd",productContent];
        [self setUp];
        [self setBackgroundColor:RGBCOLOR(242, 242, 242)];
        UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-1, 320, 1)];
        [lineImage setBackgroundColor:[UIColor blackColor]];
        [self addSubview:lineImage];
        lineImage.alpha = 0.1;
        
        UIImageView *lineImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(67, 0, 2, self.frame.size.height)];
        [lineImage2 setBackgroundColor:[UIColor blackColor]];
        [self addSubview:lineImage2];
        [self sendSubviewToBack:lineImage2];
        lineImage2.alpha = 0.2;
    }
    return self;
}

-(void)setUp{
    UIImageView* userImageView=[[UIImageView alloc] init];
    [userImageView sd_setImageWithURL:[NSURL URLWithString:self.usrImgUrl] placeholderImage:[GetImagePath getImagePath:@"人脉_06a2"]];
    [userImageView setFrame:CGRectMake(10, 6.5, 37, 37)];
    userImageView.layer.masksToBounds = YES;
    userImageView.layer.cornerRadius = 3;
    [self addSubview:userImageView];
    
    UIButton *headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [headBtn setFrame:CGRectMake(10, 6.5, 37, 37)];
    [headBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:headBtn];
    
    UIImageView* stageImageView=[[UIImageView alloc]initWithFrame:CGRectMake(62, 18.5, 12, 13)];
    stageImageView.image=[GetImagePath getImagePath:@"人脉－个人中心_06a"];
    [self addSubview:stageImageView];
    
    CGFloat height=0;
    if (![self.productImgUrl isEqualToString:@""]) {
        ContactEGOView* productImgView=[[ContactEGOView alloc]initWithFrame:CGRectMake(90, 10, 208, 132.5)];
        [productImgView observeImage];
        [productImgView.myImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.productImgUrl]] placeholderImage:[GetImagePath getImagePath:@"主站－人脉03"]];
        [self addSubview:productImgView];
        height=productImgView.frame.origin.y+productImgView.frame.size.height;
    }
    
    if (![self.productContent isEqualToString:@""]) {
        UIFont* font=[UIFont systemFontOfSize:13];
        UILabel* contentLabel=[[UILabel alloc]initWithFrame:CGRectZero];
        contentLabel.text=self.productContent;
        contentLabel.numberOfLines=0;
        CGSize size=[self.productContent boundingRectWithSize:CGSizeMake(208, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
        if (size.height>30) {
            size.height=35;
        }
        contentLabel.font=font;
        contentLabel.frame=CGRectMake(90, height+10, 208, size.height);
        [self addSubview:contentLabel];
        
        height=contentLabel.frame.origin.y+contentLabel.frame.size.height;
    }
    
    UILabel* remindLabel=[[UILabel alloc]initWithFrame:CGRectMake(90, height+7, 200, 15)];
    remindLabel.text=@"关注的产品新增了评论";
    remindLabel.font=[UIFont systemFontOfSize:12.5];
    [self addSubview:remindLabel];
    remindLabel.textColor=RGBCOLOR(155, 155, 155);
    height=remindLabel.frame.origin.y+remindLabel.frame.size.height;
    self.frame=CGRectMake(0, 0, 320, height+10);
}

-(void)btnClick:(UIButton *)button{
    if([self.delegate respondsToSelector:@selector(HeadImageAction:)]){
        [self.delegate HeadImageAction:_indexpath];
    }
}
@end
