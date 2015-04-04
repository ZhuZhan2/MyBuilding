//
//  DemandDetailViewCell.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/18.
//
//

#import "DemandDetailViewCell.h"
#import "RKMuchImageViews.h"
#import "RKShadowView.h"
@interface DemandDetailViewCell ()<RKMuchImageViewsDelegate>
@property(nonatomic,strong)UILabel* userNamelabel;
@property(nonatomic,strong)UILabel* userDescribelabel;
@property(nonatomic,strong)UILabel* timelabel;
@property(nonatomic,strong)UILabel* numberDescribelabel;
@property(nonatomic,strong)UILabel* contentLabel;
@property(nonatomic,strong)RKMuchImageViews* muchImageView1;
@property(nonatomic,strong)RKMuchImageViews* muchImageView2;
@property(nonatomic,strong)RKMuchImageViews* muchImageView3;
@property(nonatomic,strong)UIView* seperatorLine;

@property(nonatomic,strong)UIButton* leftBtn;
@property(nonatomic,strong)UIButton* rightBtn;
@property(nonatomic)DemandControllerCategory category;
@end
#define Font(size) [UIFont systemFontOfSize:size]
#define SideDistance 26
#define ContentWidth (kScreenWidth-2*SideDistance)
@implementation DemandDetailViewCell
+(CGFloat)carculateTotalHeightWithModel:(DemandDetailCellModel *)model{
    CGFloat height=15;
    CGRect frame;
    CGSize size;
    
    size=[DemandDetailViewCell carculateLabelWithText:model.userName font:Font(16) width:ContentWidth];
    frame=CGRectMake(0, height, size.width, size.height);
    height+=CGRectGetHeight(frame);
    
    height+=2;
    size=[DemandDetailViewCell carculateLabelWithText:model.userDescribe font:Font(13) width:ContentWidth];
    frame=CGRectMake(0, height, size.width, size.height);
    height+=CGRectGetHeight(frame);
    
    height+=4;
    size=[DemandDetailViewCell carculateLabelWithText:model.time font:Font(14) width:ContentWidth];
    frame=CGRectMake(0, height, size.width, size.height);
    height+=CGRectGetHeight(frame);
    
    height+=13;
    size=[DemandDetailViewCell carculateLabelWithText:model.content font:Font(14) width:ContentWidth];
    frame=CGRectMake(0, height, size.width, size.height);
    height+=CGRectGetHeight(frame);
    
    height+=15;
    size=[RKMuchImageViews carculateTotalHeightWithModels:model.array1 width:ContentWidth];
    frame=CGRectMake(0, height, size.width, size.height);
    height+=CGRectGetHeight(frame);
    
    height+=17;
    size=[RKMuchImageViews carculateTotalHeightWithModels:model.array2 width:ContentWidth];
    frame=CGRectMake(0, height, size.width, size.height);
    height+=CGRectGetHeight(frame);
    
    height+=17;
    size=[RKMuchImageViews carculateTotalHeightWithModels:model.array3 width:ContentWidth];
    frame=CGRectMake(0, height, size.width, size.height);
    height+=CGRectGetHeight(frame);
    
    height+=19;
    size=CGSizeMake(72, 26);
    frame=CGRectMake(0, height, size.width, size.height);
    height+=CGRectGetHeight(frame);
    
    height+=18;
    size=CGSizeMake(kScreenWidth, 10);
    frame=CGRectMake(0, height, size.width, size.height);
    height+=CGRectGetHeight(frame);
    return height;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier delegate:(id<DemandDetailViewCellDelegate>)delegate category:(DemandControllerCategory)category{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.delegate=delegate;
        self.category=category;
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

-(UILabel *)numberDescribelabel{
    if (!_numberDescribelabel) {
        _numberDescribelabel=[[UILabel alloc]initWithFrame:CGRectZero];
        _numberDescribelabel.numberOfLines=0;
        _numberDescribelabel.font=Font(14);
        _numberDescribelabel.textColor=BlueColor;
        //_numberDescribelabel.backgroundColor=[UIColor greenColor];

    }
    return _numberDescribelabel;
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
-(RKMuchImageViews *)muchImageView1{
    if (!_muchImageView1) {
        _muchImageView1=[RKMuchImageViews muchImageViewsWithWidth:ContentWidth title:@"报价附件" isAskPrice:YES];
        _muchImageView1.delegate = self;
    }
    return _muchImageView1;
}
-(RKMuchImageViews *)muchImageView2{
    if (!_muchImageView2) {
        _muchImageView2=[RKMuchImageViews muchImageViewsWithWidth:ContentWidth title:@"资质附件" isAskPrice:YES];
        _muchImageView2.delegate = self;
    }
    return _muchImageView2;
}
-(RKMuchImageViews *)muchImageView3{
    if (!_muchImageView3) {
        _muchImageView3=[RKMuchImageViews muchImageViewsWithWidth:ContentWidth title:@"其他附件" isAskPrice:YES];
        _muchImageView3.delegate = self;
    }
    return _muchImageView3;
}

-(UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 72, 26)];
        [_leftBtn addTarget:self action:@selector(leftBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

-(UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 72, 26)];
        [_rightBtn addTarget:self action:@selector(rightBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

-(UIView *)seperatorLine{
    if (!_seperatorLine) {
        _seperatorLine=[RKShadowView seperatorLineShadowViewWithHeight:10];
    }
    return _seperatorLine;
}

-(void)setUp{
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.userNamelabel];
    [self.contentView addSubview:self.userDescribelabel];
    [self.contentView addSubview:self.timelabel];
    [self.contentView addSubview:self.numberDescribelabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.muchImageView1];
    [self.contentView addSubview:self.muchImageView2];
    [self.contentView addSubview:self.muchImageView3];
    [self.contentView addSubview:self.leftBtn];
    [self.contentView addSubview:self.rightBtn];
    [self.contentView addSubview:self.seperatorLine];
}

-(void)setModel:(DemandDetailCellModel *)model{
    _model=model;
    [self reloadAll];
}

-(void)reloadAll{
    CGFloat height=15;
    CGFloat distance=SideDistance;
    CGRect frame;
    CGSize size;
    
    self.userNamelabel.text=self.model.userName;
    size=[DemandDetailViewCell carculateLabel:self.userNamelabel width:ContentWidth];
    frame=CGRectMake(distance, height, size.width, size.height);
    self.userNamelabel.frame=frame;
    height+=CGRectGetHeight(self.userNamelabel.frame);
    
    height+=2;
    self.userDescribelabel.text=self.model.userDescribe;
    size=[DemandDetailViewCell carculateLabel:self.userDescribelabel width:ContentWidth];
    frame=CGRectMake(distance, height, size.width, size.height);
    self.userDescribelabel.frame=frame;
    height+=CGRectGetHeight(self.userDescribelabel.frame);

    height+=4;
    self.timelabel.text=self.model.time;
    size=[DemandDetailViewCell carculateLabel:self.timelabel width:ContentWidth];
    frame=CGRectMake(distance, height, size.width, size.height);
    self.timelabel.frame=frame;

    self.numberDescribelabel.text=self.model.numberDescribe;
    size=[DemandDetailViewCell carculateLabel:self.numberDescribelabel width:ContentWidth];
    frame=CGRectMake(CGRectGetMaxX(self.timelabel.frame)+5, height, size.width, size.height);
    self.numberDescribelabel.frame=frame;
    height+=CGRectGetHeight(self.numberDescribelabel.frame);

    height+=13;
    self.contentLabel.text=self.model.content;
    size=[DemandDetailViewCell carculateLabel:self.contentLabel width:ContentWidth];
    frame=CGRectMake(distance, height, size.width, size.height);
    self.contentLabel.frame=frame;
    height+=CGRectGetHeight(self.contentLabel.frame);

    height+=15;
    self.muchImageView1.models=self.model.array1;
    size=[RKMuchImageViews carculateTotalHeightWithModels:self.model.array1 width:ContentWidth];
    frame=CGRectMake(distance, height, size.width, size.height);
    self.muchImageView1.frame=frame;
    height+=CGRectGetHeight(self.muchImageView1.frame);

    height+=17;
    self.muchImageView2.models=self.model.array2;
    size=[RKMuchImageViews carculateTotalHeightWithModels:self.model.array2 width:ContentWidth];
    frame=CGRectMake(distance, height, size.width, size.height);
    self.muchImageView2.frame=frame;
    height+=CGRectGetHeight(self.muchImageView2.frame);

    height+=17;
    self.muchImageView3.models=self.model.array3;
    size=[RKMuchImageViews carculateTotalHeightWithModels:self.model.array3 width:ContentWidth];
    frame=CGRectMake(distance, height, size.width, size.height);
    self.muchImageView3.frame=frame;
    height+=CGRectGetHeight(self.muchImageView3.frame);
    
    height+=19;
    size=self.leftBtn.frame.size;
    frame=CGRectMake(distance, height, size.width, size.height);
    self.leftBtn.frame=frame;
    
    size=self.rightBtn.frame.size;
    frame=CGRectMake(kScreenWidth-distance-size.width, height, size.width, size.height);
    self.rightBtn.frame=frame;
    height+=CGRectGetHeight(self.leftBtn.frame);
    
    height+=18;
    size=self.seperatorLine.frame.size;
    frame=CGRectMake(0, height, size.width, size.height);
    self.seperatorLine.frame=frame;
    height+=CGRectGetHeight(self.seperatorLine.frame);
    
    NSString* leftBtnImageName=self.model.isFinish?@"回复灰":@"交易_回复";
    [self.leftBtn setBackgroundImage:[GetImagePath getImagePath:leftBtnImageName] forState:UIControlStateNormal];
    self.leftBtn.userInteractionEnabled=!self.model.isFinish;
    //按钮判断
    BOOL isHasImage = self.model.array1.count?YES:NO;
    BOOL isAskPrice=self.category==DemandControllerCategoryAskPriceController;
    NSString* rightNotFinishImageName=isAskPrice?@"交易_采纳":@"报价";
    NSString* rightIsFinishImageName=isAskPrice?@"采纳灰":@"报价灰";
    NSString* rightBtnImageName =  nil;
    if(isAskPrice){
        NSLog(@"询价");
        rightBtnImageName=self.model.isFinish?rightIsFinishImageName:(isHasImage?rightNotFinishImageName:rightIsFinishImageName);
        [self.rightBtn setBackgroundImage:[GetImagePath getImagePath:rightBtnImageName] forState:UIControlStateNormal];
        self.rightBtn.enabled= self.model.isFinish?NO:(isHasImage?YES:NO);
    }else{
        NSLog(@"报价");
        rightBtnImageName=self.model.isFinish?rightIsFinishImageName:rightNotFinishImageName;
        [self.rightBtn setBackgroundImage:[GetImagePath getImagePath:rightBtnImageName] forState:UIControlStateNormal];
        self.rightBtn.enabled= !self.model.isFinish;
    }
}


-(void)leftBtnClicked{
    if ([self.delegate respondsToSelector:@selector(leftBtnClickedWithIndexPath:)]) {
        [self.delegate leftBtnClickedWithIndexPath:self.model.indexPath];
    }
}

-(void)rightBtnClicked{
    if ([self.delegate respondsToSelector:@selector(rightBtnClickedWithIndexPath:)]) {
        [self.delegate rightBtnClickedWithIndexPath:self.model.indexPath];
    }
}

+(CGSize)carculateLabel:(UILabel*)label width:(CGFloat)width{
    return [self carculateLabelWithText:label.text font:label.font width:width];
}

+(CGSize)carculateLabelWithText:(NSString*)text font:(UIFont*)font width:(CGFloat)width{
    return [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}

-(void)imageCilckWithRKMuchImageViews:(NSString *)imageUrl{
    if ([self.delegate respondsToSelector:@selector(imageCilckWithDemandDetailViewCell:)]) {
        [self.delegate imageCilckWithDemandDetailViewCell:imageUrl];
    }
}
@end
@implementation DemandDetailCellModel
@end
