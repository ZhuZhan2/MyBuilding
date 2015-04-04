//
//  RKUpAndDownView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/20.
//
//

#import "RKUpAndDownView.h"
#define strCount 500
@interface RKUpAndDownView()<UITextViewDelegate>
@property(nonatomic,strong)UILabel* upLabel;
@property(nonatomic,strong)UILabel* downLabel;
@property(nonatomic,strong)UITextView* downTextView;
@property(nonatomic,strong)UILabel* placeLabel;

@property(nonatomic)CGFloat topDistance;
@property(nonatomic)CGFloat bottomDistance;
@property(nonatomic)CGFloat maxWidth;

@property(nonatomic,copy)NSString* upContent;
@property(nonatomic,copy)NSString* downContent;
@end
#define ContentFont [UIFont systemFontOfSize:15]
@implementation RKUpAndDownView
+(RKUpAndDownView*)upAndDownViewWithUpContent:(NSString*)upContent downContent:(NSString*)downContent topDistance:(CGFloat)topDistance bottomDistance:(CGFloat)bottomDistance maxWidth:(CGFloat)maxWidth{
    RKUpAndDownView* view=[[RKUpAndDownView alloc]init];
    view.topDistance=topDistance;
    view.bottomDistance=bottomDistance;
    view.maxWidth=maxWidth;
    
    view.upContent=upContent;
    view.downContent=downContent;
    [view setUp];
    return view;
}

+(RKUpAndDownView*)upAndDownTextViewWithUpContent:(NSString*)upContent topDistance:(CGFloat)topDistance bottomDistance:(CGFloat)bottomDistance maxWidth:(CGFloat)maxWidth {
    RKUpAndDownView* view=[[RKUpAndDownView alloc]init];
    view.topDistance=topDistance;
    view.bottomDistance=bottomDistance;
    view.maxWidth=maxWidth;
    
    view.upContent=upContent;
    [view setUpIsTextView];
    return view;
}
-(NSString *)textViewText{
    return self.downTextView.text;
}

-(void)setUp{
    self.upLabel.text=self.upContent;
    self.downLabel.text=self.downContent;
    
    [self addSubview:self.upLabel];
    [self addSubview:self.downLabel];
    
    
    CGFloat height=self.topDistance;
    
    CGSize size=[self carculateSizeWithLabel:self.upLabel];
    CGRect frame=self.upLabel.frame;
    frame.size=size;
    frame.origin.y=height;
    self.upLabel.frame=frame;
    height+=CGRectGetHeight(self.upLabel.frame);
    
    height+=9;
    size=[self carculateSizeWithLabel:self.downLabel];
    frame=self.downLabel.frame;
    frame.size=size;
    frame.origin.y=height;
    self.downLabel.frame=frame;
    height+=CGRectGetHeight(self.downLabel.frame);
    
    height+=self.bottomDistance;
    
    self.frame=CGRectMake(0, 0, self.maxWidth, height);
}

-(void)setUpIsTextView{
    self.upLabel.text=self.upContent;
    
    [self addSubview:self.upLabel];
    [self addSubview:self.downTextView];

    
    CGFloat height=self.topDistance;
    
    CGSize size=[self carculateSizeWithLabel:self.upLabel];
    CGRect frame=self.upLabel.frame;
    frame.size=size;
    frame.origin.y=height;
    self.upLabel.frame=frame;
    height+=CGRectGetHeight(self.upLabel.frame);
    
    height+=9;
    frame=self.downTextView.frame;
    frame.origin.y=height;
    self.downTextView.frame=frame;
    height+=CGRectGetHeight(self.downTextView.frame);
    
    height+=self.bottomDistance;
    
    self.frame=CGRectMake(0, 0, self.maxWidth, height);
}

-(CGSize)carculateSizeWithLabel:(UILabel*)label{
    CGSize size=[label.text boundingRectWithSize:CGSizeMake(self.maxWidth, 99999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label.font} context:nil].size;
    return size;
}

-(UITextView *)downTextView{
    if (!_downTextView) {
        _downTextView=[[UITextView alloc]initWithFrame:CGRectMake(-3, -3, self.maxWidth+6, 85+6)];
        _downTextView.delegate=self;
        _downTextView.returnKeyType = UIReturnKeyDone;
        [_downTextView addSubview:self.placeLabel];
    }
    return _downTextView;
}

-(UILabel *)placeLabel{
    if (!_placeLabel) {
        _placeLabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 5, 200, 20)];
        _placeLabel.textColor=AllNoDataColor;
        _placeLabel.font=ContentFont;
        _placeLabel.text=@"请输入备注（限500字并且不能含有表情）";
    }
    return _placeLabel;
}

-(UILabel *)upLabel{
    if (!_upLabel) {
        _upLabel=[[UILabel alloc]initWithFrame:CGRectZero];
        _upLabel.font=ContentFont;
        _upLabel.numberOfLines=0;
        _upLabel.textColor=BlueColor;
    }
    return _upLabel;
}

-(UILabel *)downLabel{
    if (!_downLabel) {
        _downLabel=[[UILabel alloc]initWithFrame:CGRectZero];
        _downLabel.font=ContentFont;
        _downLabel.numberOfLines=0;
        _downLabel.textColor=AllDeepGrayColor;
    }
    return _downLabel;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }else{
        return YES;
    }
    
}

-(void)textViewDidChange:(UITextView *)textView{
    NSArray *array = [UITextInputMode activeInputModes];
    if (array.count > 0) {
        UITextInputMode *textInputMode = [array firstObject];
        NSString *lang = [textInputMode primaryLanguage];
        if ([lang isEqualToString:@"zh-Hans"]) {
            if (textView.text.length != 0) {
                int a = [textView.text characterAtIndex:textView.text.length - 1];
                if( a > 0x4e00 && a < 0x9fff) { // PINYIN 手写的时候 才做处理
                    if (textView.text.length >= strCount) {
                        textView.text = [textView.text substringToIndex:strCount];
                    }
                }else{
                    if (textView.text.length >= strCount) {
                        textView.text = [textView.text substringToIndex:strCount];
                    }
                }
            }
        } else {
            if (textView.text.length >= strCount) {
                textView.text = [textView.text substringToIndex:strCount];
            }
        }
    }
    self.placeLabel.alpha=!textView.text.length;
}
@end
