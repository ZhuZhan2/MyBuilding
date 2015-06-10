//
//  AddressBookFriendCell.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/9.
//
//

#import "AddressBookFriendCell.h"
@interface AddressBookFriendCell ()
@property(nonatomic,strong)UILabel* mainLabel;
@property(nonatomic,strong)UIButton* assistBtn;
@property(nonatomic,strong)UIView* seperatorLine;
@property(nonatomic,strong,setter=setModel:)AddressBookFriendCellModel* model;

@property(nonatomic,weak)id<AddressBookFriendCellDelegate>delegate;
@property(nonatomic,strong)NSIndexPath* indexPath;
@end

#define mainLabelFont [UIFont systemFontOfSize:16]

@implementation AddressBookFriendCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier delegate:(id<AddressBookFriendCellDelegate>)delegate{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.delegate=delegate;
        [self setUp];
    }
    return self;
}

-(UILabel *)mainLabel{
    if (!_mainLabel) {
        _mainLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 20)];
        _mainLabel.font=mainLabelFont;
    }
    return _mainLabel;
}

-(UIButton *)assistBtn{
    if (!_assistBtn) {
        _assistBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 62, 14)];
        [_assistBtn addTarget:self action:@selector(chooseAssistBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _assistBtn;
}

-(UIView *)seperatorLine{
    if (!_seperatorLine) {
        _seperatorLine=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 1)];
        _seperatorLine.backgroundColor=RGBCOLOR(229, 229, 229);
    }
    return _seperatorLine;
}

-(void)setUp{
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.mainLabel];
    [self.contentView addSubview:self.assistBtn];
    [self.contentView addSubview:self.seperatorLine];
}

-(void)setModel:(AddressBookFriendCellModel *)model indexPath:(NSIndexPath*)indexPath{
    _model=model;
    _indexPath=indexPath;
    self.mainLabel.text=model.mainLabelText;
    if(model.isPlatformUser){
        self.assistBtn.hidden = NO;
        [self.assistBtn setBackgroundImage:[self.class assistImageChooseWithStyle:model.assistStyle] forState:UIControlStateNormal];
        self.assistBtn.userInteractionEnabled=model.assistStyle==AddressBookFriendCellAssistNotFinished;
    }else{
        self.assistBtn.hidden = YES;
    }
}

+(UIImage*)assistImageChooseWithStyle:(AddressBookFriendCellAssistStyle)style{
    NSString* imageName;
    switch (style) {
        case AddressBookFriendCellAssistIsFinished:
            imageName=@"已添加带字";
            break;
        case AddressBookFriendCellAssistNotFinished:
            imageName=@"加好友带字";
            break;
        case AddressBookFriendCellAssistIsWaiting:
            imageName=@"等待验证";
            break;
    }
    return [GetImagePath getImagePath:imageName];
}

-(void)layoutSubviews{
    self.mainLabel.frame=CGRectMake(15, 15, CGRectGetWidth(self.mainLabel.frame), CGRectGetHeight(self.mainLabel.frame));
    self.assistBtn.center=CGPointMake(272, 25);
    self.seperatorLine.center=CGPointMake(kScreenWidth-CGRectGetWidth(self.seperatorLine.frame)*0.5, self.frame.size.height-CGRectGetHeight(self.seperatorLine.frame)*.5);
}

-(void)chooseAssistBtn{
    if ([self.delegate respondsToSelector:@selector(chooseAssistBtn:indexPath:)]) {
        [self.delegate chooseAssistBtn:self.assistBtn indexPath:self
         .indexPath];
    }
}
@end


@implementation AddressBookFriendCellModel
@end
