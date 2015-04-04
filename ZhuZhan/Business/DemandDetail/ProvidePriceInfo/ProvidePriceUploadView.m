//
//  ProvidePriceUploadView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/20.
//
//

#import "ProvidePriceUploadView.h"
#import "RKMuchImageViews.h"
#import "RKPointKit.h"
@interface ProvidePriceUploadView ()
@property(nonatomic,strong)UIView* btnsView;
@property(nonatomic,strong)UILabel* remindLabel;
@property(nonatomic,strong)RKMuchImageViews* priceMuchImage;
@property(nonatomic,strong)RKMuchImageViews* qualityMuchImage;
@property(nonatomic,strong)RKMuchImageViews* otherMuchImage;

@property(nonatomic,strong)NSArray* array1;
@property(nonatomic,strong)NSArray* array2;
@property(nonatomic,strong)NSArray* array3;

@property(nonatomic)CGFloat maxWidth;

@property(nonatomic)CGFloat topDistance;
@property(nonatomic)CGFloat bottomDistance;

@property(nonatomic,weak)id<ProvidePriceUploadViewDelegate>delegate;
@end

@implementation ProvidePriceUploadView
+(ProvidePriceUploadView*)uploadViewWithFirstAccessory:(NSArray*)firstAccessory secondAccessory:(NSArray*)secondAccessory thirdAccessory:(NSArray*)thirdAccessory maxWidth:(CGFloat)maxWidth topDistance:(CGFloat)topDistance bottomDistance:(CGFloat)bottomDistance delegate:(id<ProvidePriceUploadViewDelegate>)delegate{
    ProvidePriceUploadView* view=[[ProvidePriceUploadView alloc]initWithFrame:CGRectZero];
    view.array1=firstAccessory;
    view.array2=secondAccessory;
    view.array3=thirdAccessory;
    view.maxWidth=maxWidth;
    view.topDistance=topDistance;
    view.bottomDistance=bottomDistance;
    view.delegate=delegate;
    [view setUp];
    return view;
}

-(NSArray*)editCenters{
    NSMutableArray* editCenters=[NSMutableArray array];
    NSArray* muchImages=@[self.priceMuchImage,self.qualityMuchImage,self.otherMuchImage];
    for (RKMuchImageViews* muchImageView in muchImages) {
        CGPoint point=muchImageView.frame.origin;
        NSArray* subPoints=[muchImageView editCenters];
        NSArray* points=[RKPointKit point:point addSubPoints:subPoints];
//        NSLog(@"subPoints=%@",subPoints);
        [editCenters addObject:points];
    }
//    NSLog(@"editCenters=%@",editCenters);
    return editCenters;
}

-(void)setUp{
    [self addSubview:self.btnsView];
    [self addSubview:self.remindLabel];
    [self addSubview:self.priceMuchImage];
    [self addSubview:self.qualityMuchImage];
    [self addSubview:self.otherMuchImage];
    
    CGFloat height=self.topDistance;
    CGRect frame;
    
    frame=self.btnsView.frame;
    frame.origin.y=height;
    self.btnsView.frame=frame;
    height+=CGRectGetHeight(self.btnsView.frame);
    
    height+=10;
    frame=self.remindLabel.frame;
    frame.origin.y=height;
    self.remindLabel.frame=frame;
    height+=CGRectGetHeight(self.remindLabel.frame);
    
    if (self.array1.count) {
        height+=24;
        frame=self.priceMuchImage.frame;
        frame.origin.y=height;
        self.priceMuchImage.frame=frame;
        height+=CGRectGetHeight(self.priceMuchImage.frame);
    }else{
        self.priceMuchImage.hidden=YES;
    }
    
    if (self.array2.count) {
        height+=24;
        frame=self.qualityMuchImage.frame;
        frame.origin.y=height;
        self.qualityMuchImage.frame=frame;
        height+=CGRectGetHeight(self.qualityMuchImage.frame);
    }else{
        self.qualityMuchImage.hidden=YES;
    }
    
    if (self.array3.count) {
        height+=24;
        frame=self.otherMuchImage.frame;
        frame.origin.y=height;
        self.otherMuchImage.frame=frame;
        height+=CGRectGetHeight(self.otherMuchImage.frame);
    }else{
        self.otherMuchImage.hidden=YES;
    }
    
    height+=self.bottomDistance;
    
    self.frame=CGRectMake(0, 0, self.maxWidth, height);
}

