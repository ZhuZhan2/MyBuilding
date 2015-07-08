//
//  ISRViewController.h
//  MSCDemo
//
//  Created by iflytek on 13-6-6.
//  Copyright (c) 2013年 iflytek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iflyMSC/IFlySpeechRecognizerDelegate.h"
#import "DKCircleButton.h"
@class PopupView;
@class IFlySpeechRecognizer;

@interface UnderstandViewController : UIViewController<IFlySpeechRecognizerDelegate>
{
    UILabel *label;
    DKCircleButton *button;
    NSTimer *timer;
}
@property (nonatomic,strong) IFlySpeechRecognizer *speechUnderstander;
@property (nonatomic,strong) PopupView* popView;
@property (nonatomic,weak)   UITextView* textView;
@property (nonatomic,copy) NSString* result;
@end
