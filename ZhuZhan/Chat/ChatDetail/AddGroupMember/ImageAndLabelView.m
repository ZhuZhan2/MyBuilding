//
//  ImageAndLabelView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/11.
//
//

#import "ImageAndLabelView.h"
#import "EGOImageView.h"
@interface ImageAndLabelView ()
@property(nonatomic,strong)EGOImageView* imageView;
@property(nonatomic,strong)UILabel* contentLabel;
@property(nonatomic,strong)UIButton* addBtn;

@property(nonatomic,copy)NSString* imageUrl;
@property(nonatomic,copy)NSString* content;

@property(nonatomic)BOOL isAddImage;

@property(nonatomic,weak)id<ImageAndLabelViewDelegate>delegate;
@end

#define kImageWidth 57
#define kImageAndTextSpace 7
#define kLabelHeight 16
#define kTotalHeight (kImageWidth+kImageAndTextSpace+kLabelHeight)
#define kContentFont [UIFont systemFontOfSize:16]

@implementation ImageAndLabelView
+(ImageAndLabelView *)imageAndLabelViewWithImageUrl:(NSString *)imageUrl content:(NSString *)content isAddImage:(BOOL)isAddImage delegate:(id<ImageAndLabelViewDelegate>)delegate{
    ImageAndLabelView* view=[[ImageAndLabelView alloc]initWithFrame:CGRectMake(0, 0, kImageWidth, kTotalHeight)];
    view.imageUrl=imageUrl;
    view.content=content;
    view.isAddImage=isAddImage;
    view.delegate=delegate;
    [view setUp];
    
    return view;
}

-(void)setUp{
    [self addSubview:self.isAddImage?self.addBtn:self.imageView];
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

-(EGOImageView *)imageView{
    if (!_imageView) {
        _imageView=[[EGOImageView alloc]initWithPlaceholderImage:[GetImagePath getImagePath:self.isAddImage?@"添加联系人入群":@"delComment"]];
        _imageView.frame=CGRectMake(0, 0, kImageWidth, kImageWidth);
    }
    return _imageView;
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
@end
