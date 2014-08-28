//
//  DatePickerView.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-27.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface DatePickerView : UIActionSheet{
    UIDatePicker *datepicker;
    NSString *timeSp;
}
@property(retain,nonatomic)NSString *timeSp;
@property (nonatomic,retain) UIDatePicker *datepicker;
- (id)initWithTitle:(CGRect)frame delegate:(id /*<UIActionSheetDelegate>*/)delegate date:(NSDate *)date;
- (void)showInView:(UIView *)view;
@end
