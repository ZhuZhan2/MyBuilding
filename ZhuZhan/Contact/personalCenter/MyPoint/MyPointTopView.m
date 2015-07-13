//
//  MyPointTopView.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/7/13.
//
//

#import "MyPointTopView.h"
#import "RKShadowView.h"

@interface MyPointTopView()
@property(nonatomic,strong)UILabel *pointTitleLabel;
@property(nonatomic,strong)UILabel *pointLabel;
@property(nonatomic,strong)UIButton *pointDetailBtn;
@property(nonatomic,strong)UIButton *pointRulesBtn;
@property(nonatomic,strong)UIView *bottomView;
@end

@implementation MyPointTopView
-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self addSubview:self.bottomView];
        [self addSubview:self.pointTitleLabel];
        [self addSubview:self.pointLabel];
        [self addSubview:self.pointDetailBtn];
        [self addSubview:self.pointRulesBtn];
    }
    return self;
}

-(UIView *)bottomView{
    if(!_bottomView){
        _bottomView = [RKShadowView seperatorLineDoubleWithHeight:10 top:0];
        _bottomView.center = CGPointMake(160, 160);
    }
    return _bottomView;
}

-(UILabel *)pointTitleLabel{
    if(!_pointTitleLabel){
        _pointTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, 320, 20)];
        _pointTitleLabel.font = [UIFont systemFontOfSize:15];
        _pointTitleLabel.textColor = RGBCOLOR(51, 51, 51);
        _pointTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _pointTitleLabel;
}

-(UILabel *)pointLabel{
    if(!_pointLabel){
        _pointLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 47, 320, 40)];
        _pointLabel.textAlignment = NSTextAlignmentCenter;
        _pointLabel.font = [UIFont systemFontOfSize:35];
        _pointLabel.textColor = RGBCOLOR(226, 116, 36);
        _pointLabel.text = @"";
    }
    return _pointLabel;
}

-(UIButton *)pointDetailBtn{
    if(!_pointDetailBtn){
        _pointDetailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_pointDetailBtn setImage:[GetImagePath getImagePath:@"point_detail"] forState:UIControlStateNormal];
        _pointDetailBtn.frame = CGRectMake(47, 102.5, 100, 30);
        _pointDetailBtn.tag = 0;
        [_pointDetailBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pointDetailBtn;
}

-(UIButton *)pointRulesBtn{
    if(!_pointRulesBtn){
        _pointRulesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_pointRulesBtn setImage:[GetImagePath getImagePath:@"point_rules"] forState:UIControlStateNormal];
        _pointRulesBtn.frame = CGRectMake(173, 102.5, 100, 30);
        _pointRulesBtn.tag = 1;
        [_pointRulesBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pointRulesBtn;
}

-(void)buttonClick:(UIButton *)button{
    if([self.delegate respondsToSelector:@selector(gotoPointDetailView:)]){
        [self.delegate gotoPointDetailView:button.tag];
    }
}

-(void)setPoint:(NSString *)point{
    self.pointLabel.text = point;
}

-(void)setStatus:(NSString *)status{
    if([status isEqualToString:@"00"]){
        self.pointTitleLabel.text = @"可用积分";
    }else if([status isEqualToString:@"01"]){
        NSMutableAttributedString* attStr=[[NSMutableAttributedString alloc]initWithString:@"可用积分(异常)"];
        [attStr addAttribute:NSForegroundColorAttributeName value:RGBCOLOR(207, 72, 31) range:NSMakeRange(4, 4)];
         self.pointTitleLabel.attributedText = attStr;
    }else{
        self.pointTitleLabel.text = @"";
    }
}
@end
