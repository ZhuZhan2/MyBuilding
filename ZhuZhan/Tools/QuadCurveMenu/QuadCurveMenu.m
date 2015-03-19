//
//  QuadCurveMenu.m
//  AwesomeMenu
//
//  Created by Levey on 11/30/11.
//  Copyright (c) 2011 lunaapp.com. All rights reserved.
//

#import "QuadCurveMenu.h"
#import <QuartzCore/QuartzCore.h>
#define Height (kScreenHeight==480?456:544)
#define NEARRADIUS 100.0f
#define ENDRADIUS 110.0f
#define FARRADIUS 160.0f
#define STARTPOINT CGPointMake(160, Height)
#define TIMEOFFSET 0.026f


@interface QuadCurveMenu ()
- (void)_expand;
- (void)_close;
- (CAAnimationGroup *)_blowupAnimationAtPoint:(CGPoint)p;
- (CAAnimationGroup *)_shrinkAnimationAtPoint:(CGPoint)p;
@end

@implementation QuadCurveMenu
@synthesize expanding = _expanding;
@synthesize delegate = _delegate;
@synthesize menusArray = _menusArray;

#pragma mark - initialization & cleaning up
- (id)initWithFrame:(CGRect)frame menus:(NSArray *)aMenusArray
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.bgView = [[UIView alloc] initWithFrame:frame];
        self.bgView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.bgView];
        _menusArray = [aMenusArray copy];
        
        // add the menu buttons
        NSInteger count = [_menusArray count];
        for (int i = 0; i < count; i ++)
        {
            QuadCurveMenuItem *item = [_menusArray objectAtIndex:i];
            item.tag = 1000 + i;
            item.startPoint = STARTPOINT;
            
            if(i == 0){
                //最终停留的坐标
                
                item.endPoint = CGPointMake(STARTPOINT.x + ENDRADIUS * cosf(i * 3.125 / (count - 1))-15, STARTPOINT.y - ENDRADIUS * sinf(i * 3.125 / (count - 1))-50);
                
                //靠近停留坐标的位置
                
                item.nearPoint = CGPointMake(STARTPOINT.x + NEARRADIUS * cosf(i * 3.125 / (count - 1))-15, STARTPOINT.y - NEARRADIUS * sinf(i * 3.125 / (count - 1))-50);
                
                //超过 停留坐标的位置   这些坐标用来做 物体 惯性的  使得动画看起来更自然也更美观
                
                item.farPoint = CGPointMake(STARTPOINT.x + FARRADIUS * cosf(i * 3.125 / (count - 1))-15, STARTPOINT.y - FARRADIUS * sinf(i * 3.125 / (count - 1))-30);
            }else if (i == 1){
                //最终停留的坐标
                
                item.endPoint = CGPointMake(STARTPOINT.x + ENDRADIUS * cosf(i * 3.125 / (count - 1))-24, STARTPOINT.y - ENDRADIUS * sinf(i * 3.125 / (count - 1))-10);
                
                //靠近停留坐标的位置
                
                item.nearPoint = CGPointMake(STARTPOINT.x + NEARRADIUS * cosf(i * 3.125 / (count - 1))-24, STARTPOINT.y - NEARRADIUS * sinf(i * 3.125 / (count - 1))-10);
                
                //超过 停留坐标的位置   这些坐标用来做 物体 惯性的  使得动画看起来更自然也更美观
                
                item.farPoint = CGPointMake(STARTPOINT.x + FARRADIUS * cosf(i * 3.125 / (count - 1))-24, STARTPOINT.y - FARRADIUS * sinf(i * 3.125 / (count - 1))-10);
            }else if (i == 2){
                //最终停留的坐标
                
                item.endPoint = CGPointMake(STARTPOINT.x + ENDRADIUS * cosf(i * 3.125 / (count - 1)), STARTPOINT.y - ENDRADIUS * sinf(i * 3.125 / (count - 1)));
                //item.endPoint = CGPointMake(160, 434);
                
                //靠近停留坐标的位置
                
                item.nearPoint = CGPointMake(STARTPOINT.x + NEARRADIUS * cosf(i * 3.125 / (count - 1)), STARTPOINT.y - NEARRADIUS * sinf(i * 3.125 / (count - 1)));
                //item.nearPoint = CGPointMake(160,464);
                
                //超过 停留坐标的位置   这些坐标用来做 物体 惯性的  使得动画看起来更自然也更美观
                
                item.farPoint = CGPointMake(STARTPOINT.x + FARRADIUS * cosf(i * 3.125 / (count - 1)), STARTPOINT.y - FARRADIUS * sinf(i * 3.125 / (count - 1)));
                //item.farPoint = CGPointMake(160,404);
            }else if(i == 3){
                //最终停留的坐标
                
                item.endPoint = CGPointMake(STARTPOINT.x + ENDRADIUS * cosf(i * 3.125 / (count - 1))+24, STARTPOINT.y - ENDRADIUS * sinf(i * 3.125 / (count - 1))-10);
                
                //靠近停留坐标的位置
                
                item.nearPoint = CGPointMake(STARTPOINT.x + NEARRADIUS * cosf(i * 3.125 / (count - 1))+24, STARTPOINT.y - NEARRADIUS * sinf(i * 3.125 / (count - 1))-10);
                
                //超过 停留坐标的位置   这些坐标用来做 物体 惯性的  使得动画看起来更自然也更美观
                
                item.farPoint = CGPointMake(STARTPOINT.x + FARRADIUS * cosf(i * 3.125 / (count - 1))+24, STARTPOINT.y - FARRADIUS * sinf(i * 3.125 / (count - 1))-10);
            }else if (i == 4){
                //最终停留的坐标
                
                item.endPoint = CGPointMake(STARTPOINT.x + ENDRADIUS * cosf(i * 3.125 / (count - 1))+15, STARTPOINT.y - ENDRADIUS * sinf(i * 3.125 / (count - 1))-50);
                
                //靠近停留坐标的位置
                
                item.nearPoint = CGPointMake(STARTPOINT.x + NEARRADIUS * cosf(i * 3.125 / (count - 1))+15, STARTPOINT.y - NEARRADIUS * sinf(i * 3.125 / (count - 1))-50);
                
                //超过 停留坐标的位置   这些坐标用来做 物体 惯性的  使得动画看起来更自然也更美观
                
                item.farPoint = CGPointMake(STARTPOINT.x + FARRADIUS * cosf(i * 3.125 / (count - 1))+15, STARTPOINT.y - FARRADIUS * sinf(i * 3.125 / (count - 1))-50);
            }
            
            
            /*
             坐标算法就是 圆的极坐标方程
             x = a+r*cos(@)
             y = b+r*sin(@)
             因为该动画 是从上到下的 把 cos 和 sin 换了个位置
             */
            
            item.center = item.startPoint;
            item.delegate = self;
            [self addSubview:item];
        }
        
        // add the "Add" Button.
        _addButton = [[QuadCurveMenuItem alloc] initWithImage:[GetImagePath getImagePath:@"Group-7"]
                                       highlightedImage:nil
                                           ContentImage:nil
                                highlightedContentImage:nil flag:1];
        _addButton.delegate = self;
        _addButton.center = STARTPOINT;
        [self addSubview:_addButton];
    }
    return self;
}

