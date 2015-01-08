//
//  RecommendLetterViewController.m
//  ZhuZhan
//
//  Created by Jack on 14-8-29.
//
//

#import "RecommendLetterViewController.h"

@interface RecommendLetterViewController ()

@end

@implementation RecommendLetterViewController

@synthesize iconImageView,themeField,contentView;
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
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont fontWithName:@"GurmukhiMN-Bold" size:19], NSFontAttributeName,
                                                                     nil]];
    
    //LeftButton设置属性
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 29, 28.5)];
    [leftButton setBackgroundImage:[GetImagePath getImagePath:@"013"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    self.title = @"引荐信";
    
    iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 74.5, 40, 40)];//用户头像
    iconImageView.image = [GetImagePath getImagePath:@"1"];
    [self.view addSubview:iconImageView];
    themeField = [[UITextField alloc] initWithFrame:CGRectMake(60, 74.5, 250, 40)];
    themeField.borderStyle =UITextBorderStyleNone;
    themeField.delegate =self;
    [self.view addSubview:themeField];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(60, 113.5, 250, 1)];
    line.backgroundColor = [UIColor blackColor];
    line.alpha =0.5;
    [self.view addSubview:line];
    
    contentView = [[UITextView alloc] initWithFrame:CGRectMake(10, 130, 300, 210)];
    contentView.delegate = self;
    contentView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:contentView];
    

}

-(void)viewWillAppear:(BOOL)animated
{
    [themeField becomeFirstResponder];
}

-(void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)textViewDidEndEditing:(UITextView *)textView{

    NSLog(@"contentView结束编辑");
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
