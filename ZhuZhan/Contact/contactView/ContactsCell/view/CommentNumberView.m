//
//  CommentNumberView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/2.
//
//

#import "CommentNumberView.h"
#import "RKShadowView.h"
#import "RKViewFactory.h"

@interface CommentNumberView ()
@property (nonatomic)NSInteger number;

@property (nonatomic, strong)UIView* seperatorLine;
@property (nonatomic, strong)UIImageView* roundImageView;
@property (nonatomic, strong)UILabel* numberLabel;
@end

@implementation CommentNumberView

+ (CGFloat)commentNumberViewHeight{
    return 28;
}

+ (CommentNumberView *)commentNumberView{
    return [[CommentNumberView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, [self commentNumberViewHeight])];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.seperatorLine];
        [self addSubview:self.roundImageView];
        [self.roundImageView addSubview:self.numberLabel];
    }
    return self;
}

- (void)setNumber:(NSInteger)number{
    _number = number;
    
    NSString* content = [NSString stringWithFormat:@"评论 %d条",(int)number];
    self.numberLabel.text = content;
    
    CGRect frame = self.numberLabel.frame;
    frame.origin.x = 10;
    frame.size.width = [RKViewFactory autoLabelWithFont:self.numberLabel.font content:self.numberLabel.text];
    self.numberLabel.frame = frame;
    
    frame = self.roundImageView.frame;
    frame.size.width = CGRectGetWidth(self.numberLabel.frame)+20;
    frame.origin = CGPointMake(10, 7);
    self.roundImageView.frame = frame;
    
    self.seperatorLine.center = CGPointMake(kScreenWidth/2, self.roundImageView.center.y);
}

- (UIImageView *)roundImageView{
    if (!_roundImageView) {
        _roundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 23, 21)];
        UIImage* image = [GetImagePath getImagePath:@"人脉_评论数框框"];
        NSLog(@"image=%@",NSStringFromCGSize(image.size));
        image = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
        _roundImageView.image = image;
    }
    return _roundImageView;
}

- (UIView *)seperatorLine{
    if (!_seperatorLine) {
        _seperatorLine = [RKShadowView seperatorLine];
    }
    return _seperatorLine;
}

- (UILabel *)numberLabel{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 21)];
        _numberLabel.font = [UIFont systemFontOfSize:14];
        _numberLabel.textColor = RGBCOLOR(106, 106, 106);
    }
    return _numberLabel;
}
@end
