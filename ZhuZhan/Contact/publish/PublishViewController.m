//
//  PublishViewController.m
//  ZhuZhan
//
//  Created by Jack on 14-8-27.
//
//

#import "PublishViewController.h"
#import "AppDelegate.h"
#import "HomePageViewController.h"

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


    
    
    inputView = [[UITextView alloc] initWithFrame:CGRectMake(10, 80, 300, kScreenHeight-40-100)];
    inputView.delegate = self;
    inputView.editable =NO;
//    inputView.backgroundColor = [UIColor redColor];
    inputView.returnKeyType = UIReturnKeySend;

    inputView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    [self.view addSubview:inputView];

    
    toolBar = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-40, 320, 40)];
    toolBar.backgroundColor = [UIColor blackColor];
    toolBar.alpha =0.5;
    [self.view addSubview:toolBar];


    UIButton *textBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    textBtn.frame = CGRectMake(0, 0, 158, 40);

    [textBtn setTitle:@"想说些什么..." forState:UIControlStateNormal];
    [textBtn setImage:[UIImage imageNamed:@"人脉－发布动态_09a"] forState:UIControlStateNormal];
    [textBtn setImage:[UIImage imageNamed:@"人脉－发布动态_07a"] forState:UIControlStateSelected];
    
    [textBtn addTarget:self action:@selector(publshText) forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:textBtn];
    
    UIButton *photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    photoBtn.frame = CGRectMake(162, 0, 160, 40);

    [photoBtn setTitle:@"产品信息     " forState:UIControlStateNormal];
    [photoBtn setImage:[UIImage imageNamed:@"人脉－发布动态_13a"] forState:UIControlStateNormal];
    [photoBtn addTarget:self action:@selector(publshPhoto) forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:photoBtn];


    

}

-(void)viewWillAppear:(BOOL)animated
{
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
[inputView addObserver:self forKeyPath:@"contentSize"options:NSKeyValueObservingOptionNew context:nil];//也可以监听contentSize属性
    
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarHide];

}

-(void)viewDidDisappear:(BOOL)animated
{

    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarRestore];
}

- (void)keyboardWillShow:(NSNotification *)aNotification//获取键盘的高度条横tool和inputView的frame
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat height = keyboardRect.size.height;
    NSLog(@"%lf",height);
    toolBar.frame =CGRectMake(0, kScreenHeight-height-40, 320, 40);
    inputView.frame = CGRectMake(10, 80, 300, kScreenHeight-height-40-100);
}



//接收处理
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"keyPath  ***%@",keyPath);
    NSLog(@"change ***%@",change);
    NSLog(@"context   ***%@",context);
    
    CGFloat topCorrect = ([inputView bounds].size.height - [inputView contentSize].height);
    
    topCorrect = (topCorrect <0.0 ?0.0 : topCorrect);
    
    inputView.contentOffset = (CGPoint){.x =0, .y = -topCorrect/2};
    
}

-(void)publshText
{
    NSLog(@"发布文字信息");
        inputView.editable =YES;
    [inputView becomeFirstResponder];

}

-(void)publshPhoto{
  NSLog(@"发布图片信息");
}

-(void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)clearAll
{
    inputView.text =nil;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text; {
    
    if ([@"\n" isEqualToString:text] == YES) { //发送的操作
            inputView.editable =NO;
        [inputView resignFirstResponder];
        toolBar.frame =CGRectMake(0, kScreenHeight-40, 320, 40);
        inputView.frame = CGRectMake(10, 80, 300, kScreenHeight-40-100);
        return NO;
        
    }
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{

    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f)
    {
        CGRect line = [textView caretRectForPosition:
                       textView.selectedTextRange.start];
        CGFloat overflow = line.origin.y + line.size.height
        - ( textView.contentOffset.y + textView.bounds.size.height
           - textView.contentInset.bottom - textView.contentInset.top);
        if ( overflow > 0 ) {
            // We are at the bottom of the visible text and introduced a line feed, scroll down (iOS 7 does not do it)
            // Scroll caret to visible area
            CGPoint offset = textView.contentOffset;
            offset.y += overflow + 7; // leave 7 pixels margin
            // Cannot animate with setContentOffset:animated: or caret will not appear
            [UIView animateWithDuration:.2 animations:^{
                [textView setContentOffset:offset];
            }];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
