//
//  ISRViewController.m
//  MSCDemo
//
//  Created by iflytek on 13-6-6.
//  Copyright (c) 2013年 iflytek. All rights reserved.
//

#import "UnderstandViewController.h"
#import "Definition.h"
#import "UIPlaceHolderTextView.h"
#import "PopupView.h"
#import "ResultsTableViewController.h"
#import "RecordSqlite.h"
#import <iflyMSC/iflyMSC.h>
#import "ISRDataHelper.h"
#import <AVFoundation/AVAudioSession.h>
#import "HomePageViewController.h"
#import "AppDelegate.h"

@implementation UnderstandViewController
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
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(85, kScreenHeight-149, 149, 149)];
    imageView.image = image;
    [self.view addSubview:imageView];
    
    button = [[DKCircleButton alloc] initWithFrame:CGRectMake(0, 0, 140, 140)];
    button.center = imageView.center;
    button.titleLabel.font = [UIFont systemFontOfSize:22];
    [button setBorderColor:[UIColor clearColor]];
    [button setBackgroundImage:[GetImagePath getImagePath:@"语音搜索1_05"] forState:UIControlStateNormal];
    [button setBackgroundImage:[GetImagePath getImagePath:@"语音搜索1_05"] forState:UIControlStateSelected];
    [button setBackgroundImage:[GetImagePath getImagePath:@"语音搜索1_05"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(startListening) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [resultView setNeedsDisplay];
    
    //1.创建语音听写对象
    self.speechUnderstander = [IFlySpeechRecognizer sharedInstance]; //设置听写模式
    //2.设置听写参数
    [self.speechUnderstander setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
    [self.speechUnderstander setParameter:@"0" forKey:[IFlySpeechConstant ASR_PTT]];
    
    //asr_audio_path是录音文件名,设置value为nil或者为空取消保存,默认保存目录在 Library/cache下。
    [self.speechUnderstander setParameter:nil forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
    self.speechUnderstander.delegate = self;
    
    if ([[AVAudioSession sharedInstance] respondsToSelector:@selector(requestRecordPermission:)]) {
        [[AVAudioSession sharedInstance] performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
            if (granted) {
                [self startListening];
                button.enabled = YES;
            }else {
                label.text =@"请打开麦克风";
                button.enabled = NO;                
            }
        }];
    };
}

-(void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarHide];
}

-(void)viewWillDisappear:(BOOL)animated{
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarRestore];
    [self stopListening];
}

- (void)startListening{
    if (self.speechUnderstander.isListening) return;
    self.textView.text = @"";
    if ([self.speechUnderstander startListening]) {
        timer = [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(circleBtn) userInfo:nil repeats:YES];
        label.hidden = NO;
        label.text = @"正在接收中...";
    }
}

- (void)stopListening{
    [self.speechUnderstander stopListening];
    [timer invalidate];
    timer =nil;
}

-(void)circleBtn{
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
        [self.navigationController pushViewController:resultVC animated:YES];
    }else{
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"未识别出语音，请重试！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
    }
}

- (void) onResults:(NSArray *) results isLast:(BOOL)isLast{
    [timer invalidate];
    label.hidden =YES;
    
    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSDictionary *dic = results[0];
    for (NSString *key in dic) {
        [resultString appendFormat:@"%@",key];
    }
    _result =[NSString stringWithFormat:@"%@%@", _textView.text,resultString];
    NSString * resultFromJson =  [ISRDataHelper stringFromJson:resultString];
    self.textView.text = [NSString stringWithFormat:@"%@%@", _textView.text,resultFromJson];
}

- (void) onError:(IFlySpeechError *) errorCode{
    NSLog(@"***%@",errorCode.errorDesc);
}
@end
