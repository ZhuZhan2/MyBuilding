//
//  ChatToolBar.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/13.
//
//

#import "ChatToolBar.h"

@interface ChatToolBar ()<UITextViewDelegate>
@property(nonatomic,strong)UIView* seperatorLine;
@property(nonatomic,strong)UITextView* textView;

@property(nonatomic,strong)UILabel* placeLabel;

@property(nonatomic)CGFloat lastContentSizeHeight;
@end

#define kChatToolInitialHeight 51
#define kSideDistance 10
#define kChatTextViewInitialHeight 32
#define kChatTextViewWidth (kScreenWidth-2*kSideDistance)

#define seperatorLineColor RGBCOLOR(192, 187, 180)
#define backColor RGBCOLOR(242, 242, 242)

#define textFont [UIFont systemFontOfSize:14]

@implementation ChatToolBar
+(ChatToolBar*)chatToolBar{
    ChatToolBar* chatToolBar=[[ChatToolBar alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kChatToolInitialHeight)];
    [chatToolBar setUp];
    return chatToolBar;
}

-(NSInteger)maxTextCount{
    if (_maxTextCount==0) {
        _maxTextCount=NSIntegerMax;
    }
    return _maxTextCount;
}

-(NSInteger)maxTextCountInChat{
    if (_maxTextCountInChat==0) {
        _maxTextCountInChat=NSIntegerMax;
    }
    return _maxTextCountInChat;
}

-(UITextView *)textView{
    if (!_textView) {
        _textView=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, kChatTextViewWidth, kChatTextViewInitialHeight)];
        _textView.layer.cornerRadius=3;
        _textView.returnKeyType = UIReturnKeySend;
        CGFloat x=CGRectGetWidth(self.frame)*0.5;
        CGFloat y=CGRectGetHeight(self.frame)*0.5;
        _textView.center=CGPointMake(x, y);
        _textView.delegate=self;
    }
    return _textView;
}

-(UIView *)seperatorLine{
    if (!_seperatorLine) {
        _seperatorLine=[[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, 1)];
        _seperatorLine.backgroundColor=seperatorLineColor;
    }
    return _seperatorLine;
}

-(CGFloat)lastContentSizeHeight{
    if (_lastContentSizeHeight==0) {
        _lastContentSizeHeight=kChatTextViewInitialHeight;
    }
    return _lastContentSizeHeight;
}

-(void)setUp{
    self.backgroundColor=backColor;
    [self addSubview:self.seperatorLine];
    [self addSubview:self.textView];
    [self.textView addSubview:self.placeLabel];
    [self.textView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)textViewDidChange:(UITextView *)textView{
    NSInteger limitNumber=self.maxTextCount;
    NSArray *array = [UITextInputMode activeInputModes];
    if (array.count > 0) {
        UITextInputMode *textInputMode = [array firstObject];
        NSString *lang = [textInputMode primaryLanguage];
        if ([lang isEqualToString:@"zh-Hans"]) {
            if (textView.text.length != 0) {
                int a = [textView.text characterAtIndex:textView.text.length - 1];
                if( a > 0x4e00 && a < 0x9fff) { // PINYIN 手写的时候 才做处理
                    if (textView.text.length >= limitNumber) {
                        textView.text = [textView.text substringToIndex:limitNumber];
                    }
                }else{
                    if (textView.text.length >= limitNumber) {
                        textView.text = [textView.text substringToIndex:limitNumber];
                    }
                }
            }
        } else {
            if (textView.text.length >= limitNumber) {
                textView.text = [textView.text substringToIndex:limitNumber];
            }
        }
    }
    
    self.placeLabel.alpha=!textView.text.length;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSInteger limitNumber=self.maxTextCountInChat;
    NSLog(@"%d",(int)textView.text.length+(int)text.length);
    if ([text isEqualToString:@"\n"]) {
        if((int)textView.text.length+(int)text.length >limitNumber){
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:[NSString stringWithFormat:@"不能超过%d个字",(int)limitNumber] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }else{
            if ([self.delegate respondsToSelector:@selector(chatToolSendBtnClickedWithContent:)]) {
                [self.delegate chatToolSendBtnClickedWithContent:textView.text];
            }
            textView.text=@"";
            [self textViewDidChange:textView];
            [textView resignFirstResponder];
        }
        return NO;
    }else{
        return YES;
    }
}

-(UILabel *)placeLabel{
    if (!_placeLabel) {
        NSString* placeText=[NSString stringWithFormat:@"请输入内容..."];
        CGFloat height=CGRectGetHeight(self.textView.frame);
        _placeLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 200, height)];
        
        _placeLabel.font=textFont;
        _placeLabel.textColor=AllNoDataColor;
        _placeLabel.text=placeText;
        _placeLabel.backgroundColor=[UIColor clearColor];
    }
    return _placeLabel;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if (object==self.textView) {
        NSLog(@"change==%lf,%lf",self.textView.frame.size.height,self.textView.contentSize.height);
        [self updateFrames];
    }
}

-(void)updateFrames{
    static CGFloat const orginContentSizeHeight=kChatTextViewInitialHeight;
    //NSLog(@"orginContentSizeHeight==%lf,lastContentSizeHeight==%lf",orginContentSizeHeight,self.lastContentSizeHeight);
    CGFloat extraContentHeight=self.textView.contentSize.height-self.lastContentSizeHeight;
    if (extraContentHeight<=5&&extraContentHeight>=-5) {
        return;
    }else{
        self.lastContentSizeHeight=self.textView.contentSize.height;
    }
    
    CGFloat lineTextHeight=textFont.lineHeight;
    CGFloat lineSpaceHeight=4;
    CGFloat maxSizeHeight=3*lineTextHeight+2*lineSpaceHeight;
    
    CGFloat extraHeight=self.textView.contentSize.height-orginContentSizeHeight;
    
    if (self.textView.contentSize.height>maxSizeHeight) {
        extraHeight=maxSizeHeight-orginContentSizeHeight;
    }
    //NSLog(@"extraHeight==%lf",extraHeight);
    
    {
        CGFloat leftDownHeight=CGRectGetMaxY(self.frame);
        CGFloat needHeight=kChatToolInitialHeight+extraHeight;
        CGRect frame=self.frame;
        frame.origin.y=leftDownHeight-needHeight;
        frame.size.height=needHeight;
        self.frame=frame;
    }
    
    {
        CGFloat needHeight=kChatTextViewInitialHeight+extraHeight;
        CGRect frame=self.textView.frame;
        frame.size.height=needHeight;
        self.textView.frame=frame;
    }
    
    if ([self.delegate respondsToSelector:@selector(chatToolBarSizeChangeWithHeight:)]) {
        [self.delegate chatToolBarSizeChangeWithHeight:CGRectGetHeight(self.frame)];
    }
}

+(CGFloat)orginChatToolBarHeight{
    return kChatToolInitialHeight;
}

-(void)dealloc{
    [self.textView removeObserver:self forKeyPath:@"contentSize"];
}
@end
