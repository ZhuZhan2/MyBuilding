//
//  RecommendFriendCell.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/4/9.
//
//

#import "RecommendFriendCell.h"
#import "RKShadowView.h"
#import "AddressBookApi.h"
@implementation RecommendFriendCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.headImage];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.cutLine];
        [self.contentView addSubview:self.addBtn];
    }
    return self;
}

-(void)setModel:(FriendModel *)model{
    _model = model;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.a_avatarUrl] placeholderImage:[GetImagePath getImagePath:@"人脉_06a2"]];
    self.nameLabel.text = model.a_name;
    [self.addBtn setBackgroundImage:[GetImagePath getImagePath:model.a_isisFriend?@"added":@"add_green_button"] forState:UIControlStateNormal];
}

-(UIImageView *)headImage{
    if(!_headImage){
        _headImage = [[UIImageView alloc] init];
        _headImage.layer.cornerRadius=3;
        _headImage.layer.masksToBounds=YES;
        _headImage.frame=CGRectMake(15, 10, 35, 35);
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = _headImage.frame;
        btn.backgroundColor = [UIColor clearColor];
        [btn addTarget:self action:@selector(headImageAction) forControlEvents:UIControlEventTouchUpInside];
        [_headImage addSubview:btn];
    }
    return _headImage;
}

-(UILabel *)nameLabel{
    if(!_nameLabel){
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 21, 200, 15)];
        _nameLabel.font=[UIFont boldSystemFontOfSize:15];
        _nameLabel.textColor=RGBCOLOR(89, 89, 89);
    }
    return _nameLabel;
}

-(UIButton *)addBtn{
    if(!_addBtn){
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBtn.frame = CGRectMake(250, 19, 60, 26);
        [_addBtn addTarget:self action:@selector(addFriendAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}

-(UIView *)cutLine{
    if(!_cutLine){
        _cutLine = [RKShadowView seperatorLine];
        _cutLine.frame = CGRectMake(0, 56, 320, 1);
    }
    return _cutLine;
}

-(void)headImageAction{

}

-(void)addFriendAction{
    if(!self.model.a_isisFriend){
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:self.model.a_id forKey:@"userId"];
        [AddressBookApi PostSendFriendRequestWithBlock:^(NSMutableArray *posts, NSError *error) {
            if(!error){
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"发送成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
                self.model.a_isisFriend=YES;
                [self.addBtn setBackgroundImage:[GetImagePath getImagePath:@"报价灰"] forState:UIControlStateNormal];
            }else{
                [LoginAgain AddLoginView:NO];
            }
        } dic:dic noNetWork:nil];
    }
}
@end
