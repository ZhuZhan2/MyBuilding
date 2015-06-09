//
//  MarkListTableViewCell.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/6/4.
//
//

#import "MarkListTableViewCell.h"
#import "MarketModel.h"
#import "RKViewFactory.h"
@implementation MarkListTableViewCell

+ (CGFloat)carculateCellHeightWithModel:(MarketModel *)cellModel{
    CGFloat height = 0;
    height += [MarketListTitleView titleViewHeight]+5;
    height += [RKViewFactory autoLabelWithMaxWidth:300 maxHeight:60 font:[UIFont systemFontOfSize:14] content:cellModel.a_reqDesc]+5;
    if(cellModel.a_reqType != 5){
        height += 40;
    }
    
    if(cellModel.a_reqType != 5){
        height += 20;
        //height += [RKViewFactory autoLabelWithMaxWidth:300 maxHeight:60 font:[UIFont systemFontOfSize:14] content:cellModel.a_reqDesc]
    }
    
    height +=15;
    return height;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.bgView];
        [self.bgView addSubview:self.titleView];
        [self.bgView addSubview:self.contentLabel];
        [self.bgView addSubview:self.firstTitleLabel];
        [self.bgView addSubview:self.firstContentLabel];
        [self.bgView addSubview:self.secondTitleLabel];
        [self.bgView addSubview:self.secondContentLabel];
    }
    return self;
}

-(MarketListTitleView *)titleView{
    if(!_titleView){
        _titleView = [[MarketListTitleView alloc] init];
    }
    return _titleView;
}

-(UIView *)bgView{
    if(!_bgView){
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, [MarketListTitleView titleViewHeight])];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

-(UILabel *)contentLabel{
    if(!_contentLabel){
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 0)];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont systemFontOfSize:14];
    }
    return _contentLabel;
}

-(UILabel *)firstTitleLabel{
    if(!_firstTitleLabel){
        _firstTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 20)];
        _firstTitleLabel.textColor = AllNoDataColor;
        _firstTitleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _firstTitleLabel;
}

-(UILabel *)firstContentLabel{
    if(!_firstContentLabel){
        _firstContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 20)];
        _firstContentLabel.font = [UIFont systemFontOfSize:14];
    }
    return _firstContentLabel;
}

-(void)setMarketModel:(MarketModel *)marketModel{
    [self.titleView setImageUrl:marketModel.a_avatarUrl title:marketModel.a_loginName type:marketModel.a_reqTypeCn time:marketModel.a_createdTime needRound:marketModel.a_needRound];
    self.contentLabel.text = marketModel.a_reqDesc;
    if([marketModel.a_reqDesc isEqualToString:@"-"]){
        self.contentLabel.textColor = AllNoDataColor;
    }else{
        self.contentLabel.textColor = [UIColor blackColor];
    }
    
    if(marketModel.a_reqType !=5){
        if(marketModel.a_reqType !=2){
            self.firstTitleLabel.text = @"需求所在地";
        }else{
            self.firstTitleLabel.text = @"大类";
        }
    }
    
    if(marketModel.a_reqType !=5){
        if(marketModel.a_reqType !=2){
            self.firstContentLabel .text = marketModel.a_address;
            if([marketModel.a_address isEqualToString:@"-"]){
                self.firstContentLabel.textColor = AllNoDataColor;
            }else{
                self.firstContentLabel.textColor = [UIColor blackColor];
            }
        }else{
            self.firstContentLabel .text = marketModel.a_bigTypeCn;
            if([marketModel.a_bigTypeCn isEqualToString:@"-"]){
                self.firstContentLabel.textColor = AllNoDataColor;
            }else{
                self.firstContentLabel.textColor = [UIColor blackColor];
            }
        }
    }
    
    CGFloat height = 0;
    CGRect frame = self.titleView.frame;
    height += CGRectGetHeight(self.titleView.frame)+5;
    
    
    CGSize size =CGSizeMake(300,60);
    CGSize actualsize =[marketModel.a_reqDesc boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    frame = self.contentLabel.frame;
    frame.origin.y = height;
    frame.size.height = actualsize.height;
    self.contentLabel.frame = frame;
    height += CGRectGetHeight(self.contentLabel.frame)+5;
    
    if(marketModel.a_reqType !=5){
        self.firstTitleLabel.hidden = NO;
        frame = self.firstTitleLabel.frame;
        frame.origin.y = height;
        self.firstTitleLabel.frame = frame;
        height += CGRectGetHeight(self.firstTitleLabel.frame);
    }else{
        self.firstTitleLabel.hidden = YES;
    }
    
    if(marketModel.a_reqType !=5){
        self.firstContentLabel.hidden = NO;
        frame = self.firstContentLabel.frame;
        frame.origin.y = height;
        self.firstContentLabel.frame = frame;
        height += CGRectGetHeight(self.firstContentLabel.frame);
    }else{
        self.firstContentLabel.hidden = YES;
    }
    
    frame = self.bgView.frame;
    frame.size.height = height+5;
    self.bgView.frame = frame;
}
@end
