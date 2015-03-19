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
        _fixationLabel = [[UILabel alloc] initWithFrame:CGRectMake(26, 22, 65, 16)];
        _fixationLabel.font = [UIFont systemFontOfSize:16];
        _fixationLabel.textColor = BlueColor;
        _fixationLabel.textAlignment = NSTextAlignmentLeft;
        _fixationLabel.text = @"参与用户";
    }
    return _fixationLabel;
}

-(UILabel *)lastlabel{
    if(!_lastlabel){
        _lastlabel = [[UILabel alloc] initWithFrame:CGRectMake(106, 170, 180, 15)];
        _lastlabel.font = [UIFont systemFontOfSize:15];
        _lastlabel.textAlignment = NSTextAlignmentLeft;
        _lastlabel.textColor = AllLightGrayColor;
        _lastlabel.text = @"您最多只能选择5位用户";
    }
    return _lastlabel;
}

-(UIView *)addView{
    if(!_addView){
        _addView = [[UIView alloc] initWithFrame:CGRectMake(106, 19, 180, 22)];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 21, 22)];
        imageView.image = [GetImagePath getImagePath:@"交易_添加"];
        [_addView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(27, 3, 50, 16)];
        label.textColor = AllGreenColor;
        label.text = @"添加";
        label.font = [UIFont systemFontOfSize:16];
        [_addView addSubview:label];
        
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addBtn.frame = CGRectMake(0, 0, 180, 22);
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
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(106, idx*30+22, 180, 16)];
            label.font = [UIFont systemFontOfSize:16];
            label.textAlignment = NSTextAlignmentLeft;
            label.text = obj;
            [self addSubview:label];
            UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            closeBtn.frame = CGRectMake(280, idx*30+20, 21, 20);
            [closeBtn setImage:[GetImagePath getImagePath:@"交易_删除"] forState:UIControlStateNormal];
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
            block(height+110+self.lastlabel.frame.size.height);
        }
    }else{
        if(count !=0){
            self.addView.frame = CGRectMake(106, newLabel.frame.origin.y+25, 180, 22);
            [self addSubview:self.addView];
            if(block){
                block(height+40+self.addView.frame.size.height+labelArr.count*10);
            }
        }else{
            [self addSubview:self.addView];
            if(block){
                block(60);
            }
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