- (void)dealloc
{
    [_addButton release];
    [_menusArray release];
    [super dealloc];
}

                               
#pragma mark - UIView's methods
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    // if the menu state is expanding, everywhere can be touch
    // otherwise, only the add button are can be touch
    if (YES == _expanding) 
    {
        return YES;
    }
    else
    {
        return CGRectContainsPoint(_addButton.frame, point);
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.expanding = !self.isExpanding;
    self.bgView.backgroundColor = [UIColor clearColor];
    self.bgView.alpha = 0;
}

#pragma mark - QuadCurveMenuItem delegates
- (void)quadCurveMenuItemTouchesBegan:(QuadCurveMenuItem *)item
{
    self.bgView.backgroundColor = [UIColor blackColor];
    self.bgView.alpha = 0.5;
    if (item == _addButton) 
    {
        self.expanding = !self.isExpanding;
    }
}

- (void)quadCurveMenuItemTouchesEnd:(QuadCurveMenuItem *)item
{
    // exclude the "add" button
    if (item == _addButton) 
    {
        return;
    }
    // blowup the selected menu button
    CAAnimationGroup *blowup = [self _blowupAnimationAtPoint:item.center];
    [item.layer addAnimation:blowup forKey:@"blowup"];
    item.center = item.startPoint;
    
    // shrink other menu buttons
    for (int i = 0; i < [_menusArray count]; i ++)
    {
        QuadCurveMenuItem *otherItem = [_menusArray objectAtIndex:i];
        CAAnimationGroup *shrink = [self _shrinkAnimationAtPoint:otherItem.center];
        if (otherItem.tag == item.tag) {
            continue;
        }
        [otherItem.layer addAnimation:shrink forKey:@"shrink"];

        otherItem.center = otherItem.startPoint;
    }
    _expanding = NO;
    
    // rotate "add" button
    float angle = self.isExpanding ? -M_PI_4 : 0.0f;
    [UIView animateWithDuration:0.2f animations:^{
        _addButton.transform = CGAffineTransformMakeRotation(angle);
    }];
    
    if ([_delegate respondsToSelector:@selector(quadCurveMenu:didSelectIndex:)])
    {
        self.bgView.backgroundColor = [UIColor clearColor];
        self.bgView.alpha = 0;
        [_delegate quadCurveMenu:self didSelectIndex:item.tag - 1000];
    }
}

