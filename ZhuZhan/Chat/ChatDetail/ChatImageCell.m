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
        self.imageWidth = 100;
        self.imageHeight = 100;
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.userHeadBtn];
        [self.contentView addSubview:self.userNameLabel];
    }
    return self;
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
        _userHeadBtn.layer.cornerRadius=17.5;
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
        _chatMessageImageView = [[ChatMessageImageView alloc] initWithFrame:CGRectMake(self.chatContentViceCenterX, self.chatContentViceCenterY, self.imageWidth, self.imageHeight) isSelf:self.isSelf];
        _chatMessageImageView.userInteractionEnabled=YES;
        UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage)];
        [_chatMessageImageView addGestureRecognizer:singleTap];
        _chatMessageImageView.image = [GetImagePath getImagePath:@"默认图_沙漏"];
    }
    return _chatMessageImageView;
}


-(void)setModel:(ChatMessageModel *)model{
    [self.chatMessageImageView removeFromSuperview];
    self.chatMessageImageView = nil;
    
    self.imageWidth = model.a_imageWidth/2;
    self.imageHeight = model.a_imageHeight/2;
    
    self.isSelf = model.a_type;
    
    CGFloat topDistance=8+CGRectGetHeight(self.timeLabel.frame);
    
    CGFloat userImageDistanceFromSide=14+self.userHeadBtn.frame.size.width*0.5;
    self.userHeadBtn.center=CGPointMake((self.isSelf?kScreenWidth-userImageDistanceFromSide:userImageDistanceFromSide), topDistance+self.userHeadBtn.frame.size.height*0.5);
    
    self.userNameLabel.alpha=!self.isSelf;
    self.userNameLabel.frame=self.userNameLabel.alpha?CGRectMake(57, topDistance, 250, 15):CGRectZero;
    
    CGFloat chatSideDistance=(kScreenWidth-100)*0.5;

    
    self.chatContentViceCenterX=self.isSelf?(kScreenWidth-chatSideDistance-self.imageWidth)+55:chatSideDistance-55;
    self.chatContentViceCenterY=topDistance+(self.userNameLabel.alpha?8+CGRectGetHeight(self.userNameLabel.frame):0);
    self.timeLabel.text=model.a_time;
    
    [self.userHeadBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:model.a_avatarUrl] forState:UIControlStateNormal placeholderImage:[GetImagePath getImagePath:@"默认图_用户头像_会话头像"]];
    self.userNameLabel.text=model.a_name;
    
    [self.contentView addSubview:self.chatMessageImageView];
    if(model.a_isLocal){
        self.chatMessageImageView.image = model.a_localImage;
        self.chatMessageImageView.bigLocalImage = model.a_localBigImage;
    }else{
        [self.chatMessageImageView sd_setImageWithURL:[NSURL URLWithString:model.a_message] placeholderImage:nil];
        self.chatMessageImageView.imageId = model.a_fileId;
        self.chatMessageImageView.bigImageUrl = model.a_bigImageUrl;
    }
    self.chatMessageImageView.isLocal = model.a_isLocal;
}

-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
}

-(void)onClickImage{
    if([self.delegate respondsToSelector:@selector(gotoBigImage:)]){
        [self.delegate gotoBigImage:self.indexPath.row];
    }
}
@end
