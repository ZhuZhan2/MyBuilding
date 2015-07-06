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
        [self.contentView addSubview:self.activityView];
        [self.contentView addSubview:self.failedBtn];
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
        _chatMessageImageView.image = [GetImagePath getImagePath:@""];
    }
    return _chatMessageImageView;
}

- (UIActivityIndicatorView *)activityView{
    if (!_activityView) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [_activityView startAnimating];
    }
    return _activityView;
}

- (UIButton *)failedBtn{
    if (!_failedBtn) {
        _failedBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [_failedBtn addTarget:self action:@selector(failBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_failedBtn setBackgroundImage:[GetImagePath getImagePath:@" icon_exclamation_mark"] forState:UIControlStateNormal];
    }
    return _failedBtn;
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
    
    CGPoint center = self.chatMessageImageView.center;
    center.x += (self.isSelf?-1:1)*(CGRectGetWidth(self.chatMessageImageView.frame)/2+15);
    self.activityView.center = center;
    self.failedBtn.center = center;
    
    __block UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.imageWidth, self.imageHeight)];
    bgImageView.contentMode = UIViewContentModeScaleAspectFit;
    bgImageView.image = [GetImagePath getImagePath:@"默认图_沙漏"];
    bgImageView.backgroundColor = RGBCOLOR(215, 215, 215);
    bgImageView.layer.masksToBounds = YES;
    bgImageView.layer.cornerRadius = 3;
    [self.chatMessageImageView addSubview:bgImageView];
    
    
    self.chatMessageImageView.messageId = model.a_id;
    if(model.a_isLocal){
        [bgImageView removeFromSuperview];
        bgImageView = nil;
        self.chatMessageImageView.image = model.a_localImage;
        NSLog(@"==>%@",model.a_localBigImageUrl);
        UIImage *img = [UIImage imageWithContentsOfFile:model.a_localBigImageUrl];
        self.chatMessageImageView.bigLocalImage = img;
    }else{
        [self.chatMessageImageView sd_setImageWithURL:[NSURL URLWithString:model.a_message] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if(!error){
                [bgImageView removeFromSuperview];
                 bgImageView = nil;
            }
        }];
        self.chatMessageImageView.imageId = model.a_fileId;
        self.chatMessageImageView.bigImageUrl = model.a_bigImageUrl;
    }
    self.chatMessageImageView.isLocal = model.a_isLocal;
    self.chatMessageImageView.messageStatus = model.messageStatus;
    
    self.activityView.alpha = model.messageStatus == ChatMessageStatusProcess;
    self.failedBtn.hidden = model.messageStatus != ChatMessageStatusFail;
}

-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
}

-(void)onClickImage{
    if([self.delegate respondsToSelector:@selector(gotoBigImage:)]){
        [self.delegate gotoBigImage:self.indexPath.row];
    }
}

- (void)failBtnClicked:(UIButton*)btn{
    if ([self.delegate respondsToSelector:@selector(failBtnClicked:indexPath:)]) {
        [self.delegate failBtnClicked:btn indexPath:self.indexPath];
    }
}
@end
