//
//  MarkListView.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/6/4.
//
//

#import "MarkListView.h"
#import "RKViewFactory.h"

@implementation MarkListView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithPatternImage: [GetImagePath getImagePath:@"card_bg2"]];
        //[self addSubview:self.cutLine];
        [self addSubview:self.headImageView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.typeLabel];
        [self addSubview:self.timeLabel];
        [self addSubview:self.contentLabel];
        [self addSubview:self.firstTitleLabel];
        [self addSubview:self.firstContentLabel];
        [self addSubview:self.secondTitleLabel];
        [self addSubview:self.secondContentLabel];
    }
    return self;
}

-(UIImageView *)cutLine{
    if(!_cutLine){
        _cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 53, self.frame.size.width, 1)];
        _cutLine.image = [GetImagePath getImagePath:@"card_cut"];
    }
    return _cutLine;
}

-(UIImageView *)headImageView{
    if(!_headImageView){
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 8, 40, 40)];
        _headImageView.layer.masksToBounds = YES;
        _headImageView.layer.cornerRadius = 20;
    }
    return _headImageView;
}

-(UILabel *)nameLabel{
    if(!_nameLabel){
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(61, 10, 190, 20)];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textColor = RGBCOLOR(51, 51, 51);
    }
    return _nameLabel;
}

-(UILabel *)typeLabel{
    if(!_typeLabel){
        _typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(61, 28, 50, 20)];
        _typeLabel.font = [UIFont systemFontOfSize:14];
        _typeLabel.textColor = BlueColor;
    }
    return _typeLabel;
}

-(UILabel *)timeLabel{
    if(!_timeLabel){
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(111, 28, 130, 20)];
        _timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.textColor = AllNoDataColor;
    }
    return _timeLabel;
}

-(UILabel *)contentLabel{
    if(!_contentLabel){
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 58, 248, 0)];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont systemFontOfSize:16];
        _contentLabel.textColor = RGBCOLOR(51, 51, 51);
    }
    return _contentLabel;
}

-(UILabel *)firstTitleLabel{
    if(!_firstTitleLabel){
        _firstTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 113, 120, 20)];
        _firstTitleLabel.textColor = AllNoDataColor;
        _firstTitleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _firstTitleLabel;
}

-(UILabel *)firstContentLabel{
    if(!_firstContentLabel){
        _firstContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 133, 120, 20)];
        _firstContentLabel.font = [UIFont systemFontOfSize:16];
    }
    return _firstContentLabel;
}

-(UILabel *)secondTitleLabel{
    if(!_secondTitleLabel){
        _secondTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 113, 120, 20)];
        _secondTitleLabel.textColor = AllNoDataColor;
        _secondTitleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _secondTitleLabel;
}

-(UILabel *)secondContentLabel{
    if(!_secondContentLabel){
        _secondContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 133, 120, 20)];
        _secondContentLabel.font = [UIFont systemFontOfSize:16];
    }
    return _secondContentLabel;
}

-(void)setModel:(MarketModel *)model{
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.a_avatarUrl] placeholderImage:[GetImagePath getImagePath:@"默认图_用户头像_卡片头像"]];
    self.nameLabel.text = model.a_loginName;
    self.typeLabel.text = model.a_reqTypeCn;
    self.timeLabel.text = model.a_createdTime;
    self.contentLabel.text = model.a_reqDesc;
    if(model.a_reqType !=5){
        [RKViewFactory autoLabel:self.contentLabel maxWidth:248 maxHeight:40];
    }else{
        [RKViewFactory autoLabel:self.contentLabel maxWidth:248 maxHeight:80];
    }
    
    if(model.a_reqType !=5){
        if(model.a_reqType !=2){
            self.firstTitleLabel.text = @"所在城市";
        }else{
            self.firstTitleLabel.text = @"大类";
        }
    }
    
    if(model.a_reqType !=5){
        if(model.a_reqType !=2){
            self.firstContentLabel .text = model.a_city;
            if([model.a_address isEqualToString:@"-"]){
                self.firstContentLabel.textColor = AllNoDataColor;
            }else{
                self.firstContentLabel.textColor = RGBCOLOR(51, 51, 51);
            }
        }else{
            self.firstContentLabel .text = model.a_bigTypeCn;
            if([model.a_bigTypeCn isEqualToString:@"-"]){
                self.firstContentLabel.textColor = AllNoDataColor;
            }else{
                self.firstContentLabel.textColor = RGBCOLOR(51, 51, 51);
            }
        }
    }
    
    if(model.a_reqType == 1){
        self.secondTitleLabel.text = @"金额要求（百万）";
        self.secondContentLabel.text = model.a_money;
        if([model.a_money isEqualToString:@"-"]){
            self.secondContentLabel.textColor = AllNoDataColor;
        }else{
            self.secondContentLabel.textColor = RGBCOLOR(51, 51, 51);
        }
    }else if (model.a_reqType == 2){
        self.secondTitleLabel.text = @"分类";
        self.secondContentLabel.text = model.a_smallTypeCn;
        if([model.a_smallTypeCn isEqualToString:@"-"]){
            self.secondContentLabel.textColor = AllNoDataColor;
        }else{
            self.secondContentLabel.textColor = RGBCOLOR(51, 51, 51);
        }
    }
    
    if(model.a_reqType !=5){
        self.firstTitleLabel.hidden = NO;
        self.firstContentLabel.hidden = NO;
        self.secondTitleLabel.hidden = NO;
        self.secondContentLabel.hidden = NO;
    }else{
        self.firstTitleLabel.hidden = YES;
        self.firstContentLabel.hidden = YES;
        self.secondTitleLabel.hidden = YES;
        self.secondContentLabel.hidden = YES;
    }
}
@end
