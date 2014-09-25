//
//  MyView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 14-9-1.
//
//

#import "MyView.h"
@interface MyView ()
@property(nonatomic,strong)UIImage* originImage;
@end
@implementation MyView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

-(instancetype)init{
    self=[super init];
    if (self) {
        self.originImage=[GetImagePath getImagePath:@"首页_16"];
        self.myImageView=[[EGOImageView alloc]initWithPlaceholderImage:self.originImage];
        self.myImageView.frame=CGRectMake(0, 0, 320, 215.5);
        self.myImageView.showActivityIndicator=YES;
        [self addSubview:self.myImageView];
    }
    return self;
}

-(void)observeImage{
    [self.myImageView addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if (self.myImageView.image==self.originImage) return;
    CGSize size=self.myImageView.image.size;
    self.myImageView.frame=CGRectMake(0, 0, size.width*.5, size.height*.5);
    self.myImageView.center=CGPointMake(160, 215.5*.5);
}

-(void)dealloc{
    NSLog(@"EGOImageView SuperView Dealloc");
    [self.myImageView removeObserver:self forKeyPath:@"image"];
}
@end
