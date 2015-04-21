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
        [self.contentView addSubview:self.headBtn];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.cutLine];
        [self.contentView addSubview:self.addBtn];
    }
    return self;
}

-(void)setModel:(FriendModel *)model{
    _model = model;
    [self.headBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:model.a_avatarUrl] forState:UIControlStateNormal placeholderImage:[GetImagePath getImagePath:@"人脉_06a2"]];
    self.nameLabel.text = model.a_name;
    if (model.a_isWaiting) {
        [self.addBtn setBackgroundImage:[GetImagePath getImagePath:@"等待验证120"] forState:UIControlStateNormal];
        self.addBtn.userInteractionEnabled=NO;
    }else{
        [self.addBtn setBackgroundImage:[GetImagePath getImagePath:model.a_isisFriend?@"added":@"add_green_button"] forState:UIControlStateNormal];
        self.addBtn.userInteractionEnabled=!model.a_isisFriend;
    }
}

-(void)setIndexPathRow:(int)indexPathRow{
    _indexPathRow = indexPathRow;
}

-(UIButton *)headBtn{
    if(!_headBtn){
        _headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _headBtn.layer.cornerRadius=3;
        _headBtn.layer.masksToBounds=YES;
        _headBtn.frame=CGRectMake(15, 10, 35, 35);
        [_headBtn addTarget:self action:@selector(headImageAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headBtn;
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
    if([self.delegate respondsToSelector:@selector(headClick:)]){
        [self.delegate headClick:self.indexPathRow];
    }
}

-(void)addFriendAction{
    if(!self.model.a_isisFriend){
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:self.model.a_id forKey:@"userId"];
        [AddressBookApi PostSendFriendRequestWithBlock:^(NSMutableArray *posts, NSError *error) {
            if(!error){
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"发送成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
                self.model.a_isWaiting=YES;
                self.addBtn.userInteractionEnabled=NO;
                [self.addBtn setBackgroundImage:[GetImagePath getImagePath:@"等待验证120"] forState:UIControlStateNormal];
            }else{
                if([ErrorCode errorCode:error] == 403){
                    [LoginAgain AddLoginView:NO];
                }else{
                    [ErrorCode alert];
                }
            }
        } dic:dic noNetWork:^{
            [ErrorCode alert];
        }];
    }
}
@end
