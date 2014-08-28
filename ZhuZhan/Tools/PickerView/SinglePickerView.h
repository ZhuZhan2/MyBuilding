//
//  SinglePickerView.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-30.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SinglePickerView : UIActionSheet<UIPickerViewDelegate, UIPickerViewDataSource>{
    UIPickerView *pickerview;
    NSMutableArray *dataArr;
    NSString *selectStr;
}
@property(retain,nonatomic)NSString *selectStr;
- (id)initWithTitle:(CGRect)frame title:(NSString *)title Arr:(NSArray *)Arr delegate:(id /*<UIActionSheetDelegate>*/)delegate;
- (void)showInView:(UIView *)view;
@end
