//
//  FirstAnimationViewController.m
//  AnimationDemo
//
//  Created by 孙元侃 on 14/12/8.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import "FirstAnimationViewController.h"
#import "FirstAnimationView.h"
#import "SecondAnimationView.h"
#import "ThirdAnimationView.h"
#import "FourthAnimationView.h"
@interface FirstAnimationViewController ()<UIScrollViewDelegate,AnimationDelegate>
@property (nonatomic, strong) NSMutableArray *views;
@property (nonatomic, strong) NSMutableArray *views2;
@property(nonatomic,strong) FirstAnimationView *main;
@property(nonatomic,strong)SecondAnimationView *first;
@property(nonatomic,strong)ThirdAnimationView *second;
@property(nonatomic,strong)FourthAnimationView *third;
@property (nonatomic, assign) BOOL canMoveWithGesture;

@end

@implementation FirstAnimationViewController
//static int j;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.canMoveWithGesture=NO;
    self.scrollview=[[UIScrollView alloc]initWithFrame:self.view.frame];
    self.scrollview.contentSize=CGSizeMake(320*2, 568);
    self.scrollview.pagingEnabled=YES;
    self.scrollview.delegate = self;
    self.scrollview.showsHorizontalScrollIndicator=NO;
    self.scrollview.userInteractionEnabled=NO;
    [self.view addSubview:self.scrollview];
    
    self.views = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < 4; i++)
    {
        [self.views addObject:[NSNull null]];
    }
    
    [self loadScrollViewWithPage:0];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setBoolen) name:@"addbool" object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notMove) name:@"notMove" object:nil];
}

-(void)notMove{
    self.scrollview.userInteractionEnabled=NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)loadScrollViewWithPage:(int)page
{
    if (page < 0)
        return;
    if (page >= 4)
        return;
    
    // replace the placeholder if necessary
    UIView *controller = [self.views objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null])
    {
        if(page == 0){
            controller = [[FirstAnimationView alloc] initWithFrame:self.view.frame];
        }else if(page == 1){
            controller = [[SecondAnimationView alloc] initWithFrame:self.view.frame];
        }else if(page == 2){
            controller = [[ThirdAnimationView alloc] initWithFrame:self.view.frame];
        }else{
            controller = [[FourthAnimationView alloc] initWithFrame:self.view.frame];
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
    NSLog(@"%d",page);
    if (self.scrollview.contentOffset.x>=960) {
        [self.views[3] startAnimation];
    }else if (self.scrollview.contentOffset.x>=640) {
        [self.views[2] startAnimation];
    }else if (self.scrollview.contentOffset.x>=320) {
        [self.views[1] startAnimation];
    }
    NSLog(@"%f",self.scrollview.contentOffset.x);
    [self loadScrollViewWithPage:page+1];
}

-(void)startAnimation{
    self.scrollview.userInteractionEnabled=NO;
}

-(void)endAnimation{
    self.scrollview.userInteractionEnabled=YES;
}

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.view.backgroundColor=[UIColor whiteColor];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setBoolen) name:@"addbool" object:nil];
//    j=0;
//    self.canMoveWithGesture = NO;
//    self.views = [[NSMutableArray alloc] init];
//    self.views2 = [[NSMutableArray alloc] init];
//    UIPanGestureRecognizer *panGestureRec = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveViewWithGesture:)];
//    [self.view addGestureRecognizer:panGestureRec];
//    
//    [self.views addObject:@"FirstAnimationView"];
//    [self.views addObject:@"SecondAnimationView"];
//    [self.views addObject:@"ThirdAnimationView"];
//    [self.views addObject:@"FourthAnimationView"];
//    
//    Class c = NSClassFromString(self.views[j]);
//    UIView *tempView = [[c alloc] initWithFrame:self.view.frame];
//    [self.view addSubview:tempView];
//    [self.views2 addObject:tempView];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dismissSelf) name:@"dismis" object:nil];
//}
//
//-(void)dismissSelf{
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//}
//
//- (void)moveViewWithGesture:(UIPanGestureRecognizer *)panGes{
//    if (!_canMoveWithGesture)
//    {
//        return;
//    }else{}
//    static CGFloat currentTranslateX;
//    if (panGes.state == UIGestureRecognizerStateBegan)
//    {
//        currentTranslateX = self.view.transform.tx;
//    }
//    
//    if (panGes.state == UIGestureRecognizerStateEnded){
//        CGFloat transX = [panGes translationInView:self.view].x;
//        transX = transX + currentTranslateX;
//        if ((transX < 0) ){
//            j++;
//            if(j<=3){
//                self.canMoveWithGesture = NO;
//                [self.views2[j-1] removeFromSuperview];
//                Class c = NSClassFromString(self.views[j]);
//                UIView *tempView = [[c alloc] initWithFrame:self.view.frame];
//                [self.view addSubview:tempView];
//                [self.views2 addObject:tempView];
//            }
//        }
//    }
//}
//
//-(void)setBoolen{
//    self.canMoveWithGesture = YES;
//}
@end
