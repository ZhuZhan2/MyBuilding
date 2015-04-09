//
//  RKSingleImageView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/18.
//
//

#import "RKSingleImageView.h"
@interface RKSingleImageView()
@property (nonatomic, strong)UILabel* fileNameLabel;
@end

@implementation RKSingleImageView
+(RKSingleImageView *)singleImageViewWithImageSize:(CGSize)size model:(RKImageModel *)model isAskPrice:(BOOL)isAskPrice{
    RKSingleImageView* view=[[RKSingleImageView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    view.model = model;
    UIImage *image;
    if([model.type isEqualToString:@"xlsx"]){
        image = [GetImagePath getImagePath:@"xlsx"];
    }else if ([model.type isEqualToString:@"docx"]){
        image = [GetImagePath getImagePath:@"word"];
    }else{
        image = [GetImagePath getImagePath:@"人脉_06a2"];
    }
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:view.bounds];
    if (model.isUrl) {
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.bigImageUrl] placeholderImage:image];
    }else{
        imageView.image=model.image;
    }
    [view addSubview:imageView];
    
    if ([model.type isEqualToString:@"xlsx"]||[model.type isEqualToString:@"docx"]) {
        view.fileNameLabel.text=model.name;
        [view addSubview:view.fileNameLabel];
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = imageView.frame;
    [btn addTarget:view action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    btn.enabled = isAskPrice;
    return view;
}

-(UILabel *)fileNameLabel{
    if (!_fileNameLabel) {
        CGFloat height=18;
        CGFloat y=CGRectGetHeight(self.frame)-height;
        _fileNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, y, CGRectGetWidth(self.frame), height)];
        _fileNameLabel.font=[UIFont systemFontOfSize:12];
        _fileNameLabel.backgroundColor=[[UIColor alloc]initWithRed:0 green:0 blue:0 alpha:.8];
        _fileNameLabel.textColor=[UIColor whiteColor];
        _fileNameLabel.textAlignment=NSTextAlignmentCenter;
        _fileNameLabel.lineBreakMode=NSLineBreakByTruncatingMiddle;
    }
    return _fileNameLabel;
}

-(CGPoint)editCenter{
    CGFloat x=CGRectGetWidth(self.frame);
    CGFloat y=0;
    return CGPointMake(x, y);
}

-(void)btnAction{
    if([self.delegate respondsToSelector:@selector(imageClick:)]){
        [self.delegate imageClick:self.model];
    }
}
@end
