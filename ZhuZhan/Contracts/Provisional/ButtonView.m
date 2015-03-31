//
//  ButtonView.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/31.
//
//

#import "ButtonView.h"

@implementation ButtonView
-(id)initWithFrame:(CGRect)frame flag:(int)flag{
    self = [super initWithFrame:frame];
    if(self){
        if(flag == 1){
            [self addSubview:self.sumbitBtn];
        }else if (flag == 2){
            [self addSubview:self.noAgreeBtn];
            [self addSubview:self.agreeBtn];
        }else if (flag == 3){
            [self addSubview:self.closeBtn];
            [self addSubview:self.saveBtn];
        }else{
            [self addSubview:self.closeBtn];
            [self addSubview:self.changeBtn];
        }
    }
    return self;
}

-(UIButton *)sumbitBtn{
    if(!_sumbitBtn){
        _sumbitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sumbitBtn.frame = CGRectMake(13, 5, 294, 38);
        [_sumbitBtn setImage:[GetImagePath getImagePath:@"submit"] forState:UIControlStateNormal];
        [_sumbitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sumbitBtn;
}

-(void)submitAction{
    
}

-(UIButton *)noAgreeBtn{
    if(!_noAgreeBtn){
        _noAgreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _noAgreeBtn.frame = CGRectMake(26, 5, 128, 37);
        [_noAgreeBtn setImage:[GetImagePath getImagePath:@"noagree"] forState:UIControlStateNormal];
        [_noAgreeBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _noAgreeBtn;
}

-(UIButton *)agreeBtn{
    if(!_agreeBtn){
        _agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _agreeBtn.frame = CGRectMake(164, 5, 128, 37);
        [_agreeBtn setImage:[GetImagePath getImagePath:@"agree"] forState:UIControlStateNormal];
        [_agreeBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _agreeBtn;
}

-(UIButton *)closeBtn{
    if(!_closeBtn){
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeBtn.frame = CGRectMake(26, 5, 128, 37);
        [_closeBtn setImage:[GetImagePath getImagePath:@"close"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

-(UIButton *)changeBtn{
    if(!_changeBtn){
        _changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _changeBtn.frame = CGRectMake(164, 5, 128, 37);
        [_changeBtn setImage:[GetImagePath getImagePath:@"agree"] forState:UIControlStateNormal];
        [_changeBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changeBtn;
}

-(UIButton *)saveBtn{
    if(!_saveBtn){
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _saveBtn.frame = CGRectMake(164, 5, 128, 37);
        [_saveBtn setImage:[GetImagePath getImagePath:@"save"] forState:UIControlStateNormal];
        [_saveBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveBtn;
}
@end
