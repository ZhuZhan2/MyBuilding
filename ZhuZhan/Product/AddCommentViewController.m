//
//  AddCommentViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 14-9-3.
//
//

#import "AddCommentViewController.h"
#import "MBProgressHUD.h"
#import "ConnectionAvailable.h"
@interface AddCommentViewController ()<UITextViewDelegate>
@property(nonatomic,strong)UILabel* countLabel;//字数label
//@property(nonatomic,strong)UILabel* aboveMaxLabel;//超过字数限制时的中文提示label
@property(nonatomic,strong)UITextView* textView;

@property(nonatomic,strong)UIButton* sureBtn;
@property(nonatomic,strong)UIButton* cancelBtn;
@end

@implementation AddCommentViewController
#define kCommentLimitNumber 300
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadSelf];
    [self initTitlePart];
    [self initTextViewPart];
    [self initTextCountPart];
}

-(void)initTextCountPart{
    UIView* separatorLine=[self getSeparatorLine];
    separatorLine.center=CGPointMake(140, self.view.frame.size.height-40);
    [self.view addSubview:separatorLine];
    
    self.countLabel=[[UILabel alloc]initWithFrame:CGRectMake(5, self.view.frame.size.height-30, 60, 20)];
    self.countLabel.text=@"0/300";
    self.countLabel.font=[UIFont systemFontOfSize:16];
    self.countLabel.textAlignment=NSTextAlignmentRight;
    self.countLabel.textColor=RGBCOLOR(155, 155, 155);
    [self.view addSubview:self.countLabel];
    
//    self.aboveMaxLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 140, 20)];
//    self.aboveMaxLabel.center=CGPointMake(167, self.view.frame.size.height-20);
//    [self.view addSubview:self.aboveMaxLabel];
    
    
}

-(void)initTextViewPart{
    CGRect frame=self.view.frame;
    frame.origin.y+=50;
    frame.size.height-=100;
    frame.origin.x+=10;
    frame.size.width-=20;
    
    self.textView=[[UITextView alloc]initWithFrame:frame];
    self.textView.delegate=self;
    self.textView.backgroundColor=[UIColor clearColor];
    self.textView.font=[UIFont systemFontOfSize:18];
    self.textView.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:self.textView];
    
    [self.textView becomeFirstResponder];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    self.countLabel.text=[NSString stringWithFormat:@"%lu/300",(unsigned long)textView.text.length];
    if (range.length == 0 && textView.text.length >= kCommentLimitNumber) {
        return NO;
    }
    return YES;
}



-(void)textViewDidChange:(UITextView *)textView{
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
                    if (textView.text.length > kCommentLimitNumber) {
                        textView.text = [textView.text substringToIndex:kCommentLimitNumber];
                    }
                }else{
                    
                }
            }
        } else {
            if (textView.text.length >= kCommentLimitNumber) {
                textView.text = [textView.text substringToIndex:kCommentLimitNumber];
            }
        }
    }

    
    //该判断用于联想输入
//    if (textView.text.length<=100) {
        self.countLabel.text=[NSString stringWithFormat:@"%lu/300",(unsigned long)textView.text.length];
        //self.aboveMaxLabel.text=nil;
//    }else{
//        self.countLabel.text=@"100/100";
//        self.aboveMaxLabel.text=[NSString stringWithFormat:@"已经超过%d字",textView.text.length-100];
//    }
}

-(void)paste:(id)sender{
    if (self.textView.text.length > kCommentLimitNumber) {
        self.textView.text = [self.textView.text substringToIndex:kCommentLimitNumber];
    }
}

-(void)initTitlePart{
    UILabel* titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
    titleLabel.center=CGPointMake(140, 19);
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.text=@"评论动态";
    titleLabel.font=[UIFont boldSystemFontOfSize:18];
    [self.view addSubview:titleLabel];
    
    self.cancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBtn.frame=CGRectMake(10, 2.5, 50, 35);
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.cancelBtn.titleLabel.font=[UIFont boldSystemFontOfSize:17];
    [self.cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cancelBtn];
    
    
    self.sureBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.sureBtn.frame=CGRectMake(220, 2.5, 50, 35);
    //self.sureBtn.backgroundColor = [UIColor redColor];
    [self.sureBtn setTitle:@"确认" forState:UIControlStateNormal];
    [self.sureBtn setTitleColor:BlueColor forState:UIControlStateNormal];
    self.sureBtn.titleLabel.font=[UIFont boldSystemFontOfSize:17];
    [self.sureBtn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.sureBtn];
    
    UIView* separatorLine=[self getSeparatorLine];
    separatorLine.center=CGPointMake(140, 40);
    [self.view addSubview:separatorLine];
}

-(void)cancel{
    if ([self.delegate respondsToSelector:@selector(cancelFromAddComment)]) {
        self.cancelBtn.enabled=NO;
        [self.delegate cancelFromAddComment];
    }
    NSLog(@"cancel");
}

-(void)sure{
    if (![ConnectionAvailable isConnectionAvailable]) {
        [MBProgressHUD myShowHUDAddedTo:self.view animated:YES];
        return;
    }
    
    NSString *str = [self.textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (!str.length) {
        UIAlertView* alertView=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"请填写评论内容" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(sureFromAddCommentWithComment:)]) {
        NSString* tempStr;
        if (self.textView.text.length>kCommentLimitNumber) {
            tempStr=[self.textView.text substringToIndex:kCommentLimitNumber];
        }else{
            tempStr=self.textView.text;
        }
        //用户确认发送之后不让用户重复点击
        self.sureBtn.enabled=NO;
        [self.delegate sureFromAddCommentWithComment:tempStr];
        NSLog(@"sure");
    }
}

//======================================================================
//======================================================================
//======================================================================

-(UIView*)getSeparatorLine{
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 280, 1)];
    view.backgroundColor=RGBCOLOR(196, 196, 196);
    return view;
}

-(void)loadSelf{
    self.view.frame = CGRectMake(0, 0, 280, 220);
    self.view.layer.masksToBounds=YES;
    self.view.backgroundColor=[[UIColor alloc]initWithRed:1 green:1 blue:1 alpha:.95];
    self.view.layer.cornerRadius=12;
}

-(void)finishNetWork{
    self.sureBtn.enabled=YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
