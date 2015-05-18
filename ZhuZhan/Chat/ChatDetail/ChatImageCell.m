//
//  ChatImageCell.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/5/15.
//
//

#import "ChatImageCell.h"

@implementation ChatImageCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.userHeadBtn];
        [self.contentView addSubview:self.userNameLabel];
    }
    return self;
}

-(void)layoutSubviews{
    CGFloat topDistance=8+CGRectGetHeight(self.timeLabel.frame);
    
    CGFloat userImageDistanceFromSide=14+self.userHeadBtn.frame.size.width*0.5;
    self.userHeadBtn.center=CGPointMake((self.isSelf?kScreenWidth-userImageDistanceFromSide:userImageDistanceFromSide), topDistance+self.userHeadBtn.frame.size.height*0.5);
    
    self.userNameLabel.alpha=!self.isSelf;
    self.userNameLabel.frame=self.userNameLabel.alpha?CGRectMake(57, topDistance, 250, 15):CGRectZero;
    
    CGFloat chatSideDistance=(kScreenWidth-100)*0.5;
    CGFloat chatContentViceCenterX=self.isSelf?(kScreenWidth-chatSideDistance-self.messageImageView.frame.size.width*0.5)+55:(chatSideDistance+self.messageImageView.frame.size.width*0.5)-55;
    CGFloat chatContentViceCenterY=topDistance+(self.userNameLabel.alpha?8+CGRectGetHeight(self.userNameLabel.frame):0)+self.messageImageView.frame.size.height*.5;
    self.messageImageView.center=CGPointMake(chatContentViceCenterX, chatContentViceCenterY);
}

-(UILabel *)timeLabel{
    if(!_timeLabel){
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.textColor = AllLightGrayColor;
        _timeLabel.font = [UIFont systemFontOfSize:12];
    }
    return _timeLabel;
}

-(UIButton *)userHeadBtn{
    if(!_userHeadBtn){
        _userHeadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _userHeadBtn.frame=CGRectMake(0, 0, 35, 35);
        _userHeadBtn.layer.cornerRadius=2;
        _userHeadBtn.layer.masksToBounds=YES;
        _userHeadBtn.backgroundColor = [UIColor yellowColor];
        //[_userHeadBtn addTarget:self action:@selector(userImageBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _userHeadBtn;
}

-(UILabel *)userNameLabel{
    if(!_userNameLabel){
        _userNameLabel = [[UILabel alloc] init];
        _userNameLabel.font = [UIFont systemFontOfSize:12];
        _userNameLabel.textColor = RGBCOLOR(138, 138, 138);
    }
    return _userNameLabel;
}

-(ChatMessageImageView *)chatMessageImageView{
    if(!_chatMessageImageView){
        _chatMessageImageView = [[ChatMessageImageView alloc] initWithFrame:self.messageImageView.frame isSelf:self.isSelf];
    }
    return _chatMessageImageView;
}

-(UIImageView *)messageImageView{
    if(!_messageImageView){
        _messageImageView = [[UIImageView alloc] init];
    }
    return _messageImageView;
}

-(void)setModel:(ChatMessageModel *)model{
    CGRect frame = [self frame];
    self.isSelf = model.a_type;
    
    [self.messageImageView sd_setImageWithURL:[NSURL URLWithString:model.a_message] placeholderImage:[GetImagePath getImagePath:@"首页_16"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.imageWidth = image.size.width/2;
        self.imageHeight = image.size.height/2;
        CGRect temp = self.messageImageView.frame;
        temp.size.width = self.imageWidth;
        temp.size.height = self.imageHeight;
        self.messageImageView.frame = temp;
        
        [self.contentView addSubview:self.chatMessageImageView];
        if(!error){
            self.chatMessageImageView.image = image;
        }else{
            self.chatMessageImageView.image = [GetImagePath getImagePath:@"首页_16"];
        }
    }];
    self.timeLabel.text=model.a_time;
    [self.userHeadBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:model.a_avatarUrl] forState:UIControlStateNormal placeholderImage:[GetImagePath getImagePath:@"未设置"]];
    self.userNameLabel.text=model.a_name;
//    frame.size.height = 20 + self.userNameLabel.frame.origin.y + 15 + self.chatMessageImageView.frame.origin.y + self.chatMessageImageView.frame.size.height + 10;
//    NSLog(@"height==>%f",frame.size.height);
//    
//    self.frame = frame;
}
@end
