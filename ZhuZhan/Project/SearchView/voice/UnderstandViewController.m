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
#import "RecordSqlite.h"
#import <AVFoundation/AVAudioSession.h>

@implementation UnderstandViewController

static int timeCount =0;
static bool startListen =YES;
- (instancetype) init
{
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //LeftButton设置属性
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 25, 22)];
    [leftButton setBackgroundImage:[GetImagePath getImagePath:@"013"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    //RightButton设置属性
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, 30, 30)];
    [rightButton setBackgroundImage:[GetImagePath getImagePath:@"icon__09"] forState:UIControlStateNormal];
    rightButton.titleLabel.textColor = [UIColor whiteColor];
    [rightButton addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    self.title = @"语音搜索";
    
    
    UIPlaceHolderTextView *resultView = [[UIPlaceHolderTextView alloc] initWithFrame:
                                         CGRectMake(Margin*2, Margin*2+3.5, self.view.frame.size.width-Margin*4, 300)];
    resultView.layer.cornerRadius = 8;
    [self.view addSubview:resultView];
    resultView.font = [UIFont systemFontOfSize:25.0f];
    resultView.editable = NO;
    resultView.layer.borderWidth = 0;
    _textView = resultView;
    _textView.text =@"";
    label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 160, 40)];
    label.font = [UIFont systemFontOfSize:25.0f];
    label.textColor = [UIColor colorWithRed:(151/255.0)  green:(151/255.0)  blue:(151/255.0)  alpha:1.0];
    [resultView addSubview:label];
    UIImage *image = [GetImagePath getImagePath:@"语音搜索_04"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(90, kScreenHeight-149, 149, 149)];
    imageView.image = image;
    [self.view addSubview:imageView];
    button = [[DKCircleButton alloc] initWithFrame:CGRectMake(0, 0, 140, 140)];
    button.center = imageView.center;
    button.titleLabel.font = [UIFont systemFontOfSize:22];
    [button setBorderColor:[UIColor clearColor]];
    
    
    
    [button setBackgroundImage:[GetImagePath getImagePath:@"语音搜索1_05"] forState:UIControlStateNormal];
    [button setBackgroundImage:[GetImagePath getImagePath:@"语音搜索1_05"] forState:UIControlStateSelected];
    [button setBackgroundImage:[GetImagePath getImagePath:@"语音搜索1_05"] forState:UIControlStateHighlighted];
    
    [button addTarget:self action:@selector(startListening1) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    [resultView setNeedsDisplay];
    
    _iFlySpeechUnderstander = [IFlySpeechUnderstander sharedInstance];
    _iFlySpeechUnderstander.delegate = self;
    if ([[AVAudioSession sharedInstance] respondsToSelector:@selector(requestRecordPermission:)]) {
        [[AVAudioSession sharedInstance] performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
            if (granted) {
                // Microphone enabled code
                NSLog(@"Microphone is enabled..");
                [self startListening1];
                button.enabled = YES;
            }
            else {
                // Microphone disabled code
                NSLog(@"Microphone is disabled..");
                label.text =@"请打开麦克风";
                button.enabled = NO;
                // We're in a background thread here, so jump to main thread to do UI work.
                
            }
        }];
    };
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
        startListen = YES;
    [timer invalidate];
    [_iFlySpeechUnderstander stopListening];
    timer =nil;
    timeCount =0;
    //设置回非语义识别
    [_iFlySpeechUnderstander destroy];
}

- (void)startListening1
{
    
    NSLog(@"nnn******%u",startListen);
    if (startListen ==YES) {
        _textView.text =@"";
        bool ret = [_iFlySpeechUnderstander startListening];
        
        if (ret) {
            timer = [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(circleBtn) userInfo:nil repeats:YES];
            startListen =NO;
            label.hidden =NO;
            label.text =@"正在接收中...";
        }
        else
        {
            [_popView setText: @"启动识别服务失败，请稍后重试"];//可能是上次请求未结束
            [self.view addSubview:_popView];
            startListen =NO;
        }
        
        
    }
    
}

-(void)circleBtn
{
    
    [button blink];
}


- (void)rightAction{
    if(![[ _textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]){
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *time = [dateFormatter stringFromDate:[NSDate date]];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:_textView.text forKey:@"name"];
        [dic setValue:time forKey:@"time"];
        [RecordSqlite InsertData:dic];
        
        ResultsTableViewController *resultVC = [[ResultsTableViewController alloc] init];
        resultVC.searchStr = _textView.text;
        NSLog(@"***resultVC.searchStr****%@",_textView.text);
        [self.navigationController pushViewController:resultVC animated:YES];
    }
}




#pragma mark - IFlySpeechRecognizerDelegate


- (void) onResults:(NSArray *) results isLast:(BOOL)isLast
{
    [_iFlySpeechUnderstander stopListening];
    [timer invalidate];
    label.hidden =YES;
    timeCount++;
    if (timeCount==2) {
        timeCount=0;
        return;
    }
    startListen = YES;
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
    str =  [str stringByReplacingOccurrencesOfString:@"？" withString:@""];
    str =  [str stringByReplacingOccurrencesOfString:@"，" withString:@""];
    if (![str isEqualToString:@""]) {
        _textView.text =str;
    }
    
    
    
}

- (void) onError:(IFlySpeechError *) errorCode{
    NSLog(@"***%@",errorCode);
}

@end
