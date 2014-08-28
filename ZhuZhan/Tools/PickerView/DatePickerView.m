//
//  DatePickerView.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-27.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "DatePickerView.h"

@implementation DatePickerView
@synthesize datepicker;
@synthesize timeSp;
- (id)initWithTitle:(CGRect)frame delegate:(id /*<UIActionSheetDelegate>*/)delegate date:(NSDate *)date{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.delegate = delegate;
        [self setBackgroundColor:[UIColor whiteColor]];
        UIImageView *topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        [topView setBackgroundColor:[UIColor colorWithRed:(245/255.0)  green:(245/255.0)  blue:(252/255.0)  alpha:1.0]];
        [self addSubview:topView];
        
        datepicker = [ [ UIDatePicker alloc] initWithFrame:CGRectMake(0, 44, 320, self.frame.size.height-44)];
        datepicker.datePickerMode = UIDatePickerModeDate;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate* minDate = [dateFormatter dateFromString:@"1900-01-01 00:00:00"];
        NSDate* maxDate = [dateFormatter dateFromString:@"2900-01-01 00:00:00"];
        datepicker.minimumDate = minDate;
        datepicker.maximumDate = maxDate;
        if(date != nil){
            datepicker.date = date;
        }
        [self addSubview:datepicker];
        
        UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
        cancel.frame = CGRectMake(10,7, 66.5, 29);
        [cancel setBackgroundImage:[UIImage imageNamed:@"controls_03.png"] forState:UIControlStateNormal];
        //[cancel setTitle:@"取消" forState:UIControlStateNormal];
        //[cancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancel addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancel];
        
        UIButton *complated = [UIButton buttonWithType:UIButtonTypeCustom];
        complated.frame = CGRectMake(240,7, 66.5, 29);
        [complated setBackgroundImage:[UIImage imageNamed:@"controls_05.png"] forState:UIControlStateNormal];
        //[complated setTitle:@"完成" forState:UIControlStateNormal];
        //[complated setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [complated addTarget:self action:@selector(complatedClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:complated];
        
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)showInView:(UIView *) view
{
    CATransition *animation = [CATransition  animation];
    animation.delegate = self;
    animation.duration = 0.3;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromTop;
    [self setAlpha:1.0f];
    [self.layer addAnimation:animation forKey:@"DatePicker"];
    
    self.frame = CGRectMake(0, view.frame.size.height - self.frame.size.height, self.frame.size.width, self.frame.size.height);
    [view addSubview:self];
}

-(void)cancelClick{
    CATransition *animation = [CATransition  animation];
    animation.delegate = self;
    animation.duration = 0.3;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromBottom;
    [self setAlpha:0.0f];
    [self.layer addAnimation:animation forKey:@"DatePicker"];
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.3];
    if(self.delegate) {
        [self.delegate actionSheet:self clickedButtonAtIndex:0];
    }
}

-(void)complatedClick{
    NSDate* _date = datepicker.date;
    NSLog(@"%@",_date);
    timeSp = [NSString stringWithFormat:@"%ld", (long)[_date timeIntervalSince1970]];
    CATransition *animation = [CATransition  animation];
    animation.delegate = self;
    animation.duration = 0.3;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromBottom;
    [self setAlpha:0.0f];
    [self.layer addAnimation:animation forKey:@"DatePicker"];
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.3];
    if(self.delegate) {
        [self.delegate actionSheet:self clickedButtonAtIndex:1];
    }
}
@end
