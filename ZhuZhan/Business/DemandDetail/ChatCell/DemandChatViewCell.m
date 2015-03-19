//
//  DemandChatViewCell.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/19.
//
//

#import "DemandChatViewCell.h"
#import "RKShadowView.h"
@interface DemandChatViewCell ()
@property(nonatomic,strong)UILabel* userNamelabel;
@property(nonatomic,strong)UILabel* userDescribelabel;
@property(nonatomic,strong)UILabel* timelabel;
@property(nonatomic,strong)UILabel* contentLabel;

@property(nonatomic,strong)UIView* shadowView;

@property(nonatomic,strong)UIButton* leftBtn;
@property(nonatomic,strong)UIButton* rightBtn;
@end
#define Font(size) [UIFont systemFontOfSize:size]
#define SideDistance 26
#define ContentWidth (kScreenWidth-2*SideDistance)
@implementation DemandChatViewCell
+(CGFloat)carculateTotalHeightWithModel:(DemandChatViewCellModel *)model{
    CGFloat height=15;
    CGSize size;

    size=[DemandChatViewCell carculateLabelWithText:model.userName font:Font(16) width:ContentWidth];
    height+=size.height;
    
    height+=2;
    size=[DemandChatViewCell carculateLabelWithText:model.userDescribe font:Font(13) width:ContentWidth];
    height+=size.height;
    
    height+=4;
    size=[DemandChatViewCell carculateLabelWithText:model.time font:Font(14) width:ContentWidth];
    height+=size.height;
    
    height+=13;
    size=[DemandChatViewCell carculateLabelWithText:model.content font:Font(14) width:ContentWidth];
    height+=size.height;
    
    height+=18;
    size=CGSizeMake(kScreenWidth, 10);
    height+=size.height;
    return height;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
        
    }
    return self;
}
-(UILabel *)userNamelabel{
    if (!_userNamelabel) {
        _userNamelabel=[[UILabel alloc]initWithFrame:CGRectZero];
        _userNamelabel.numberOfLines=0;
        _userNamelabel.font=Font(16);
        _userNamelabel.textColor=BlueColor;
        //_userNamelabel.backgroundColor=[UIColor greenColor];
    }
    return _userNamelabel;
}

-(UILabel *)userDescribelabel{
    if (!_userDescribelabel) {
        _userDescribelabel=[[UILabel alloc]initWithFrame:CGRectZero];
        _userDescribelabel.numberOfLines=0;
        _userDescribelabel.font=Font(13);
        _userDescribelabel.textColor=AllGreenColor;
        //_userDescribelabel.backgroundColor=[UIColor greenColor];
    }
    return _userDescribelabel;
}

-(UILabel *)timelabel{
    if (!_timelabel) {
        _timelabel=[[UILabel alloc]initWithFrame:CGRectZero];
        _timelabel.numberOfLines=0;
        _timelabel.font=Font(14);
        _timelabel.textColor=AllLightGrayColor;
        //_timelabel.backgroundColor=[UIColor greenColor];
        
    }
    return _timelabel;
}

-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel=[[UILabel alloc]initWithFrame:CGRectZero];
        _contentLabel.numberOfLines=0;
        _contentLabel.font=Font(14);
        _contentLabel.textColor=AllDeepGrayColor;
        //_contentLabel.backgroundColor=[UIColor greenColor];
        
    }
    return _contentLabel;
}

-(UIView *)shadowView{
    if (!_shadowView) {
        _shadowView=[RKShadowView seperatorLineShadowViewWithHeight:10];
//        _shadowView=[RKShadowView seperatorLineShadowViewWithHeight:10];
    }
    return _shadowView;
}

-(void)setUp{
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.userNamelabel];
    [self.contentView addSubview:self.userDescribelabel];
    [self.contentView addSubview:self.timelabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.shadowView];
}

-(void)setModel:(DemandChatViewCellModel *)model{
    _model=model;
    [self reloadAll];
}

-(void)reloadAll{
    CGFloat height=15;
    CGFloat distance=SideDistance;
    CGRect frame;
    CGSize size;
    
    self.userNamelabel.text=self.model.userName;
    size=[DemandChatViewCell carculateLabel:self.userNamelabel width:ContentWidth];
    frame=CGRectMake(distance, height, size.width, size.height);
    self.userNamelabel.frame=frame;
    height+=CGRectGetHeight(self.userNamelabel.frame);
    
    height+=2;
    self.userDescribelabel.text=self.model.userDescribe;
    size=[DemandChatViewCell carculateLabel:self.userDescribelabel width:ContentWidth];
    frame=CGRectMake(distance, height, size.width, size.height);
    self.userDescribelabel.frame=frame;
    height+=CGRectGetHeight(self.userDescribelabel.frame);
    
    height+=4;
    self.timelabel.text=self.model.time;
    size=[DemandChatViewCell carculateLabel:self.timelabel width:ContentWidth];
    frame=CGRectMake(distance, height, size.width, size.height);
    self.timelabel.frame=frame;
    height+=CGRectGetHeight(self.timelabel.frame);
    
    height+=13;
    self.contentLabel.text=self.model.content;
    size=[DemandChatViewCell carculateLabel:self.contentLabel width:ContentWidth];
    frame=CGRectMake(distance, height, size.width, size.height);
    self.contentLabel.frame=frame;
    height+=CGRectGetHeight(self.contentLabel.frame);
    
    height+=18;
    size=self.shadowView.frame.size;
    frame=CGRectMake(0, height, size.width, size.height);
    self.shadowView.frame=frame;
    height+=CGRectGetHeight(self.shadowView.frame);
}

+(CGSize)carculateLabel:(UILabel*)label width:(CGFloat)width{
    return [self carculateLabelWithText:label.text font:label.font width:width];
}

+(CGSize)carculateLabelWithText:(NSString*)text font:(UIFont*)font width:(CGFloat)width{
    return [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}
@end
@implementation DemandChatViewCellModel
@end
