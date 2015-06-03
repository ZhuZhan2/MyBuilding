//
//  ChatTableViewCell.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/5.
//
//

#import "ChatTableViewCell.h"
#import "ChatContentView.h"

@interface ChatTableViewCell ()
@property(nonatomic,strong)UILabel* timeLine;
@property(nonatomic,strong)UIButton* userImageBtn;
@property(nonatomic,strong)UILabel* nameLabel;
@property(nonatomic,strong)UIView* seperatorLine;
@property(nonatomic,strong)ChatContentView* chatContentView;
@property(nonatomic)BOOL isSelf;
@end


#define chatNameFont [UIFont systemFontOfSize:12]
#define chatTimeFont [UIFont systemFontOfSize:12]

#define chatNameColor RGBCOLOR(138, 138, 138)
#define chatTimeColor RGBCOLOR(183, 183, 183)

#define timeLineHeight 20

@implementation ChatTableViewCell
+(CGFloat)carculateTotalHeightWithContentStr:(NSString*)contentStr isSelf:(BOOL)isSelf{
    return [self carculateChatContentLabelHeightWithContentStr:contentStr]+(isSelf?16:39)+timeLineHeight;
}

+(CGFloat)carculateChatContentLabelHeightWithContentStr:(NSString*)contentStr{
    return [ChatContentView carculateChatContentViewHeightWithContentStr:contentStr];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
    }
    return self;
}

+(UILabel *)sendTimeLabel{
    UILabel* sendTimeLabel=[[UILabel alloc]init];
    sendTimeLabel.textColor=chatTimeColor;
    sendTimeLabel.font=chatTimeFont;
    sendTimeLabel.frame=CGRectMake(0, 0, kScreenWidth, 40);
    sendTimeLabel.textAlignment=NSTextAlignmentCenter;
    return sendTimeLabel;
}

-(UIView *)seperatorLine{
    if (!_seperatorLine) {
        _seperatorLine=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
        _seperatorLine.backgroundColor=[UIColor blackColor];
    }
    return _seperatorLine;
}

-(UIButton *)userImageBtn{
    if (!_userImageBtn) {
        _userImageBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _userImageBtn.frame=CGRectMake(0, 0, 35, 35);
        _userImageBtn.layer.cornerRadius=17.5;
        _userImageBtn.layer.masksToBounds=YES;
        [_userImageBtn addTarget:self action:@selector(userImageBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _userImageBtn;
}

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel=[[UILabel alloc]init];
        _nameLabel.font=chatNameFont;
        _nameLabel.textColor=chatNameColor;
    }
    return _nameLabel;
}

-(ChatContentView *)chatContentView{
    if (!_chatContentView) {
        _chatContentView=[[ChatContentView alloc]init];
    }
    return _chatContentView;
}

-(UILabel *)timeLine{
    if (!_timeLine) {
        _timeLine=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, timeLineHeight)];
        _timeLine.textAlignment=NSTextAlignmentCenter;
        _timeLine.textColor=AllLightGrayColor;
        _timeLine.font=chatTimeFont;
    }
    return _timeLine;
}

-(void)setUp{
    self.clipsToBounds=YES;
    [self.contentView addSubview:self.timeLine];
    [self.contentView addSubview:self.userImageBtn];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.chatContentView];
    //[self.contentView addSubview:self.seperatorLine];
}

-(void)setModel:(ChatModel *)chatModel{
    _model=chatModel;
    
    self.timeLine.text=chatModel.time;
    [self.userImageBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:chatModel.userImageStr] forState:UIControlStateNormal placeholderImage:[GetImagePath getImagePath:@"默认图_用户头像_会话头像"]];
    self.nameLabel.text=chatModel.userNameStr;
    [self.chatContentView setText:chatModel.chatContent isSelf:chatModel.isSelf];
    self.isSelf=chatModel.isSelf;
}

-(void)layoutSubviews{
    CGFloat topDistance=8+CGRectGetHeight(self.timeLine.frame);
    
    CGFloat userImageDistanceFromSide=14+self.userImageBtn.frame.size.width*0.5;
    self.userImageBtn.center=CGPointMake((self.model.isSelf?kScreenWidth-userImageDistanceFromSide:userImageDistanceFromSide), topDistance+self.userImageBtn.frame.size.height*0.5);

    self.nameLabel.alpha=!self.model.isSelf;
    self.nameLabel.frame=self.nameLabel.alpha?CGRectMake(57, topDistance, 250, 15):CGRectZero;
    
    CGFloat chatMaxWidth=self.chatContentView.maxWidth;
    CGFloat chatSideDistance=(kScreenWidth-chatMaxWidth)*0.5;
    CGFloat chatContentViceCenterX=self.isSelf?(kScreenWidth-chatSideDistance-self.chatContentView.frame.size.width*0.5):(chatSideDistance+self.chatContentView.frame.size.width*0.5);
    CGFloat chatContentViceCenterY=topDistance+(self.nameLabel.alpha?8+CGRectGetHeight(self.nameLabel.frame):0)+self.chatContentView.frame.size.height*.5;
    self.chatContentView.center=CGPointMake(chatContentViceCenterX, chatContentViceCenterY);
    
    self.seperatorLine.frame=CGRectMake(0, self.frame.size.height-1, kScreenWidth, 1);
}

-(void)userImageBtnAction{
    if(!self.model.isSelf){
        if([self.delegate respondsToSelector:@selector(gotoContactDetailView:)]){
            [self.delegate gotoContactDetailView:self.model.ID];
        }
    }
}
@end
