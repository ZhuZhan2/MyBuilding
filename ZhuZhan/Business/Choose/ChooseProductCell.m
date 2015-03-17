//
//  ChooseProductCell.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/17.
//
//

#import "ChooseProductCell.h"

@interface ChooseProductCell ()
@property(nonatomic,strong)UIImageView* assistImageView;
@property(nonatomic,strong)UILabel* mainLabel;
@property(nonatomic,strong)UIView* seperatorLine;
@end

@implementation ChooseProductCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
    }
    return self;
}

-(void)setUp{
    [self.contentView addSubview:self.assistImageView];
    [self.contentView addSubview:self.mainLabel];
    [self.contentView addSubview:self.seperatorLine];
}

-(UIImageView *)assistImageView{
    if (!_assistImageView) {
        _assistImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 28, 28)];
    }
    return _assistImageView;
}

-(UILabel *)mainLabel{
    if (!_mainLabel) {
        _mainLabel=[[UILabel alloc]initWithFrame:CGRectMake(55, 16, 200, 20)];
    }
    return _mainLabel;
}

-(UIView*)seperatorLine{
    if (!_seperatorLine) {
        _seperatorLine=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
        _seperatorLine.backgroundColor=RGBCOLOR(215, 215, 215);
    }
    return _seperatorLine;
}
@end
