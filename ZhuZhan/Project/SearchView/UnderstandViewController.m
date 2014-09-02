//
//  ISRViewController.m
//  MSCDemo
//
//  Created by iflytek on 13-6-6.
//  Copyright (c) 2013年 iflytek. All rights reserved.
//

#import "UnderstandViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "iflyMSC/IFlyContact.h"
#import "iflyMSC/IFlyDataUploader.h"
#import "Definition.h"
#import "iflyMSC/IFlyUserWords.h"
#import "RecognizerFactory.h"
#import "UIPlaceHolderTextView.h"
#import "iflyMSC/IFlySpeechUtility.h"
#import "iflyMSC/IFlySpeechUnderstander.h"
#import "PopupView.h"
#import "ResultsTableViewController.h"
#import "HomePageViewController.h"
#import "AppDelegate.h"
#import "JSONKit.h"

#define FirstTouch 1
#define SecondTouch 2

@implementation UnderstandViewController


static int touchCount =2;
- (instancetype) init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    _iFlySpeechUnderstander = [IFlySpeechUnderstander sharedInstance];
    _iFlySpeechUnderstander.delegate = self;
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - Button Handler
/*
 * @开始录音
 */
//- (void) onBtnStart:(id) sender
//{
//    [_resultView setText:@""];
//    [_resultView resignFirstResponder];
//
//    bool ret = [_iFlySpeechUnderstander startListening];
//    if (ret) {
//        [_startBtn setEnabled:NO];
//        [_cancelBtn setEnabled:YES];
//        [_stopBtn setEnabled:YES];
//        self.isCanceled = NO;
//    }
//    else
//    {
//        [_popUpView setText: @"启动识别服务失败，请稍后重试"];//可能是上次请求未结束
//        [self.view addSubview:_popUpView];
//    }
//    
//}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //    [self addBackButton];
    //    [self addtittle:@"语音搜索"];
    //    [self addRightButton:CGRectMake(280, 20, 29, 28.5) title:nil iamge:[UIImage imageNamed:@"icon__09.png"]];
    //LeftButton设置属性
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 29, 28.5)];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"icon_04.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    //RightButton设置属性
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, 40, 30)];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"icon__09"] forState:UIControlStateNormal];
    rightButton.titleLabel.textColor = [UIColor whiteColor];
    [rightButton addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    self.title = @"语音搜索";
    
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if ( IOS7_OR_LATER )
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
        self.navigationController.navigationBar.translucent = NO;
    }
#endif
    
    UIPlaceHolderTextView *resultView = [[UIPlaceHolderTextView alloc] initWithFrame:
                                         CGRectMake(Margin*2, Margin*2+3.5, self.view.frame.size.width-Margin*4, 300)];
    resultView.layer.cornerRadius = 8;
    resultView.layer.borderWidth = 1;
    [self.view addSubview:resultView];
    resultView.font = [UIFont systemFontOfSize:25.0f];
    //    resultView.placeholder = @"识别结果";
    resultView.editable = NO;
    resultView.layer.borderColor = (__bridge CGColorRef)([UIColor clearColor]);
    _textView = resultView;
    _textView.text =@"";
    label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 140, 40)];
    label.font = [UIFont systemFontOfSize:25.0f];
    label.textColor = [UIColor colorWithRed:(151/255.0)  green:(151/255.0)  blue:(151/255.0)  alpha:1.0];
    label.text =@"请开始说话";
    [resultView addSubview:label];
    UIImage *image = [UIImage imageNamed:@"语音搜索_04.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(90, resultView.frame.origin.y+resultView.frame.size.height+40, 149, 149)];
    //    imageView.center = CGPointMake(160, resultView.frame.origin.y+resultView.frame.size.height+60);
    imageView.image = image;
    [self.view addSubview:imageView];
    button = [[DKCircleButton alloc] initWithFrame:CGRectMake(0, 0, 140, 140)];
    button.center = imageView.center;
    button.titleLabel.font = [UIFont systemFontOfSize:22];
    [button setBorderColor:[UIColor clearColor]];
    
    
    
    [button setBackgroundImage:[UIImage imageNamed:@"语音搜索1_05"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"语音搜索1_05"] forState:UIControlStateSelected];
    [button setBackgroundImage:[UIImage imageNamed:@"语音搜索1_05"] forState:UIControlStateHighlighted];
    
    [button addTarget:self action:@selector(startListening1) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    [resultView setNeedsDisplay];
}

-(void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewWillAppear:(BOOL)animated
{
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarHide];
}

-(void)viewWillDisappear:(BOOL)animated
{
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarRestore];
    [_iFlySpeechUnderstander cancel];
    _iFlySpeechUnderstander.delegate = nil;
    //设置回非语义识别
    [_iFlySpeechUnderstander destroy];
}

- (void)startListening1
{
    
    
    touchCount--;
    [button blink];
    label.hidden =NO;
    label.text =@"正在接收中...";
    if (touchCount ==FirstTouch) {
        _textView.text =@"";
        timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(startListening1) userInfo:nil repeats:YES];
        
        bool ret = [_iFlySpeechUnderstander startListening];
        if (ret) {
            
           NSString  *str =  [_textView.text stringByReplacingOccurrencesOfString:@" (置信度:100)\n" withString:@""];
            str =  [str stringByReplacingOccurrencesOfString:@"。" withString:@""];
            str =  [str stringByReplacingOccurrencesOfString:@"！" withString:@""];
            _textView.text =str;
            
            if (![str  isEqual:@""]) {
                label.hidden =YES;
                [timer invalidate];
                [_iFlySpeechUnderstander stopListening];
                _textView.text = str;
                touchCount=2;
                return;
            }
        }
        else
        {
            [_popView setText: @"启动识别服务失败，请稍后重试"];//可能是上次请求未结束
            [self.view addSubview:_popView];
        }
        
        touchCount = touchCount+5;
    }
    else if(touchCount==SecondTouch) {
        label.hidden =YES;
        [timer invalidate];
        [_iFlySpeechUnderstander stopListening];
        return;
    }
    
}


- (void)rightAction{
    
    ResultsTableViewController *resultVC = [[ResultsTableViewController alloc] init];
    NSString *string = [_textView.text stringByReplacingOccurrencesOfString:@"。" withString:@""];
    
    NSLog(@"nijiosdfopskopd   %@",string);
    resultVC.searchStr = string;
    [self.navigationController pushViewController:resultVC animated:YES];
}




#pragma mark - IFlySpeechRecognizerDelegate


- (void) onResults:(NSArray *) results isLast:(BOOL)isLast
{
NSMutableString *resultString = [[NSMutableString alloc] init];
    NSDictionary *dic = results [0];
    NSString *jsonStr=nil;
    for (NSString *key in dic) {
        jsonStr =[NSString stringWithFormat:@"%@",key];
        NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *tempResult  = [data objectFromJSONData];
        NSArray *array = [tempResult objectForKey:@"ws"];
        
        for (NSDictionary *tempDic in array) {
            NSString *tempStr =[[[tempDic objectForKey:@"cw"] objectAtIndex:0] objectForKey:@"w"];
            [resultString appendString:tempStr];
                    NSLog(@"听写wwwwwww结果：%@",resultString);
        }
        
    }
    NSString  *str =  [resultString stringByReplacingOccurrencesOfString:@" (置信度:100)\n" withString:@""];
    str =  [str stringByReplacingOccurrencesOfString:@"。" withString:@""];
    str =  [str stringByReplacingOccurrencesOfString:@"！" withString:@""];
    _textView.text =str;
    
}



@end
