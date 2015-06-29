//
//  FirstOpenAppAnimationView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 14/12/9.
//
//

#import "FirstOpenAppAnimationView.h"
#import "FirstAnimationView.h"
#import "SecondAnimationView.h"
#import "ThirdAnimationView.h"
#import "FourthAnimationView.h"
@interface FirstOpenAppAnimationView ()<UIScrollViewDelegate,AnimationDelegate>
@property (nonatomic, strong) NSMutableArray *views;
@property (nonatomic, strong) NSMutableArray *views2;
@property(nonatomic,strong) FirstAnimationView *main;
@property(nonatomic,strong)SecondAnimationView *first;
@property(nonatomic,strong)ThirdAnimationView *second;
@property(nonatomic,strong)FourthAnimationView *third;
@property (nonatomic, assign) BOOL canMoveWithGesture;

@end

@implementation FirstOpenAppAnimationView
//static int j;

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor whiteColor];
        self.canMoveWithGesture=NO;
        self.scrollview=[[UIScrollView alloc]initWithFrame:self.frame];
        self.scrollview.contentSize=CGSizeMake(320*2, kScreenHeight);
        self.scrollview.pagingEnabled=YES;
        self.scrollview.delegate = self;
        self.scrollview.showsHorizontalScrollIndicator=NO;
        self.scrollview.userInteractionEnabled=NO;
        [self addSubview:self.scrollview];
        
        self.views = [[NSMutableArray alloc] init];
        for (unsigned i = 0; i < 4; i++)
        {
            [self.views addObject:[NSNull null]];
        }
        
        [self loadScrollViewWithPage:0];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismis) name:@"dismis" object:nil];
        
    }
    return self;
}

-(void)dismis{
    CGRect frame=self.frame;
    frame.origin.y+=kScreenHeight;
    [UIView animateWithDuration:.3 animations:^{
        self.frame=frame;
    } completion:^(BOOL finished) {
        NSLog(@"firstLaunch==>%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"serverAddress"]);
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self removeFromSuperview];
    }];
}

- (void)loadScrollViewWithPage:(int)page
{
    if (page < 0)
        return;
    if (page >= 4)
        return;
    
    UIView *controller = [self.views objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null])
    {
        if(page == 0){
            controller = [[FirstAnimationView alloc] initWithFrame:self.frame];
        }else if(page == 1){
            controller = [[SecondAnimationView alloc] initWithFrame:self.frame];
        }else if(page == 2){
            controller = [[ThirdAnimationView alloc] initWithFrame:self.frame];
        }else{
            controller = [[FourthAnimationView alloc] initWithFrame:self.frame];
        }
        FirstAnimationView* temp=(FirstAnimationView*)controller;
        temp.delegate=self;
        
        [self.views replaceObjectAtIndex:page withObject:controller];
        
    }
    
    if (controller.superview == nil)
    {
        CGRect frame = self.scrollview.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        controller.frame = frame;
        [self.scrollview addSubview:controller];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    if (self.canMoveWithGesture) {
        return;
    }
    CGFloat pageWidth = self.scrollview.frame.size.width;
    int page = floor((self.scrollview.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    if (self.scrollview.contentOffset.x>=960) {
        [self.views[3] startAnimation];
    }else if (self.scrollview.contentOffset.x>=640) {
        [self.views[2] startAnimation];
    }else if (self.scrollview.contentOffset.x>=320) {
        [self.views[1] startAnimation];
    }
    [self loadScrollViewWithPage:page+1];
}

-(void)startAnimation{
    self.scrollview.userInteractionEnabled=NO;
    self.scrollview.scrollEnabled=NO;
}

-(void)endAnimation{
    self.scrollview.userInteractionEnabled=YES;
    self.scrollview.scrollEnabled=YES;
}
@end