#pragma mark - instant methods
- (void)setMenusArray:(NSArray *)aMenusArray
{
    if (aMenusArray == _menusArray)
    {
        return;
    }
    [_menusArray release];
    _menusArray = [aMenusArray copy];
    
    
    // clean subviews
    for (UIView *v in self.subviews) 
    {
        if (v.tag >= 1000) 
        {
            [v removeFromSuperview];
        }
    }
    // add the menu buttons
    int count = (int)[_menusArray count];
    for (int i = 0; i < count; i ++)
    {
        QuadCurveMenuItem *item = [_menusArray objectAtIndex:i];
        item.tag = 1000 + i;
        item.startPoint = STARTPOINT;
        item.endPoint = CGPointMake(STARTPOINT.x + ENDRADIUS * sinf(i * M_PI_4 / (count - 1)), STARTPOINT.y - ENDRADIUS * cosf(i * M_PI_4 / (count - 1)));
        item.nearPoint = CGPointMake(STARTPOINT.x + NEARRADIUS * sinf(i * M_PI_4 / (count - 1)), STARTPOINT.y - NEARRADIUS * cosf(i * M_PI_4 / (count - 1)));
        item.farPoint = CGPointMake(STARTPOINT.x + FARRADIUS * sinf(i * M_PI_4 / (count - 1)), STARTPOINT.y - FARRADIUS * cosf(i * M_PI_4 / (count - 1)));
        item.center = item.startPoint;
        item.delegate = self;
        [self addSubview:item];
    }
}
- (BOOL)isExpanding
{
    return _expanding;
}
- (void)setExpanding:(BOOL)expanding
{
    _expanding = expanding;    
    
    // rotate add button
    float angle = self.isExpanding ? -M_PI_4 : 0.0f;
    [UIView animateWithDuration:0.2f animations:^{
        _addButton.transform = CGAffineTransformMakeRotation(angle);
    }];
    
    // expand or close animation
    if (!_timer) 
    {
        _flag = self.isExpanding ? 0 : 5;
        SEL selector = self.isExpanding ? @selector(_expand) : @selector(_close);
        _timer = [[NSTimer scheduledTimerWithTimeInterval:TIMEOFFSET target:self selector:selector userInfo:nil repeats:YES] retain];
    }
}
#pragma mark - private methods
- (void)_expand
{
    if (_flag == 6)
    {
        [_timer invalidate];
        [_timer release];
        _timer = nil;
        return;
    }
    
    int tag = 1000 + _flag;
    QuadCurveMenuItem *item = (QuadCurveMenuItem *)[self viewWithTag:tag];
    
    CAKeyframeAnimation *rotateAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateAnimation.values = [NSArray arrayWithObjects:[NSNumber numberWithFloat:M_PI],[NSNumber numberWithFloat:0.0f], nil];
    rotateAnimation.duration = 0.5f;
    rotateAnimation.keyTimes = [NSArray arrayWithObjects:
                                [NSNumber numberWithFloat:.3], 
                                [NSNumber numberWithFloat:.4], nil]; 
    
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimation.duration = 0.5f;
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, item.startPoint.x, item.startPoint.y);
    CGPathAddLineToPoint(path, NULL, item.farPoint.x, item.farPoint.y);
    CGPathAddLineToPoint(path, NULL, item.nearPoint.x, item.nearPoint.y); 
    CGPathAddLineToPoint(path, NULL, item.endPoint.x, item.endPoint.y); 
    positionAnimation.path = path;
    CGPathRelease(path);
    
    CAAnimationGroup *animationgroup = [CAAnimationGroup animation];
    animationgroup.animations = [NSArray arrayWithObjects:positionAnimation, rotateAnimation, nil];
    animationgroup.duration = 0.5f;
    animationgroup.fillMode = kCAFillModeForwards;
    animationgroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [item.layer addAnimation:animationgroup forKey:@"Expand"];
    item.center = item.endPoint;
    
    _flag ++;
}

