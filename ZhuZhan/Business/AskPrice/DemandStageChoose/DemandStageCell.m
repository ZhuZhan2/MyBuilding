//
//  DemandStageCell.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/23.
//
//

#import "DemandStageCell.h"
#import "RKShadowView.h"
@interface DemandStageCell()
@property(nonatomic,strong)UILabel* nameLabel;
@property(nonatomic,strong)UIImageView* assistImageView;
@end

@implementation DemandStageCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.nameLabel];
        
        [self.contentView addSubview:self.assistImageView];
        
        UIView* seperatorLine=[RKShadowView seperatorLineWithHeight:2];
        seperatorLine.center=CGPointMake(kScreenWidth*0.5, 47);
        [self.contentView addSubview:seperatorLine];
    }
    return self;
}

-(void)setModel:(DemandStageCellModel *)model{
    _model=model;
    self.nameLabel.text=model.stageName;
    self.assistImageView.hidden=!model.isHighlight;
}

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(27, 14, 200, 20)];
    }
    return _nameLabel;
}

-(UIImageView *)assistImageView{
    if (!_assistImageView) {
        _assistImageView=[[UIImageView alloc]initWithFrame:CGRectMake(270, 15.5, 22, 17)];
        _assistImageView.image=[GetImagePath getImagePath:@"DemandStageSelected"];
    }
    return _assistImageView;
}
@end

@implementation DemandStageCellModel
@end