-(void)uploadBtnClicked:(UIButton*)btn{
    if ([self.delegate respondsToSelector:@selector(upLoadBtnClickedWithNumber:)]) {
        [self.delegate upLoadBtnClickedWithNumber:btn.tag];
    }
}
/*
 @property(nonatomic,strong)UIView* btnsView;
 @property(nonatomic,strong)UILabel* remindLabel;
 @property(nonatomic,strong)RKMuchImageViews* priceMuchImage;
 @property(nonatomic,strong)RKMuchImageViews* qualityMuchImage;
 @property(nonatomic,strong)RKMuchImageViews* otherMuchImage;
 */
//交易_上传报价 交易_上传附件 交易_上传资质
-(UIView *)btnsView{
    if (!_btnsView) {
        CGFloat height=26;
        _btnsView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.maxWidth, height)];
        NSArray* btnImageNames=@[@"交易_上传报价",@"交易_上传资质",@"交易_上传附件"];
        CGFloat width=75;
        CGFloat space=(self.maxWidth-3*width)/2;
        for (int i=0; i<btnImageNames.count; i++) {
            UIButton* imageBtn=[[UIButton alloc]initWithFrame:CGRectMake(i*(width+space), 0, width, height)];
            imageBtn.tag=i;
            [imageBtn addTarget:self action:@selector(uploadBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [imageBtn setBackgroundImage:[GetImagePath getImagePath:btnImageNames[i]] forState:UIControlStateNormal];
            [_btnsView addSubview:imageBtn];
        }
    }
    return _btnsView;
}

-(UILabel *)remindLabel{
    if (!_remindLabel) {
        _remindLabel=[[UILabel alloc]initWithFrame:CGRectZero];
        _remindLabel.text=@"报价仅限PNG、JPG格式，单个文件大小不可超过5MB。";
        _remindLabel.font=[UIFont systemFontOfSize:13];
        _remindLabel.numberOfLines=0;
        _remindLabel.textColor=AllLightGrayColor;
        CGSize size=[self carculateSizeWithLabel:_remindLabel];
        _remindLabel.frame=CGRectMake(0, 0, size.width, size.height);
    }
    return _remindLabel;
}
/*
 @property(nonatomic,strong)RKMuchImageViews* priceMuchImage;
 @property(nonatomic,strong)RKMuchImageViews* qualityMuchImage;
 @property(nonatomic,strong)RKMuchImageViews* otherMuchImage;
 */
-(RKMuchImageViews *)priceMuchImage{
    if (!_priceMuchImage) {
        _priceMuchImage=[RKMuchImageViews muchImageViewsWithWidth:self.maxWidth title:@"报价附件" isAskPrice:NO];
        [_priceMuchImage setModels:self.array1];
    }
    return _priceMuchImage;
}

-(RKMuchImageViews *)qualityMuchImage{
    if (!_qualityMuchImage) {
        _qualityMuchImage=[RKMuchImageViews muchImageViewsWithWidth:self.maxWidth title:@"资质附件" isAskPrice:NO];
        [_qualityMuchImage setModels:self.array2];
    }
    return _qualityMuchImage;
}

-(RKMuchImageViews *)otherMuchImage{
    if (!_otherMuchImage) {
        _otherMuchImage=[RKMuchImageViews muchImageViewsWithWidth:self.maxWidth title:@"其他附件" isAskPrice:NO];
        [_otherMuchImage setModels:self.array3];
    }
    return _otherMuchImage;
}

-(CGSize)carculateSizeWithLabel:(UILabel*)label{
    CGSize size=[label.text boundingRectWithSize:CGSizeMake(self.maxWidth, 99999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label.font} context:nil].size;
    return size;
}
@end
