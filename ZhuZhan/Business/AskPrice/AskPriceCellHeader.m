//
//  AskPriceCellHeader.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/17.
//
//

#import "AskPriceCellHeader.h"

@interface AskPriceCellHeader ()
@property(nonatomic,strong)UILabel* stageLabel;
//@property(nonatomic,strong)UIImageView* remindNew;
@property(nonatomic,strong)UILabel* numberLabel;

@property(nonatomic,strong)AskPriceCellHeaderModel* model;
@end

#define kTotalHeight 40
#define mainFont [UIFont systemFontOfSize:15]
#define assistFont [UIFont systemFontOfSize:14]
#define assistColor AllLightGrayColor

@implementation AskPriceCellHeader
+(AskPriceCellHeader*)askPriceCellHeaderWithModel:(AskPriceCellHeaderModel*)model{
    AskPriceCellHeader* view=[[AskPriceCellHeader alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kTotalHeight)];
    view.model=model;
    [view setUp];
    
    return view;
}

-(void)setUp{
    [self addSubview:self.stageLabel];
    //[self addSubview:self.remindNew];
    [self addSubview:self.numberLabel];
}

-(void)changeStageName:(NSString*)stageName stageColor:(UIColor*)stageColor{
    self.stageLabel.text=stageName;
    self.stageLabel.textColor=stageColor;
}

-(UILabel *)stageLabel{
    if (!_stageLabel) {
        _stageLabel=[[UILabel alloc]initWithFrame:CGRectMake(13, 0, 75, kTotalHeight)];
        _stageLabel.font=mainFont;
    }
    return _stageLabel;
}

//-(UIImageView *)remindNew{
//    if (!_remindNew) {
//        _remindNew=[[UIImageView alloc]initWithFrame:CGRectMake(91, 14, 27, 11.5)];
//        _remindNew.image=[GetImagePath getImagePath:@"交易_有新消息"];
//    }
//    return _remindNew;
//}

-(UILabel *)numberLabel{
    if (!_numberLabel) {
        _numberLabel=[[UILabel alloc]initWithFrame:CGRectMake(184, 0, 130, kTotalHeight)];
        _numberLabel.font=assistFont;
        _numberLabel.textColor=assistColor;
        _numberLabel.text=self.model.number;
    }
    return _numberLabel;
}
@end
@implementation AskPriceCellHeaderModel
@end