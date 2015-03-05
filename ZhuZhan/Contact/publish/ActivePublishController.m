//
//  ActivePublishController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/3.
//
//

#import "ActivePublishController.h"
#import "AppDelegate.h"
#import "HomePageViewController.h"
@interface ActivePublishController ()<UITextViewDelegate,UIActionSheetDelegate>
@property(nonatomic,strong)UIButton* imageBtn;
@property(nonatomic,strong)UITextView* contentTextView;

@property(nonatomic,strong)UILabel* contentPlaceLabel;

@end
#define ProductContentFont [UIFont systemFontOfSize:15]
#define kProductContentNumber 150

@implementation ActivePublishController

-(UILabel *)contentPlaceLabel{
    if (!_contentPlaceLabel) {
        NSString* placeText=[NSString stringWithFormat:@"您在做什么？（限%d字）",kProductContentNumber];
        _contentPlaceLabel=[self placeLabelWithContent:placeText font:ProductContentFont];
    }
    return _contentPlaceLabel;
}

-(UILabel*)placeLabelWithContent:(NSString*)content font:(UIFont*)font{
    UILabel* placeLabel=[[UILabel alloc]initWithFrame:CGRectMake(75, 8, 200, 20)];
    placeLabel.backgroundColor=[UIColor clearColor];
    placeLabel.font=font;
    placeLabel.textColor=GrayColor;
    placeLabel.alpha=.6;
    placeLabel.text=content;
    return placeLabel;
}

-(UIButton *)imageBtn{
    if (!_imageBtn) {
        _imageBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        UIImage* image=[GetImagePath getImagePath:@"人脉－发布动态_03a"];
        _imageBtn.frame=CGRectMake(13, 64+13, image.size.width, image.size.height);
        [_imageBtn setBackgroundImage:image forState:UIControlStateNormal];
        [_imageBtn addTarget:self action:@selector(cameraBtmClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _imageBtn;
}

-(UITextView *)contentTextView{
    if (!_contentTextView) {
        _contentTextView=[[UITextView alloc]initWithFrame:CGRectMake( 8, 64+40-64, 300, 200)];
        _contentTextView.backgroundColor=[UIColor clearColor];
        _contentTextView.font=ProductContentFont;
        _contentTextView.delegate=self;
        _contentTextView.textContainer.exclusionPaths=@[[UIBezierPath bezierPathWithRect:CGRectMake(0, -24, 69, 40)]];
    }
    return _contentTextView;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    //隐藏tabBar
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarHide];
    //增加监听，当键盘出现或改变时收出消息
    //    [[NSNotificationCenter defaultCenter] addObserver:self
    //                                             selector:@selector(keyboardWillShow:)
    //                                                 name:UIKeyboardWillShowNotification
    //                                               object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //恢复tabBar
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarRestore];
    //    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(237, 237, 237);
    [self initNavi];
    [self setUp];
    [self.contentTextView becomeFirstResponder];
}

-(void)setUp{
    [self.view addSubview:self.contentTextView];
    [self.view addSubview:self.imageBtn];
    [self.contentTextView addSubview:self.contentPlaceLabel];
}

-(void)initNavi{
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 5, 25, 22)];
    [leftButton setBackgroundImage:[GetImagePath getImagePath:@"013"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    //RightButton设置属性
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, 50, 19.5)];
    [rightButton setTitle:@"清空" forState:UIControlStateNormal];
    rightButton.titleLabel.font=[UIFont systemFontOfSize:16];
    rightButton.titleLabel.textColor = [UIColor whiteColor];
    [rightButton addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    self.title = @"发布产品";
}

-(void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightBtnClick{
    self.contentTextView.text=@"";
    self.contentPlaceLabel.alpha=1;
    [self.imageBtn setBackgroundImage:[GetImagePath getImagePath:@"人脉－发布动态_03a"] forState:UIControlStateNormal];
    NSLog(@"右按钮点击事件");
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
        if ([@"\n" isEqualToString:text]){
            //[self goToPublish];
            return NO;
        }
    
    if (range.length == 0 && textView.text.length >= (kProductContentNumber)) {
        return NO;
    }
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView{
    int limitNumber=kProductContentNumber;
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
                }
            }
        } else {
            if (textView.text.length >= limitNumber) {
                textView.text = [textView.text substringToIndex:limitNumber];
            }
        }
    }
    
    self.contentPlaceLabel.alpha=!self.contentTextView.text.length;
}

-(void)cameraBtmClicked{
    UIActionSheet* actionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"手机相册",nil];
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%ld",buttonIndex);
}
@end

