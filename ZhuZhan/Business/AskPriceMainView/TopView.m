//
//  TopView.m
//  交易辅助流程demo
//
//  Created by 汪洋 on 15/3/16.
//  Copyright (c) 2015年 wy. All rights reserved.
//

#import "TopView.h"

@implementation TopView

-(id)initWithFrame:(CGRect)frame firstStr:(NSString *)firstStr secondStr:(NSString *)secondStr colorArr:(NSArray *)colorArr{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        [self setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
        [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        self.firstLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.firstLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.firstLabel.numberOfLines = 0;
        self.firstLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.firstLabel.font = [UIFont systemFontOfSize:15];
        self.firstLabel.textColor = colorArr[0];
        self.firstLabel.textAlignment = NSTextAlignmentLeft;
        self.firstLabel.text = firstStr;
        [self addSubview:self.firstLabel];
        
        self.secondLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.secondLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.secondLabel.numberOfLines = 0;
        self.secondLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.secondLabel.font = [UIFont systemFontOfSize:15];
        self.secondLabel.textColor = colorArr[1];
        self.secondLabel.textAlignment = NSTextAlignmentRight;
        self.secondLabel.text = secondStr;
        [self addSubview:self.secondLabel];
        
        NSDictionary *viewDict = NSDictionaryOfVariableBindings(_firstLabel,_secondLabel);
        [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(10)-[_firstLabel(140)]-(10)-[_secondLabel(150)]-(10)-|"options:0 metrics:nil views:viewDict]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(10)-[_firstLabel]-(10)-|" options:0 metrics:nil views:viewDict]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(10)-[_secondLabel]-(10)-|" options:0 metrics:nil views:viewDict]];
        
        self.layer.shadowPath =[UIBezierPath bezierPathWithRect:self.bounds].CGPath;
        self.layer.masksToBounds = NO;
        [self.layer setShadowOffset:CGSizeMake(0, 3.0)];
        [self.layer setShadowRadius:2.5];
        [self.layer setShadowOpacity:0.8];
        [self.layer setShadowColor:[UIColor grayColor].CGColor];
    }
    return self;
}

@end
