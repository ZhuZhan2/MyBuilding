//
//  RequireCommentTableViewCell.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/6/10.
//
//

#import "RequireCommentTableViewCell.h"
#import "RKViewFactory.h"

@implementation RequireCommentTableViewCell

+ (CGFloat)carculateCellHeightWithModel:(ContactCommentModel *)cellModel{
    CGFloat height = 0;
    height += 60;
    height += [RKViewFactory autoLabelWithMaxWidth:300 maxHeight:1000 font:[UIFont systemFontOfSize:14] content:cellModel.a_commentContents]+3;
    return height;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.headBtn];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.cutLine];
        [self.contentView addSubview:self.delBtn];
    }
    return self;
}

-(UIButton *)headBtn{
    if(!_headBtn){
        _headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _headBtn.frame = CGRectMake(10, 10, 40, 40);
        _headBtn.layer.masksToBounds = YES;
        [_headBtn addTarget:self action:@selector(headActiobn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headBtn;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 12, 120, 20)];
        _nameLabel.textColor = RGBCOLOR(51, 51, 51);
        _nameLabel.font = [UIFont systemFontOfSize:16];
    }
    return _nameLabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 32, 140, 15)];
        _timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.textColor = AllNoDataColor;
    }
    return _timeLabel;
}

-(UILabel *)contentLabel{
    if(!_contentLabel){
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 57, 300, 0)];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.textColor = RGBCOLOR(51, 51, 51);
    }
    return _contentLabel;
}

-(UIImageView *)cutLine{
    if(!_cutLine){
        _cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
        _cutLine.image = [GetImagePath getImagePath:@"project_cutline"];
    }
    return _cutLine;
}

-(UIButton *)delBtn{
    if(!_delBtn){
        _delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _delBtn .frame = CGRectMake(270, 10, 40, 40);
        [_delBtn setImage:[GetImagePath getImagePath:@"delComment"] forState:UIControlStateNormal];
        [_delBtn addTarget:self action:@selector(delComment) forControlEvents:UIControlEventTouchUpInside];
    }
    return _delBtn;
}

-(void)delComment{
    if([self.delegate respondsToSelector:@selector(deleteComment:)]){
        [self.delegate deleteComment:self.indexPath];
    }
}

-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
}

-(void)setModel:(ContactCommentModel *)model{
    UIImage *image = nil;
    if(model.a_isService){
        image = [GetImagePath getImagePath:@"card_ service"];
    }else{
        if(model.a_isPersonal){
            image = [GetImagePath getImagePath:@"默认图_用户头像_卡片头像"];
        }else{
            image = [GetImagePath getImagePath:@"默认图_公司头像_卡片头像"];
        }
    }
    [self.headBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:model.a_avatarUrl] forState:UIControlStateNormal placeholderImage:image];
    self.headBtn.layer.cornerRadius = model.a_isPersonal?20:3;
    if(model.a_isSelf){
        self.nameLabel.textColor = BlueColor;
    }else{
        self.nameLabel.textColor = RGBCOLOR(51, 51, 51);
    }
    self.nameLabel.text = model.a_userName;
    self.timeLabel.text = model.a_createdTime;
    self.contentLabel.text = model.a_commentContents;
    [RKViewFactory autoLabel:self.contentLabel maxWidth:300 maxHeight:1000];
    CGRect frame = self.contentLabel.frame;
    CGFloat height = frame.size.height+frame.origin.y;
    frame = self.cutLine.frame;
    frame.origin.y = height+5;
    self.cutLine.frame = frame;
    
    if(model.a_isSelf){
        self.delBtn.hidden = NO;
    }else{
        self.delBtn.hidden = YES;
    }
}

-(void)headActiobn{
    if([self.delegate respondsToSelector:@selector(headClick:)]){
        [self.delegate headClick:self.indexPath];
    }
}
@end
