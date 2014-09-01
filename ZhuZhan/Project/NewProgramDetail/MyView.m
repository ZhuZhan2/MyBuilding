//
//  MyView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 14-9-1.
//
//

#import "MyView.h"

@implementation MyView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(instancetype)init{
    self=[super init];
    if (self) {
        self.myImageView=[[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"首页_16.png"]];
        self.myImageView.frame=CGRectMake(0, 0, 320, 215.5);
        self.myImageView.showActivityIndicator=YES;
        [self addSubview:self.myImageView];
        
        [self.myImageView addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    CGSize size=self.myImageView.image.size;
    NSLog(@"%f,%f",size.width,size.height);
    self.myImageView.frame=CGRectMake(0, 0, size.width*.5, size.height*.5);
    self.myImageView.center=CGPointMake(160, 215.5*.5);
}

-(void)dealloc{
    NSLog(@"EGOImageView SuperView Dealloc");
    [self.myImageView removeObserver:self forKeyPath:@"image"];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
