//
//  SinglePickerView.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-30.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "SinglePickerView.h"

@implementation SinglePickerView
@synthesize selectStr;
- (id)initWithTitle:(CGRect)frame title:(NSString *)title Arr:(NSMutableArray *)Arr delegate:(id)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        dataArr = Arr;
        self.delegate = delegate;
        UIImageView *topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        [topView setBackgroundColor: [UIColor colorWithRed:(245/255.0)  green:(245/255.0)  blue:(252/255.0)  alpha:1.0]];
        [self addSubview:topView];
        
        pickerview = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, 320, self.frame.size.height-44)];
        [pickerview setBackgroundColor:[UIColor whiteColor]];
        pickerview.delegate = self;
        pickerview.dataSource = self;
        pickerview.showsSelectionIndicator = YES; //显示选中框
        [self addSubview:pickerview];
        [pickerview selectRow:0 inComponent:0 animated:NO];
        [self selectIndex:0];
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
    [self.layer addAnimation:animation forKey:@"SingleView"];
    
    self.frame = CGRectMake(0, view.frame.size.height - self.frame.size.height, self.frame.size.width, self.frame.size.height);
    
    [view addSubview:self];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	
    return dataArr.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [dataArr objectAtIndex:row];
}

-(void)cancelClick{
    CATransition *animation = [CATransition  animation];
    animation.delegate = self;
    animation.duration = 0.3;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromBottom;
    [self setAlpha:0.0f];
    [self.layer addAnimation:animation forKey:@"SingleView"];
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.3];
    if(self.delegate) {
        [self.delegate actionSheet:self clickedButtonAtIndex:0];
    }
}

-(void)complatedClick{
    CATransition *animation = [CATransition  animation];
    animation.delegate = self;
    animation.duration = 0.3;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromBottom;
    [self setAlpha:0.0f];
    [self.layer addAnimation:animation forKey:@"SingleView"];
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.3];
    if(self.delegate) {
        [self.delegate actionSheet:self clickedButtonAtIndex:1];
    }
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self selectIndex:row];
}

- (void)selectIndex:(NSInteger)index {
    self.selectStr = [dataArr objectAtIndex:index];
}
@end