- (void)_close
{
    if (_flag == -1)
    {
        [_timer invalidate];
        [_timer release];
        _timer = nil;
        return;
    }
    
    int tag = 1000 + _flag;
     QuadCurveMenuItem *item = (QuadCurveMenuItem *)[self viewWithTag:tag];
    
    CAKeyframeAnimation *rotateAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateAnimation.values = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0f],[NSNumber numberWithFloat:M_PI * 2],[NSNumber numberWithFloat:0.0f], nil];
    rotateAnimation.duration = 0.5f;
    rotateAnimation.keyTimes = [NSArray arrayWithObjects:
                                [NSNumber numberWithFloat:.0], 
                                [NSNumber numberWithFloat:.4],
                                [NSNumber numberWithFloat:.5], nil]; 
        
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimation.duration = 0.5f;
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, item.endPoint.x, item.endPoint.y);
    CGPathAddLineToPoint(path, NULL, item.farPoint.x, item.farPoint.y);
    CGPathAddLineToPoint(path, NULL, item.startPoint.x, item.startPoint.y); 
    positionAnimation.path = path;
    CGPathRelease(path);
    
    CAAnimationGroup *animationgroup = [CAAnimationGroup animation];
    animationgroup.animations = [NSArray arrayWithObjects:positionAnimation, rotateAnimation, nil];
    animationgroup.duration = 0.5f;
    animationgroup.fillMode = kCAFillModeForwards;
    animationgroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [item.layer addAnimation:animationgroup forKey:@"Close"];
    item.center = item.startPoint;
    _flag --;
}

- (CAAnimationGroup *)_blowupAnimationAtPoint:(CGPoint)p
{
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimation.values = [NSArray arrayWithObjects:[NSValue valueWithCGPoint:p], nil];
    positionAnimation.keyTimes = [NSArray arrayWithObjects: [NSNumber numberWithFloat:.3], nil]; 
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(3, 3, 1)];
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.toValue  = [NSNumber numberWithFloat:0.0f];
    
    CAAnimationGroup *animationgroup = [CAAnimationGroup animation];
    animationgroup.animations = [NSArray arrayWithObjects:positionAnimation, scaleAnimation, opacityAnimation, nil];
    animationgroup.duration = 0.3f;
    animationgroup.fillMode = kCAFillModeForwards;

    return animationgroup;
}

- (CAAnimationGroup *)_shrinkAnimationAtPoint:(CGPoint)p
{
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimation.values = [NSArray arrayWithObjects:[NSValue valueWithCGPoint:p], nil];
    positionAnimation.keyTimes = [NSArray arrayWithObjects: [NSNumber numberWithFloat:.3], nil]; 
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(.01, .01, 1)];
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.toValue  = [NSNumber numberWithFloat:0.0f];
    
    CAAnimationGroup *animationgroup = [CAAnimationGroup animation];
    animationgroup.animations = [NSArray arrayWithObjects:positionAnimation, scaleAnimation, opacityAnimation, nil];
    animationgroup.duration = 0.3f;
    animationgroup.fillMode = kCAFillModeForwards;
    
    return animationgroup;
}


@end
