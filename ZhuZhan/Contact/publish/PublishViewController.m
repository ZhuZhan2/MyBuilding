//
//  PublishViewController.m
//  ZhuZhan
//
//  Created by Jack on 14-8-27.
//
//

#import "PublishViewController.h"

@interface PublishViewController ()

@end

@implementation PublishViewController
@synthesize toolBar,inputView;
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

    self.navigationController.navigationBar.alpha =0;
    UINavigationBar *tabBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 64.5)];
    [tabBar setBackgroundImage:[UIImage imageNamed:@"地图搜索_01.png"] forBarMetrics:UIBarMetricsDefault];
    [self.view addSubview:tabBar];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    titleLabel.center =CGPointMake(160, 40);
    titleLabel.text = @"发布动态";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:19];
    [tabBar addSubview:titleLabel];
    
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    backBtn.frame = CGRectMake(0, 20, 40, 40);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back_icon"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backToFormerVC) forControlEvents:UIControlEventTouchUpInside];
    [tabBar addSubview:backBtn];
    
    UIButton *publishBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [publishBtn setTitle:@"清空" forState:UIControlStateNormal];
    publishBtn.titleLabel.textColor = [UIColor whiteColor];
    publishBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    publishBtn.frame = CGRectMake(250, 20, 60, 40);
    [publishBtn addTarget:self action:@selector(publish) forControlEvents:UIControlEventTouchUpInside];
    [tabBar addSubview:publishBtn];

    
    
    inputView =[[UITextView alloc] initWithFrame:CGRectMake(0, 64.5, 320, 200)];
    inputView.delegate = self;
    inputView.backgroundColor = [UIColor greenColor];
    
    [self.view addSubview:inputView];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:UIKeyboardWillShowNotification object:nil];
    
    [inputView becomeFirstResponder];
    
    
    

}

-(void)viewWillAppear:(BOOL)animated
{
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];

}

- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    NSLog(@"%d",height);
    toolBar = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-height-40, 320, 40)];
    [self.view addSubview:toolBar];
    
    UIButton *textBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    textBtn.frame = CGRectMake(0, 0, 160, 40);
    [textBtn setBackgroundImage:[UIImage imageNamed:@"textBtnIcon"] forState:UIControlStateNormal];
    [textBtn addTarget:self action:@selector(publshText) forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:textBtn];
    
    UIButton *photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    photoBtn.frame = CGRectMake(160, 0, 160, 40);
    [photoBtn setBackgroundImage:[UIImage imageNamed:@"photoBtnIcon"] forState:UIControlStateNormal];
    [photoBtn addTarget:self action:@selector(publshPhoto) forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:photoBtn];


    
}

-(void)publshText
{
    NSLog(@"发布文字信息");

}

-(void)publshPhoto{
  NSLog(@"发布图片信息");
}

-(void)backToFormerVC
{
    self.navigationController.navigationBar.alpha =1;
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
