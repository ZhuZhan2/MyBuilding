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

    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 5, 29, 28.5)];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"icon_04.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    //RightButton设置属性
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, 50, 19.5)];
    [rightButton setTitle:@"清空" forState:UIControlStateNormal];
    rightButton.titleLabel.textColor = [UIColor whiteColor];
    [rightButton addTarget:self action:@selector(clearAll) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    self.title = @"发布";


    
    
    inputView =[[UITextView alloc] initWithFrame:CGRectZero];
    inputView.delegate = self;
    inputView.backgroundColor = [UIColor greenColor];
    
    [self.view addSubview:inputView];
    
    toolBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    [self.view addSubview:toolBar];
    toolBar.backgroundColor = [UIColor redColor];
    
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
    toolBar.frame =CGRectMake(0, kScreenHeight-height-40, 320, 40);
    toolBar.backgroundColor = [UIColor redColor];
    inputView.frame =CGRectMake(0, 0, 320, kContentHeight-height);
    
    

    
}

-(void)publshText
{
    NSLog(@"发布文字信息");

}

-(void)publshPhoto{
  NSLog(@"发布图片信息");
}

-(void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clearAll
{

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
