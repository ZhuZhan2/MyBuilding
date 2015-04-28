//
//  ImageAndLabelView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/11.
//
//

#import "ImageAndLabelView.h"
#import "LoginSqlite.h"
@interface ImageAndLabelView ()
@property(nonatomic,strong)UIButton* headBtn;
@property(nonatomic,strong)UILabel* contentLabel;
@property(nonatomic,strong)UIButton* addBtn;

@property(nonatomic,copy)NSString* imageUrl;
@property(nonatomic,copy)NSString* content;
@property(nonatomic,copy)NSString *userId;

@property(nonatomic)BOOL isAddImage;

@property(nonatomic,weak)id<ImageAndLabelViewDelegate>delegate;
@end

#define kImageWidth 57
#define kImageAndTextSpace 7
#define kLabelHeight 16
#define kTotalHeight (kImageWidth+kImageAndTextSpace+kLabelHeight)
#define kContentFont [UIFont systemFontOfSize:16]

@implementation ImageAndLabelView
+(ImageAndLabelView *)imageAndLabelViewWithImageUrl:(NSString *)imageUrl content:(NSString *)content userId:(NSString *)userId isAddImage:(BOOL)isAddImage delegate:(id<ImageAndLabelViewDelegate>)delegate{
    ImageAndLabelView* view=[[ImageAndLabelView alloc]initWithFrame:CGRectMake(0, 0, kImageWidth, kTotalHeight)];
    view.imageUrl=imageUrl;
    view.content=content;
    view.isAddImage=isAddImage;
    view.userId = userId;
    view.delegate=delegate;
    [view setUp];
    
    return view;
}

-(void)setUp{
    [self addSubview:self.isAddImage?self.addBtn:self.headBtn];
    [self addSubview:self.contentLabel];
}

-(UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, kImageWidth, kImageWidth)];
        [_addBtn setBackgroundImage:[GetImagePath getImagePath:@"添加联系人入群"] forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(addImageBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}

-(UIButton *)headBtn{
    if (!_headBtn) {
        //[GetImagePath getImagePath:@"未设置"]
        _headBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_headBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:self.imageUrl]  forState:UIControlStateNormal placeholderImage:[GetImagePath getImagePath:@"未设置"]];
        [_headBtn addTarget:self action:@selector(headAction) forControlEvents:UIControlEventTouchUpInside];
#warning  图片名为"未设置"和"加载中"为对应状态的图,暂时不作区分,等接口好了再调整
        _headBtn.frame=CGRectMake(0, 0, kImageWidth, kImageWidth);
    }
    return _headBtn;
}

-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, kTotalHeight-kLabelHeight, kImageWidth, kLabelHeight)];
        _contentLabel.text=self.content;
        _contentLabel.font=kContentFont;
        _contentLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _contentLabel;
}

-(void)addImageBtnClicked{
    if ([self.delegate respondsToSelector:@selector(addImageBtnClicked)]) {
        [self.delegate addImageBtnClicked];
    }
}

-(void)headAction{
    if(![self.userId isEqualToString:[LoginSqlite getdata:@"userId"]]){
        if([self.delegate respondsToSelector:@selector(headClick:)]){
            [self.delegate headClick:self.userId];
        }
    }
}
@end
