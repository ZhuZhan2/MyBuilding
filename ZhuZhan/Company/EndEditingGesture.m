//
//  EndEditingGesture.m
//  ZhuZhan
//
//  Created by 孙元侃 on 14/10/28.
//
//

#import "EndEditingGesture.h"

@implementation EndEditingGesture
+(void)addGestureToView:(UIView*)view{
    UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]initWithTarget:view action:@selector(endEditing:)];
    [view addGestureRecognizer:tap];
}
@end
