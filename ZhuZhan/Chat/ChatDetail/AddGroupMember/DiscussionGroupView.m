//
//  DiscussionGroupView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/10.
//
//

#import "DiscussionGroupView.h"

@interface DiscussionGroupView ()
@property(nonatomic,strong)UIView* mainView;
@property(nonatomic,strong)UILabel* mainLabel;

@property(nonatomic,copy)NSString* title;
@property(nonatomic,strong)NSMutableArray* array;
@property(nonatomic)BOOL newNotificaiton;

@property(nonatomic,weak)id<DiscussionGroupViewDelegate>delegate;
@end

#define titleFont [UIFont systemFontOfSize:16]
#define editBtnFont [UIFont systemFontOfSize:22]
#define newNotificationFont [UIFont systemFontOfSize:22]
#define memberNameFont [UIFont systemFontOfSize:22]

@implementation DiscussionGroupView
+(DiscussionGroupView*)discussionGroupViewWithTitle:(NSString*)title members:(NSArray*)members newNotification:(BOOL)newNotificaiton delegate:(id<DiscussionGroupViewDelegate>)delegate{
    DiscussionGroupView* view=[[DiscussionGroupView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    view.title=title;
    view.array=[members mutableCopy];
    view.newNotificaiton=newNotificaiton;
    view.delegate=delegate;
    
    view.backgroundColor=[[UIColor alloc]initWithRed:0 green:0 blue:0 alpha:.5];
    
    [view setUp];
    return view;
}

-(void)setUp{
    [self addTarget:self action:@selector(removeFromSuperview) forControlEvents:UIControlEventTouchUpInside];
    [self initMainView];
    [self initFirstView];
    [self initSecondView];
    [self initThirdView];
    [self initFourthView];
}

-(void)initMainView{
    self.mainView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 275, 350)];
    self.mainView.backgroundColor=[UIColor whiteColor];
    self.mainView.center=CGPointMake(self.center.x, 94+CGRectGetHeight(self.mainView.frame)*0.5);
    self.mainView.layer.cornerRadius=5;
    [self addSubview:self.mainView];
}

-(void)initFirstView{
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.mainView.frame), 38)];
    self.mainLabel=[[UILabel alloc]initWithFrame:CGRectMake(19, 14, 200, 20)];
    self.mainLabel.font=titleFont;
    self.mainLabel.text=self.title;
    [view addSubview:self.mainLabel];
    
    UIButton* btn=[UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"编辑" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(editBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    btn.frame=CGRectMake(225, 14, 30, 20);
    btn.titleLabel.font=editBtnFont;
    
    [self.mainView addSubview:view];
}

-(void)initSecondView{
    
}

-(void)initThirdView{
    
}

-(void)initFourthView{
    
}

-(void)editBtnClicked{
    NSLog(@"编辑");
}
@end

@implementation DiscussionGroupModel
@end