//
//  PanViewController.m
//  ZhuZhan
//
//  Created by Jack on 14-8-28.
//
//

#import "ShowViewController.h"
@interface ShowViewController ()

@end

@implementation ShowViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView  *tempImageView= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 280, 300)];
    tempImageView.image = [GetImagePath getImagePath:@"bg001"];
    [self.view addSubview:tempImageView];
    
    
    EGOImageView *icon = [[EGOImageView alloc] initWithPlaceholderImage:[GetImagePath getImagePath:@"人脉_29a"]];
    icon.frame = CGRectMake(107.5, 50, 65, 65);
    icon.layer.cornerRadius = 32.5;//设置那个圆角的有多圆
    icon.layer.masksToBounds = YES;
    icon.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%s%@",serverAddress,self.iconUrl]];
    icon.userInteractionEnabled = YES;
    [tempImageView addSubview:icon];
    
    UIButton *visitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    visitBtn.frame =CGRectMake(107.5, 50, 65, 65);
    [visitBtn addTarget:self action:@selector(beginToVisitDetail) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:visitBtn];
    
    
    UILabel *userName = [[UILabel alloc] initWithFrame:CGRectMake(0, 115, 280, 40)];
    userName.textAlignment = NSTextAlignmentCenter;
    userName.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:18];
    userName.text = self.userNameStr;
    userName.textColor = [UIColor whiteColor];
    [tempImageView addSubview:userName];
    
    UILabel *message = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 30)];
    message.center = CGPointMake(110, 150);
    message.textAlignment = NSTextAlignmentCenter;
    message.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:12];
    message.textColor = [UIColor whiteColor];
    [tempImageView addSubview:message];
    

    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(90, 200, 100, 25)];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.9;
    bgView.layer.cornerRadius = 5;//设置那个圆角的有多圆
    bgView.layer.masksToBounds = YES;//设为NO去试试。设置YES是保证添加的图片覆盖视图的效果
    //[tempImageView addSubview:bgView];
    
    UIButton *concernBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    concernBtn.frame = CGRectMake(90, 200, 100, 25);
    [concernBtn setTitle:@"添加关注" forState:UIControlStateNormal];
    concernBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [concernBtn addTarget:self action:@selector(gotoConcern) forControlEvents:UIControlEventTouchUpInside];
    //[tempImageView addSubview:concernBtn];
    
}




-(void)viewWillDisappear:(BOOL)animated{
//    conFriendTableView =nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)beginToVisitDetail{
    if([self.delegate respondsToSelector:@selector(gotoContactDetailView)]){
        [self.delegate gotoContactDetailView];
    }
}

- (void)gotoConcern{
    if([self.delegate respondsToSelector:@selector(addfocus)]){
        [self.delegate addfocus];
    }
}

@end
