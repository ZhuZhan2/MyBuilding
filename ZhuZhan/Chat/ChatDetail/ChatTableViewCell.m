//
//  ChatTableViewCell.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/5.
//
//

#import "ChatTableViewCell.h"
#import "EGOImageView.h"
#import "ChatContentView.h"

@interface ChatTableViewCell ()
@property(nonatomic,strong)EGOImageView* userImageView;
@property(nonatomic,strong)UILabel* nameLabel;
@property(nonatomic,strong)UIView* seperatorLine;
@property(nonatomic,strong)ChatContentView* chatContentView;
@property(nonatomic)BOOL isSelf;
@end


#define chatNameFont [UIFont systemFontOfSize:12]
#define chatTimeFont [UIFont systemFontOfSize:12]

#define chatNameColor RGBCOLOR(138, 138, 138)
#define chatTimeColor RGBCOLOR(183, 183, 183)


@implementation ChatTableViewCell
+(CGFloat)carculateTotalHeightWithContentStr:(NSString*)contentStr isSelf:(BOOL)isSelf{
    return [self carculateChatContentLabelHeightWithContentStr:contentStr]+(isSelf?16:39);
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

-(EGOImageView *)userImageView{
    if (!_userImageView) {
        _userImageView=[[EGOImageView alloc]initWithPlaceholderImage:[GetImagePath getImagePath:@"默认主图01"]];
        _userImageView.frame=CGRectMake(0, 0, 35, 35);
        _userImageView.layer.cornerRadius=2;
        _userImageView.layer.masksToBounds=YES;
    }
    return _userImageView;
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

-(void)setUp{
    self.clipsToBounds=YES;
    [self.contentView addSubview:self.userImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.chatContentView];
    //[self.contentView addSubview:self.seperatorLine];
}

-(void)setModel:(ChatModel *)chatModel{
    _model=chatModel;
    
    self.nameLabel.text=chatModel.userNameStr;
    [self.chatContentView setText:chatModel.chatContent isSelf:chatModel.isSelf];
    self.isSelf=chatModel.isSelf;
}

-(void)layoutSubviews{
    CGFloat userImageDistanceFromSide=14+self.userImageView.frame.size.width*0.5;
    self.userImageView.center=CGPointMake((self.model.isSelf?kScreenWidth-userImageDistanceFromSide:userImageDistanceFromSide), 8+self.userImageView.frame.size.height*0.5);

    self.nameLabel.alpha=!self.model.isSelf;
    if (self.nameLabel.alpha) {
        self.nameLabel.frame=CGRectMake(57, 8, 250, 15);
    }
    
    CGFloat chatMaxWidth=self.chatContentView.maxWidth;
    CGFloat chatSideDistance=(kScreenWidth-chatMaxWidth)*0.5;
    CGFloat chatContentViceCenterX=self.isSelf?(kScreenWidth-chatSideDistance-self.chatContentView.frame.size.width*0.5):(chatSideDistance+self.chatContentView.frame.size.width*0.5);
    CGFloat chatContentViceCenterY=8+self.nameLabel.frame.origin.y+self.nameLabel.frame.size.height+self.chatContentView.frame.size.height*.5;
    self.chatContentView.center=CGPointMake(chatContentViceCenterX, chatContentViceCenterY);
    
    self.seperatorLine.frame=CGRectMake(0, self.frame.size.height-1, kScreenWidth, 1);
}
@end
