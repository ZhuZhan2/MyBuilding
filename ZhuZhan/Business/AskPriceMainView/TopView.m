//
//  TopView.m
//  交易辅助流程demo
//
//  Created by 汪洋 on 15/3/16.
//  Copyright (c) 2015年 wy. All rights reserved.
//

#import "TopView.h"
#import "RKShadowView.h"
@implementation TopView

-(id)initWithFrame:(CGRect)frame firstStr:(NSString *)firstStr secondStr:(NSString *)secondStr colorArr:(NSArray *)colorArr{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = AllBackMiddleGrayColor;
        [self setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
        [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        self.firstLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.firstLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.firstLabel.numberOfLines = 0;
        self.firstLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.firstLabel.font = [UIFont systemFontOfSize:17.5];
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
        
        self.shadowView = [RKShadowView seperatorLineShadowViewWithHeight:2];
        self.shadowView.frame = CGRectMake(0, 46, 320, 2);
        [self addSubview:self.shadowView];
        
        NSDictionary *viewDict = NSDictionaryOfVariableBindings(_firstLabel,_secondLabel,_shadowView);
        [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(13)-[_firstLabel(140)]-(4)-[_secondLabel(150)]-(13)-|"options:0 metrics:nil views:viewDict]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(10)-[_firstLabel]-(10)-|" options:0 metrics:nil views:viewDict]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(10)-[_secondLabel]-(10)-|" options:0 metrics:nil views:viewDict]];
    }
    return self;
}

@end
