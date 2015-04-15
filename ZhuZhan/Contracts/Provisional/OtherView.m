//
//  OtherView.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/30.
//
//

#import "OtherView.h"
#import "EndEditingGesture.h"
#import "RKShadowView.h"
@implementation OtherView
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self addSubview:self.textView];
        [EndEditingGesture addGestureToView:self];
    }
    return self;
}

-(MessageTextView *)textView{
    if(!_textView){
        _textView = [[MessageTextView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
        _textView.placeHolder = @"请输入合同主要条款";
        _textView.delegate = self;
        _textView.backgroundColor = [UIColor clearColor];
    }
    return _textView;
}

-(void)GetHeightWithBlock:(void (^)(double))block titleStr:(NSString *)titleStr{
    __block int height = 0;
    height = self.textView.frame.size.height;
    if(block){
        block(height);
    }
}

-(void)GetHeightOverWithBlock:(void (^)(double height))block titleStr:(NSString *)titleStr contentStr:(NSString *)contentStr{
    __block int height = 0;
    if(contentStr != nil){
        CGRect bounds=[contentStr boundingRectWithSize:CGSizeMake(280, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(26, 42, 240, bounds.size.height)];
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines =0;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.font = [UIFont systemFontOfSize:16];
        label.text = contentStr;
        [self addSubview:label];
        height = 52+bounds.size.height;
    }
    if(block){
        block(height);
    }
}

+ (CGFloat)maxHeight {
    return ([OtherView maxLines] + 1.0f) * 36;
}

+ (CGFloat)maxLines {
    return ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) ? 3.0f : 8.0f;
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    [textView becomeFirstResponder];
    if ([self.delegate respondsToSelector:@selector(textViewDidBeginEditing:)]) {
        [self.delegate textViewDidBeginEditing:self.textView];
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    [textView resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(textViewDidEndEditing:)]) {
        [self.delegate textViewDidEndEditing:self.textView];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        if ([self.delegate respondsToSelector:@selector(textViewDidEndEditing:)]) {
            [textView resignFirstResponder];
            [self.delegate textViewDidEndEditing:self.textView];
        }
        return NO;
    }
    return YES;
}

- (void)adjustTextViewHeightBy:(CGFloat)changeInHeight {
    // 动态改变自身的高度和输入框的高度
    CGRect prevFrame = self.textView.frame;
    
    NSUInteger numLines = MAX([self.textView numberOfLinesOfText],
                              [self.textView numberOfLines:self.textView.text]);
    
    self.textView.frame = CGRectMake(prevFrame.origin.x,
                                          prevFrame.origin.y,
                                          prevFrame.size.width,
                                          prevFrame.size.height + changeInHeight);
    
    
    self.textView.contentInset = UIEdgeInsetsMake((numLines >= 6 ? 4.0f : 0.0f),
                                                       0.0f,
                                                       (numLines >= 6 ? 4.0f : 0.0f),
                                                       0.0f);
    
    // from iOS 7, the content size will be accurate only if the scrolling is enabled.
    self.textView.scrollEnabled = YES;
    
    if (numLines >= 6) {
        CGPoint bottomOffset = CGPointMake(0.0f, self.textView.contentSize.height - self.textView.bounds.size.height);
        [self.textView setContentOffset:bottomOffset animated:YES];
        [self.textView scrollRangeToVisible:NSMakeRange(self.textView.text.length - 2, 1)];
    }
}
@end
