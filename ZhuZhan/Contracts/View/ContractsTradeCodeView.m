//
//  ContractsTradeCodeView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/4/15.
//
//

#import "ContractsTradeCodeView.h"
#import "RKShadowView.h"
@interface ContractsTradeCodeView ()
@property (nonatomic, strong)UILabel* tradeCodeLabel;
@property (nonatomic, strong)UILabel* timeLabel;

@property (nonatomic, copy)NSString* tradeCode;
@property (nonatomic, copy)NSString* time;
@end

#define kTotalHeight 30
#define kContentFont [UIFont systemFontOfSize:14]
@implementation ContractsTradeCodeView
+(ContractsTradeCodeView*)contractsTradeCodeViewWithTradeCode:(NSString*)tradeCode time:(NSString*)time{
    ContractsTradeCodeView* contractsCodeView=[[ContractsTradeCodeView alloc]init];
    contractsCodeView.frame=CGRectMake(0, 0, kScreenWidth, kTotalHeight);
    contractsCodeView.tradeCode=tradeCode;
    contractsCodeView.time=time;
    [contractsCodeView setUp];
    return contractsCodeView;
}

-(void)setUp{
    self.backgroundColor=AllBackDeepGrayColor;
    [self addSubview:self.tradeCodeLabel];
    [self addSubview:self.timeLabel];
    UIView* line=[RKShadowView seperatorLine];
    CGRect frame=line.frame;
    frame.origin.y=CGRectGetHeight(self.frame);
    line.frame=frame;
    [self addSubview:line];
}

-(UILabel *)tradeCodeLabel{
    if (!_tradeCodeLabel) {
        _tradeCodeLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 180, kTotalHeight)];
        _tradeCodeLabel.font=kContentFont;
        _tradeCodeLabel.textColor=AllDeepGrayColor;
        _tradeCodeLabel.text=self.tradeCode;
    }
    return _tradeCodeLabel;
}

-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(190, 0, 120, kTotalHeight)];
        _timeLabel.font=kContentFont;
        _timeLabel.textAlignment=NSTextAlignmentRight;
        _timeLabel.textColor=AllDeepGrayColor;
        _timeLabel.text=self.time;
    }
    return _timeLabel;
}
@end
