//
//  LocateView.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-25.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "LocateView.h"

@implementation LocateView
@synthesize pickerview;
- (id)initWithTitle:(CGRect)frame title:(NSString *)title delegate:(id /*<UIActionSheetDelegate>*/)delegate{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.delegate = delegate;
        UIImageView *topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        [topView setBackgroundColor: [UIColor colorWithRed:(245/255.0)  green:(245/255.0)  blue:(252/255.0)  alpha:1.0]];
        [self addSubview:topView];
        
        self.allCityArray = [[NSMutableArray alloc] initWithCapacity:0];
        self.cityArray = [[NSMutableArray alloc] initWithCapacity:0];
        self.thirdArray = [[NSMutableArray alloc] initWithCapacity:0];
        self.lastChoose = [[NSMutableArray alloc] initWithCapacity:0];
        self.proviceDictionary = [[NSMutableDictionary alloc] initWithCapacity:0];
        
        NSString *path = [[NSBundle mainBundle]pathForResource:@"area" ofType:@"plist"];
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
        for (NSString *key in [dict allKeys]) {
            [self.allCityArray addObject:[dict objectForKey:key]];
        }
        
        pickerview = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, 320, self.frame.size.height-44)];
        [pickerview setBackgroundColor:[UIColor whiteColor]];
        pickerview.delegate = self;
        pickerview.dataSource = self;
        pickerview.showsSelectionIndicator = YES; //显示选中框
        [self addSubview:pickerview];
        [pickerview selectRow:29 inComponent:0 animated:NO];
        [self selectIndex:29];
        [pickerview reloadAllComponents];
        [self.proviceDictionary setObject:@"北京市" forKey:@"provice"];
        [self.proviceDictionary setObject:@"北京市" forKey:@"city"];
        [self.proviceDictionary setObject:@"东城区" forKey:@"county"];
        
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
    [self.layer addAnimation:animation forKey:@"LocateView"];
    
    NSLog(@"%f",view.frame.size.height);
    self.frame=CGRectMake(0, view.frame.size.height-self.frame.size.height, self.frame.size.width, self.frame.size.height);
   // self.frame = CGRectMake(0, view.frame.size.height - self.frame.size.height, self.frame.size.width, self.frame.size.height);
    
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
    [self.layer addAnimation:animation forKey:@"LocateView"];
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.3];
    if(self.delegate) {
        [self.delegate actionSheet:self clickedButtonAtIndex:0];
    }
}

//以下3个方法实现PickerView的数据初始化
//确定picker的轮子个数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 3;
}
//确定picker的每个轮子的item数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	if (component == 0) {
        return self.allCityArray.count;
    }
    if (component == 1) {
        return self.cityArray.count;
    }
    return self.lastChoose.count;
}
//确定每个轮子的每一项显示什么内容
#pragma mark 实现协议UIPickerViewDelegate方法
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	if (component == 0) {
        NSString *key = [[self.allCityArray[row] allKeys] lastObject];
        return key;
    } if (component == 1) {
        return self.cityArray [row];
    }
    return self.lastChoose[row];
}

- (void)selectIndex:(NSInteger)index {
    [self.cityArray removeAllObjects];
    [self.thirdArray removeAllObjects];
    [self.lastChoose removeAllObjects];
    
    NSString *key = [[self.allCityArray[index] allKeys] lastObject];
    NSDictionary *dictCity = [self.allCityArray[index] objectForKey:key];
    for (NSString * k in [dictCity allKeys]) {
        NSDictionary *dict = [dictCity objectForKey:k];
        for (NSString *cityName in [dict allKeys]) {
            [self.cityArray addObject:cityName];
            
            [self.thirdArray addObject:[dict objectForKey:cityName]];
        }
    }
    [self.lastChoose addObjectsFromArray:self.thirdArray[0]];
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0) {
        [self selectIndex:row];
        [pickerView reloadAllComponents];
        [self.proviceDictionary setObject:[[self.allCityArray[row] allKeys] lastObject] forKey:@"provice"];
        [self.proviceDictionary setObject:self.cityArray[0] forKey:@"city"];
        [self.proviceDictionary setObject:self.lastChoose[0] forKey:@"county"];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView selectRow:0 inComponent:2 animated:YES];
    } if (component == 1) {
        [self.lastChoose removeAllObjects];
        [self.lastChoose addObjectsFromArray:self.thirdArray[row]];
        [pickerView reloadComponent:2];
        [self.proviceDictionary setObject:self.cityArray[row] forKey:@"city"];
        [self.proviceDictionary setObject:self.lastChoose[0] forKey:@"county"];
        [pickerView selectRow:0 inComponent:2 animated:NO];
        
    } else if (component == 2){
        [self.proviceDictionary setObject:self.lastChoose[row] forKey:@"county"];
    }
    
    //[self.delegate updateLabel];
    
}

-(void)complatedClick{
    CATransition *animation = [CATransition  animation];
    animation.delegate = self;
    animation.duration = 0.3;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromBottom;
    [self setAlpha:0.0f];
    [self.layer addAnimation:animation forKey:@"LocateView"];
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.3];
    if(self.delegate) {
        [self.delegate actionSheet:self clickedButtonAtIndex:1];
    }
}

@end
