//
//  ProductPublishController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/2.
//
//

#import "ProductPublishController.h"
#import "AppDelegate.h"
#import "HomePageViewController.h"
#import "ProductModel.h"
#import "RKCamera.h"

@interface ProductPublishController ()<UITextViewDelegate,UIActionSheetDelegate,RKCameraDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)UIButton* imageBtn;
@property(nonatomic,strong)UITextView* titleTextView;
@property(nonatomic,strong)UITextView* contentTextView;

@property(nonatomic,strong)UILabel* titlePlaceLabel;
@property(nonatomic,strong)UILabel* contentPlaceLabel;

@property(nonatomic,strong)RKCamera* cameraControl;

@property(nonatomic,weak)UIResponder* lastResponder;

@property(nonatomic,strong)UIImage* cameraImage;
@end
#define ProductTitleFont [UIFont systemFontOfSize:16]
#define ProductContentFont [UIFont systemFontOfSize:15]
#define kProductTitleNumber 18
#define kProductContentNumber 450
#define kProductLimitNumber(isContentTextView) isContentTextView?kProductContentNumber:kProductTitleNumber

@implementation ProductPublishController

-(void)setCameraImage:(UIImage *)cameraImage{
    _cameraImage=cameraImage;
    [self.imageBtn setBackgroundImage:_cameraImage?_cameraImage:[GetImagePath getImagePath:@"人脉－发布动态_03a"] forState:UIControlStateNormal];
}

-(BOOL)isContentTextView:(id)object{
    return object==self.contentTextView;
}

-(UILabel *)titlePlaceLabel{
    if (!_titlePlaceLabel) {
        NSString* placeText=[NSString stringWithFormat:@"请输入产品标题（限%d字）",kProductTitleNumber];
        _titlePlaceLabel=[self placeLabelWithContent:placeText font:ProductTitleFont];
    }
    return _titlePlaceLabel;
}

-(UILabel *)contentPlaceLabel{
    if (!_contentPlaceLabel) {
        NSString* placeText=[NSString stringWithFormat:@"请输入产品详情（限%d字）",kProductContentNumber];
        _contentPlaceLabel=[self placeLabelWithContent:placeText font:ProductContentFont];
    }
    return _contentPlaceLabel;
}

-(UILabel*)placeLabelWithContent:(NSString*)content font:(UIFont*)font{
    UILabel* placeLabel=[[UILabel alloc]initWithFrame:CGRectMake(6, 8, 200, 20)];
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

-(UITextView *)titleTextView{
    if (!_titleTextView) {
        _titleTextView=[[UITextView alloc]initWithFrame:CGRectMake( 71, 64+8, 235, 75)];
        _titleTextView.textColor=BlueColor;
        _titleTextView.backgroundColor=[UIColor clearColor];
        _titleTextView.font=ProductTitleFont;
        _titleTextView.scrollEnabled=NO;
        _titleTextView.delegate=self;
        _titleTextView.returnKeyType=UIReturnKeySend;
    }
    return _titleTextView;
}

-(UITextView *)contentTextView{
    if (!_contentTextView) {
        _contentTextView=[[UITextView alloc]initWithFrame:CGRectMake( 10, 64+80, 300, 160)];
        _contentTextView.backgroundColor=[UIColor clearColor];
        _contentTextView.font=ProductContentFont;
        _contentTextView.delegate=self;
        _contentTextView.returnKeyType=UIReturnKeySend;
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
    [self.titleTextView becomeFirstResponder];
}

-(void)setUp{
    [self.view addSubview:self.imageBtn];
    [self.view addSubview:self.titleTextView];
    [self.titleTextView addSubview:self.titlePlaceLabel];
    [self.view addSubview:self.contentTextView];
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
    self.titleTextView.text=@"";
    self.contentTextView.text=@"";
    self.titlePlaceLabel.alpha=1;
    self.contentPlaceLabel.alpha=1;
    [self.titleTextView becomeFirstResponder];
    self.cameraImage=nil;
    NSLog(@"右按钮点击事件");
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    self.lastResponder=textView;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    BOOL isContentTextView=[self isContentTextView:textView];
    
    if ([@"\n" isEqualToString:text]){
        [self goToPublish];
        return NO;
    }
    
    if (range.length == 0 && textView.text.length >= (kProductLimitNumber(isContentTextView))) {
        return NO;
    }
    return YES;
}

-(void)goToPublish{
    [ProductModel AddProductInformationWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"发布成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
    } dic:@{@"productName":self.titleTextView.text,@"productDesc":self.contentTextView.text} imgData:UIImageJPEGRepresentation(self.cameraImage, 0.3) noNetWork:nil];
}

-(void)textViewDidChange:(UITextView *)textView{
    BOOL isContentTextView=[self isContentTextView:textView];
    int limitNumber=kProductLimitNumber(isContentTextView);
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
                textView.text = [textView.text substringToIndex:kProductLimitNumber(isContentTextView)];
            }
        }
    }
    
    self.titlePlaceLabel.alpha=!self.titleTextView.text.length;
    self.contentPlaceLabel.alpha=!self.contentTextView.text.length;
}

-(void)cameraBtmClicked{
    UIActionSheet* actionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"手机相册",nil];
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==actionSheet.cancelButtonIndex) return;
    self.cameraControl=[RKCamera cameraWithType:!buttonIndex allowEdit:YES deleate:self presentViewController:self.view.window.rootViewController];
}

-(void)cameraWillFinishWithImage:(UIImage *)image isCancel:(BOOL)isCancel{
    if (!isCancel) self.cameraImage=image;
    [self.lastResponder becomeFirstResponder];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if([self.delegate respondsToSelector:@selector(successAddProduct)]){
        [self.delegate successAddProduct];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
