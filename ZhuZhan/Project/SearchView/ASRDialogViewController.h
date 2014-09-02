//
//  ASRDialogViewController.h
//  MSCDemo
//
//  Created by junmei on 14-1-20.
//  Copyright (c) 2014年 iflytek. All rights reserved.
//
#import "BaseViewController.h"
#import <UIKit/UIKit.h>
#import "UIPlaceHolderTextView.h"
#import "iflyMSC/IFlyRecognizerViewDelegate.h"
#import "ZCNoneiFLYTEK.h"
@class IFlyRecognizerView;
@class PopupView;
//@class IFlySpeechUnderstander;
#import "iflyMSC.framework/Headers/IFlySpeechUnderstander.h"
/**
 有UI语音识别demo
 */
//@protocol ASRDialogViewControllerDelegate <NSObject>
//
//- (void)getSearchContent:(NSString *)searchContent;
//
//@end
@interface ASRDialogViewController : UIViewController<IFlySpeechRecognizerDelegate>

{

    ZCNoneiFLYTEK *manager;
    UILabel *label;
}
@property (nonatomic,strong) IFlyRecognizerView * iflyRecognizerView;
@property (nonatomic,strong) PopupView          * popView;
@property (nonatomic,weak)   UITextView         * textView;
@property (nonatomic,strong) IFlySpeechUnderstander *iFlySpeechUnderstander;


@end
