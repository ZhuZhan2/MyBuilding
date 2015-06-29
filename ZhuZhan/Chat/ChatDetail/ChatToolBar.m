//
//  ChatToolBar.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/13.
//
//

#import "ChatToolBar.h"

@interface ChatToolBar ()<UITextViewDelegate>
@property(nonatomic,strong)UIView* topSeperatorLine;
@property(nonatomic,strong)UIButton* addBtn;

@property(nonatomic,strong)UILabel* placeLabel;

@property(nonatomic)CGFloat lastContentSizeHeight;

@property(nonatomic)BOOL needAddBtn;
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
    return [ChatToolBar chatToolBarWithNeedAddBtn:YES];
}

+(ChatToolBar*)chatToolBarWithNeedAddBtn:(BOOL)needAddBtn{
    ChatToolBar* chatToolBar = [[ChatToolBar alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kChatToolInitialHeight)];
    chatToolBar.needAddBtn = needAddBtn;
    chatToolBar.backgroundColor = [UIColor redColor];
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
        _textView=[[UITextView alloc]initWithFrame:CGRectZero];
        _textView.layer.cornerRadius=3;
        _textView.returnKeyType = UIReturnKeySend;
        _textView.delegate=self;
        _textView.enablesReturnKeyAutomatically = YES;
        
        CGFloat x = kSideDistance;
        CGFloat height = kChatTextViewInitialHeight;
        CGFloat y=(CGRectGetHeight(self.frame)-height)/2;
        CGFloat width = kChatTextViewWidth-(self.needAddBtn?50:0);
        _textView.frame = CGRectMake(x, y, width, height);
    }
    return _textView;
}

-(UIButton *)addBtn{
    if (!_addBtn) {
        CGFloat x = CGRectGetMaxX(self.textView.frame)+15;
        CGFloat y = CGRectGetMinY(self.textView.frame)+2;
        _addBtn = [[UIButton alloc] initWithFrame:CGRectMake(x, y, 28, 28)];
        [_addBtn setImage:[GetImagePath getImagePath:@"会话－加号"] forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(addBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
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

-(UIView *)topSeperatorLine{
    if (!_topSeperatorLine) {
        _topSeperatorLine=[[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, 1)];
        _topSeperatorLine.backgroundColor=seperatorLineColor;
    }
    return _topSeperatorLine;
}

-(CGFloat)lastContentSizeHeight{
    if (_lastContentSizeHeight==0) {
        _lastContentSizeHeight=kChatTextViewInitialHeight;
    }
    return _lastContentSizeHeight;
}

-(void)setUp{
    self.backgroundColor=backColor;
    [self addSubview:self.topSeperatorLine];
    [self addSubview:self.textView];
    if (self.needAddBtn) [self addSubview:self.addBtn];
    [self.textView addSubview:self.placeLabel];
    [self.textView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)addBtnClicked{
    if ([self.delegate respondsToSelector:@selector(chatToolBarAddBtnClicked)]) {
        [self.delegate chatToolBarAddBtnClicked];
    }
}

-(void)textViewDidChange:(UITextView *)textView{
    NSInteger limitNumber=self.maxTextCount;
    NSArray *array = [UITextInputMode activeInputModes];
    if (array.count > 0) {
        UITextInputMode *textInputMode = [array firstObject];
        NSString *lang = [textInputMode primaryLanguage];
        if ([lang isEqualToString:@"zh-Hans"]) {
            if (textView.text.length != 0) {
                UITextRange *selectedRange = [textView markedTextRange];
                //获取高亮部分
                UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
                if (!position) {
                    if (textView.text.length > limitNumber) {
                        textView.text = [textView.text substringToIndex:limitNumber];
                    }
                }else{
                    
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

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if (object==self.textView) {
        NSLog(@"change==%lf,%lf",self.textView.frame.size.height,self.textView.contentSize.height);
        [self updateFrames];
    }
}

-(void)updateFrames{
    static CGFloat const orginContentSizeHeight=kChatTextViewInitialHeight-2;
    CGFloat extraContentHeight=self.textView.contentSize.height-self.lastContentSizeHeight;
    if (self.textView.contentSize.height < kChatTextViewInitialHeight - 5) {
        return;
    }
    if (extraContentHeight<=5&&extraContentHeight>=-5) {
        return;
    }else{
        self.lastContentSizeHeight=self.textView.contentSize.height;
    }
    
    CGFloat const lineTextHeight=textFont.lineHeight;
    CGFloat const lineSpaceHeight=4;
    CGFloat const maxSizeHeight=3*lineTextHeight+2*lineSpaceHeight;
    
    CGFloat extraHeight=self.textView.contentSize.height-orginContentSizeHeight;
    
    if (self.textView.contentSize.height>maxSizeHeight) {
        extraHeight=maxSizeHeight-orginContentSizeHeight;
    }
    
    {
        CGFloat leftDownHeight=CGRectGetMaxY(self.frame);
        CGFloat needHeight=kChatToolInitialHeight+extraHeight;
        CGRect frame=self.frame;
        frame.origin.y=leftDownHeight-needHeight;
        frame.size.height=needHeight;
        self.frame=frame;
    }
    
    {
        CGFloat needHeight=orginContentSizeHeight+extraHeight;
        CGRect frame=self.textView.frame;
        frame.size.height=needHeight;
        self.textView.frame=frame;
    }
    
    if ([self.delegate respondsToSelector:@selector(chatToolBarSizeChangeWithHeight:)]) {
        [self.delegate chatToolBarSizeChangeWithHeight:CGRectGetHeight(self.frame)];
    }
}

- (BOOL)canBecomeFirstResponder{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    BOOL canPerform = [super canPerformAction:action withSender:sender];
    UIPasteboard* pasteBoard = [UIPasteboard generalPasteboard];
    if (action == @selector(paste:) && pasteBoard.image) {
        canPerform = YES;
    }
    return canPerform;
}

- (void)paste:(id)sender{
    UIPasteboard* pasteBoard = [UIPasteboard generalPasteboard];
    if ([self.delegate respondsToSelector:@selector(chatToolBarImagePasted:)]) {
        [self.delegate chatToolBarImagePasted:pasteBoard.image];
    }
}


+(CGFloat)orginChatToolBarHeight{
    return kChatToolInitialHeight;
}

-(void)dealloc{
    [self.textView removeObserver:self forKeyPath:@"contentSize"];
}
@end
