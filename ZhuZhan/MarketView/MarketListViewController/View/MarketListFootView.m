//
//  MarketListFootView.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/6/9.
//
//

#import "MarketListFootView.h"
#import "LoginSqlite.h"
@implementation MarketListFootView

+ (CGFloat)footViewHeight{
    return 35;
}

- (id)init{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, kScreenWidth, [MarketListFootView footViewHeight]);
        [self addSubview:self.cutLine1];
        [self addSubview:self.cutLine2];
        [self addSubview:self.countLabel];
        [self addSubview:self.addFriend];
        [self addSubview:self.delBtn];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(UIImageView *)cutLine1{
    if(!_cutLine1){
        _cutLine1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
        _cutLine1.image = [GetImagePath getImagePath:@"project_cutline"];
    }
    return _cutLine1;
}

-(UIImageView *)cutLine2{
    if(!_cutLine2){
        _cutLine2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, [MarketListFootView footViewHeight]+4, 320, 1)];
        _cutLine2.image = [GetImagePath getImagePath:@"project_cutline"];
    }
    return _cutLine2;
}

-(UILabel *)countLabel{
    if(!_countLabel){
        _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 150, 20)];
        _countLabel.font = [UIFont systemFontOfSize:14];
        _countLabel.textColor = AllNoDataColor;
    }
    return _countLabel;
}

-(UIButton *)addFriend{
    if(!_addFriend){
        _addFriend = [UIButton buttonWithType:UIButtonTypeCustom];
        _addFriend.frame = CGRectMake(220, 5, 82, 29);
        [_addFriend setImage:[GetImagePath getImagePath:@"touchTA"] forState:UIControlStateNormal];
        [_addFriend addTarget:self action:@selector(addFriendAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addFriend;
}

-(UIButton *)delBtn{
    if(!_delBtn){
        _delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _delBtn.frame = CGRectMake(220, 5, 82, 29);
        [_delBtn setImage:[GetImagePath getImagePath:@"card_delete"] forState:UIControlStateNormal];
        [_delBtn addTarget:self action:@selector(delBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _delBtn;
}

-(void)setCount:(NSString *)count isSelf:(BOOL)isSelf isPersonal:(BOOL)isPersonal needBtn:(BOOL)needBtn{
    _countLabel.text = [NSString stringWithFormat:@"评论%@条",count];
    if(isSelf){
        self.addFriend.hidden = YES;
        self.delBtn.hidden = NO;
    }else{
        if([[LoginSqlite getdata:@"userType"] isEqualToString:@"Company"]){
            self.addFriend.hidden = YES;
        }else{
            if(isPersonal){
                self.addFriend.hidden = NO;
            }else{
                self.addFriend.hidden = YES;
            }
        }
        self.delBtn.hidden = YES;
    }
    
    if (!self.delBtn.hidden) {
        self.delBtn.hidden = !needBtn;
    }
}

-(void)addFriendAction{
    if([self.delegate respondsToSelector:@selector(addFriend)]){
        [self.delegate addFriend];
    }
}

-(void)delBtnAction{
    if([self.delegate respondsToSelector:@selector(delRequire)]){
        [self.delegate delRequire];
    }
}
@end
