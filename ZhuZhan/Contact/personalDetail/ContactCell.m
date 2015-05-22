//
//  ContactCell.m
//  ZhuZhan
//
//  Created by Jack on 14-9-4.
//
//

#import "ContactCell.h"

@implementation ContactCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.topBgView addSubview:self.topLineImage];
        [self.topBgView addSubview:self.topImgaeView];
        [self.contentView addSubview:self.topBgView];
        [self.contentView addSubview:self.cutLine];
        [self.contentView addSubview:self.phoneTitle];
        [self.contentView addSubview:self.emailTitle];
        [self.contentView addSubview:self.phone];
        [self.contentView addSubview:self.email];
    }
    return self;
}

-(UIView *)topBgView{
    if(!_topBgView){
        _topBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
        _topBgView.backgroundColor = [UIColor colorWithPatternImage:[GetImagePath getImagePath:@"grayColor"]];
    }
    return _topBgView;
}

-(UIImageView *)topLineImage{
    if(!_topLineImage){
        _topLineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 5)];
        [_topLineImage setImage:[UIImage imageNamed:@"项目－高级搜索－2_15a"]];
    }
    return _topLineImage;
}

-(UIImageView *)topImgaeView{
    if(!_topImgaeView){
        _topImgaeView = [[UIImageView alloc] initWithFrame:CGRectMake(129, 8, 52, 34)];
        _topImgaeView.image = [GetImagePath getImagePath:@"人脉－人的详情_28a"];
    }
    return _topImgaeView;
}

-(UIImageView *)cutLine{
    if(!_cutLine){
        _cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(20, 99, 280, 1)];
        _cutLine.backgroundColor = [UIColor blackColor];
        _cutLine.alpha = 0.2;
    }
    return _cutLine;
}

-(UILabel *)phoneTitle{
    if(!_phoneTitle){
        NSAttributedString *string = [[NSAttributedString alloc] initWithString:@"电话" attributes:@{NSKernAttributeName : @(30.0f)}];
        _phoneTitle = [[UILabel alloc] initWithFrame:CGRectMake(30, 60, 100, 30)];
        _phoneTitle.attributedText = string;
        _phoneTitle.font = [UIFont systemFontOfSize:14];
    }
    return _phoneTitle;
}

-(UILabel *)emailTitle{
    if(!_emailTitle){
        NSAttributedString *string = [[NSAttributedString alloc] initWithString:@"邮箱" attributes:@{NSKernAttributeName : @(30.0f)}];
        _emailTitle = [[UILabel alloc] initWithFrame:CGRectMake(30, 110, 100, 30)];
        _emailTitle.attributedText = string;
        _emailTitle.font = [UIFont systemFontOfSize:14];
    }
    return _emailTitle;
}

-(UILabel *)phone{
    if(!_phone){
        _phone = [[UILabel alloc] initWithFrame:CGRectMake(110, 60, 190, 30)];
        _phone.textColor = [UIColor lightGrayColor];
        _phone.font = [UIFont systemFontOfSize:14];
    }
    return _phone;
}

-(UILabel *)email{
    if(!_email){
        _email = [[UILabel alloc] initWithFrame:CGRectMake(110, 110, 190, 30)];
        _email.textColor = [UIColor lightGrayColor];
        _email.font = [UIFont systemFontOfSize:14];
    }
    return _email;
}

-(void)setModel:(MyCenterModel *)model{
    if([model.a_cellPhone isEqualToString:@""]){
        self.phone.text = @"－";
    }else{
        self.phone.text = model.a_cellPhone;
    }
    
    if([model.a_email isEqualToString:@""]){
        self.email.text = @"－";
    }else{
        self.email.text = model.a_email;
    }
}
@end
