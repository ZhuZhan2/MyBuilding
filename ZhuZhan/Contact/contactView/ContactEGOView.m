//
//  ContactEGOView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 14/12/24.
//
//

#import "ContactEGOView.h"
@interface ContactEGOView ()
@property(nonatomic,strong)UIImage* originImage;
@property(nonatomic,strong)UIImageView* backImageView;
@end
@implementation ContactEGOView

-(instancetype)init{
    if (self=[super init]) {
        [self setUp];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

-(void)setUp{
    self.backImageView=[[UIImageView alloc]initWithFrame:self.bounds];
    self.backImageView.image=[GetImagePath getImagePath:@"主站－人脉03"];
    [self addSubview:self.backImageView];
    
    self.myImageView=[[UIImageView alloc]init];
    self.myImageView.frame=CGRectZero;//CGRectMake(0, 0, 320, 215.5);
}

-(void)observeImage{
    [self.myImageView addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if (self.myImageView.image==self.originImage) return;
    CGSize size=self.myImageView.image.size;
    BOOL heightIsBiger=(size.height/size.width)>(self.frame.size.height/self.frame.size.width);
    CGFloat scale=heightIsBiger?(self.frame.size.height/size.height):(self.frame.size.width/size.width);
    CGFloat height=size.height*scale;
    CGFloat width=size.width*scale;
    self.myImageView.frame=CGRectMake(0, 0,  width, height);
    self.myImageView.center=CGPointMake(width*.5, self.frame.size.height*.5);
    NSLog(@"%f==%f",self.center.x,self.center.y);
    [self addSubview:self.myImageView];
    [self.backImageView removeFromSuperview];
}

-(void)dealloc{
    [self.myImageView removeObserver:self forKeyPath:@"image"];
}
@end
