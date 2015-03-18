//
//  AddContactView.m
//  交易辅助流程demo
//
//  Created by 汪洋 on 15/3/17.
//  Copyright (c) 2015年 wy. All rights reserved.
//

#import "AddContactView.h"

@implementation AddContactView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        
    }
    return self;
}

-(UILabel *)fixationLabel{
    if(!_fixationLabel){
        _fixationLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 65, 15)];
        _fixationLabel.font = [UIFont systemFontOfSize:15];
        _fixationLabel.textColor = BlueColor;
        _fixationLabel.textAlignment = NSTextAlignmentLeft;
        _fixationLabel.text = @"参与用户";
    }
    return _fixationLabel;
}

-(UILabel *)lastlabel{
    if(!_lastlabel){
        _lastlabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 145, 180, 15)];
        _lastlabel.font = [UIFont systemFontOfSize:15];
        _lastlabel.textAlignment = NSTextAlignmentLeft;
        _lastlabel.text = @"您最多只能选择5位用户";
    }
    return _lastlabel;
}

-(UIView *)addView{
    if(!_addView){
        _addView = [[UIView alloc] initWithFrame:CGRectMake(100, 10, 180, 35)];
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addBtn.frame = CGRectMake(0, 0, 180, 35);
        addBtn.backgroundColor = [UIColor redColor];
        [addBtn addTarget:self action:@selector(addBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_addView addSubview:addBtn];
    }
    return _addView;
}

-(void)GetHeightWithBlock:(void (^)(double))block labelArr:(NSMutableArray *)labelArr{
    [self addSubview:self.fixationLabel];
    __block int height = 0;
    __block UILabel *newLabel= nil;
    int count = (int)labelArr.count;
    if(count !=0){
        [labelArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, idx*25+20, 180, 15)];
            label.font = [UIFont systemFontOfSize:15];
            label.textAlignment = NSTextAlignmentLeft;
            label.text = obj;
            [self addSubview:label];
            UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            closeBtn.frame = CGRectMake(200, idx*25+20, 15, 15);
            closeBtn.backgroundColor = [UIColor redColor];
            closeBtn.tag = idx;
            [closeBtn addTarget:self action:@selector(closeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:closeBtn];
            height += label.frame.size.height;
            newLabel = label;
        }];
    }
    
    if(count == 5){
        [self addSubview:self.lastlabel];
        if(block){
            block(height+80+self.lastlabel.frame.size.height);
        }
    }else{
        if(count !=0){
            self.addView.frame = CGRectMake(100, newLabel.frame.origin.y+25, 180, 35);
        }
        [self addSubview:self.addView];
        if(block){
            block(height+40+self.addView.frame.size.height+labelArr.count*10);
        }
    }
}

-(void)addBtnAction{
    NSLog(@"addBtnAction");
    if([self.delegate respondsToSelector:@selector(addContent)]){
        [self.delegate addContent];
    }
}

-(void)closeBtnAction:(UIButton *)button{
    NSLog(@"%ld",(long)button.tag);
    if([self.delegate respondsToSelector:@selector(closeContent:)]){
        [self.delegate closeContent:button.tag];
    }
}
@end
