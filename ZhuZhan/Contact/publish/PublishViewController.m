//
//  PublishViewController.m
//  ZhuZhan
//
//  Created by Jack on 14-8-27.
//
//

#import "PublishViewController.h"
#import "AppDelegate.h"
#import "HomePageViewController.h"
#import "ProductModel.h"
#import "CommentApi.h"
#import "GTMBase64.h"
#import "LoginSqlite.h"
#import "ConnectionAvailable.h"
#import "MBProgressHUD.h"
@interface PublishViewController (){
    UILabel *leftBtnLabel;
    UILabel *rightBtnLabel;
    BOOL isPublish;
    int PublishNum;//1 发布动态  2，发布产品
}

@end
#define kPublishLimitNumber 150
@implementation PublishViewController
//@synthesize toolBar,inputView,alertLabel,leftBtnImage,rightBtnImage,publishImage,camera,publishImageStr;
@synthesize inputView,alertLabel,leftBtnImage,rightBtnImage,publishImage,camera,publishImageStr;


- (void)viewDidLoad
{
    [super viewDidLoad];
    PublishNum=1;
    self.view.backgroundColor = RGBCOLOR(237, 237, 237);
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
    [rightButton addTarget:self action:@selector(clearAll) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    self.title = @"发布";
    isFirst=NO;
    [self initInputView];
    
//    toolBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 312, 320, 40)];
//    toolBar.image = [GetImagePath getImagePath:@"人脉－发布动态_15a"];
//    toolBar.userInteractionEnabled = YES;
//    [self.view addSubview:toolBar];

    UIButton *textBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    textBtn.frame = CGRectMake(0, 0, 158, 40);
    leftBtnImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 11.5, 19, 17)];
    leftBtnImage.image = [GetImagePath getImagePath:@"人脉－发布动态_09a"];
    leftBtnImage.userInteractionEnabled = YES;
    [textBtn addSubview:leftBtnImage];
    leftBtnLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 100, 30)];
    leftBtnLabel.text = @"想说些什么...";
    leftBtnLabel.textColor=[UIColor blackColor];
    [textBtn addSubview:leftBtnLabel];
    
    [textBtn addTarget:self action:@selector(publshActivities) forControlEvents:UIControlEventTouchUpInside];
    //[toolBar addSubview:textBtn];
    
    UIButton *photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    photoBtn.frame = CGRectMake(162, 0, 160, 40);
    rightBtnImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 11.5, 19, 17)];
    rightBtnImage.image = [GetImagePath getImagePath:@"人脉－发布动态_13a"];
    rightBtnImage.userInteractionEnabled = YES;
    [photoBtn addSubview:rightBtnImage];
    rightBtnLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 100, 30)];
    rightBtnLabel.text = @"产品信息";
    rightBtnLabel.textColor=RGBCOLOR(192, 192, 192);
    [photoBtn addSubview:rightBtnLabel];
    [photoBtn addTarget:self action:@selector(publshProduct) forControlEvents:UIControlEventTouchUpInside];
    //[toolBar addSubview:photoBtn];
    
    leftBtnImage.image = [GetImagePath getImagePath:@"人脉－发布动态_07a"];
    rightBtnImage.image = [GetImagePath getImagePath:@"人脉－发布动态_13a"];
    publishImageStr =@"";
}

static BOOL isFirst;
-(void)initInputView{
    inputView = [[UITextView alloc] initWithFrame:CGRectMake(15, 42-24+(isFirst?64:0), 290, 220+84-(isFirst?64:0))];
    isFirst=YES;
    UIEdgeInsets tempInsets=inputView.textContainerInset;
    inputView.textContainerInset=UIEdgeInsetsMake(tempInsets.top+24, tempInsets.left, tempInsets.bottom, tempInsets.right);
    inputView.delegate = self;
    inputView.backgroundColor=[UIColor clearColor];
    inputView.returnKeyType = UIReturnKeySend;
    inputView.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:inputView];
    [inputView becomeFirstResponder];
    
    alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(57, 4+24, 220, 30)];
    alertLabel.text = [NSString stringWithFormat:@"您在做什么?（限%d字）",kPublishLimitNumber];
    alertLabel.textColor = GrayColor;
    alertLabel.alpha = 0.6;
    alertLabel.textAlignment =NSTextAlignmentLeft;
    [inputView addSubview:alertLabel];
    
    publishImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, -24+24, 52, 52)];
    publishImage.image = [GetImagePath getImagePath:@"人脉－发布动态_03a"];
    publishImage.userInteractionEnabled =YES;
    [inputView addSubview:publishImage];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(beginToAddImage)];
    [publishImage addGestureRecognizer:tap];
    inputView.textContainer.exclusionPaths=@[[UIBezierPath bezierPathWithRect:CGRectMake(0, -24, 52, 40)]];
}

-(void)clearInputView{
    [inputView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    alertLabel=nil;
    publishImage=nil;
    inputView=nil;
}

-(void)inputViewGetNew{
    [self clearInputView];
    [self initInputView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    //隐藏tabBar
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarHide];
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //恢复tabBar
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarRestore];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    //NSDictionary *userInfo = [aNotification userInfo];
    //NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    //CGRect keyboardRect = [aValue CGRectValue];
    //int height = keyboardRect.size.height;
    //toolBar.frame =CGRectMake(0, kScreenHeight-height-40, 320, 40);
}


-(void)beginToAddImage
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"手机相册", nil];
    [actionSheet showInView:self.view.superview];
}

-(void)publshActivities
{
    PublishNum =1;
    NSLog(@"想说些什么");
    NSLog(@"%@",NSStringFromCGRect([inputView.subviews[0] frame]));
    leftBtnImage.image = [GetImagePath getImagePath:@"人脉－发布动态_07a"];
    rightBtnImage.image = [GetImagePath getImagePath:@"人脉－发布动态_13a"];
    leftBtnLabel.textColor=[UIColor blackColor];
    rightBtnLabel.textColor=RGBCOLOR(192, 192, 192);
}

-(void)publshProduct{
    PublishNum =2;
  NSLog(@"发布产品信息");
    leftBtnImage.image = [GetImagePath getImagePath:@"人脉－发布动态_09a"];
    rightBtnImage.image = [GetImagePath getImagePath:@"人脉－发布动态_11a"];
    rightBtnLabel.textColor=[UIColor blackColor];
    leftBtnLabel.textColor=RGBCOLOR(192, 192, 192);
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    [inputView resignFirstResponder];
    camera = [[Camera alloc] init];
    camera.delegate = self;
    [self.view addSubview:camera.view];
    [camera modifyUserIconWithButtonIndex:buttonIndex WithButtonTag:110120];
}

-(void)publishImage:(NSString *)imageStr andImage:(UIImage *)image imageData:(NSData *)imageData;
{
    [inputView becomeFirstResponder];
    publishImageStr = imageStr;
    publishImage.image = image;
    
}

-(void)openKeyBoard
{
    [inputView becomeFirstResponder];
}

-(void)leftBtnClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clearAll
{
    [self inputViewGetNew];
}

//范俊说以后如果这个被枪毙了，可以考虑当超出150字的时候提示alertView超出字数，并只出现一次
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([@"\n" isEqualToString:text] == YES) { //发送的操作
        [self goToPublish];
        return NO;
    }
    NSLog(@"range.length=%ld",(unsigned long)range.length);
    if (range.length == 0 && textView.text.length >= kPublishLimitNumber) {
        return NO;
    }
    return YES;
}


-(void)paste:(id)sender{
    [super paste:sender];
    
    if (inputView.text.length > kPublishLimitNumber) {
        inputView.text = [inputView.text substringToIndex:kPublishLimitNumber];
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
                    if (textView.text.length >= kPublishLimitNumber) {
                        textView.text = [textView.text substringToIndex:kPublishLimitNumber];
                    }
                }
            }
        } else {
            if (textView.text.length >= kPublishLimitNumber) {
                textView.text = [textView.text substringToIndex:kPublishLimitNumber];
            }
        }
    }

    if (textView.text.length) {
        [alertLabel removeFromSuperview];
    }else{
        [inputView addSubview:alertLabel];
    }
}

-(void)goToPublish
{
    if (![ConnectionAvailable isConnectionAvailable]) {
        [MBProgressHUD myShowHUDAddedTo:self.view animated:YES];
        return;
    }
    
    NSString *userIdStr = [LoginSqlite getdata:@"userId"];

    if ([inputView.text isEqualToString:@""]&&[publishImageStr isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"发布内容不能为空" delegate:nil cancelButtonTitle:@"是" otherButtonTitles: nil , nil];
        [alert show];
        inputView.text =@"";
        return;
    }
    
    //如果没有图片，则保证用户的文字内容不能为全空格
    if ([publishImageStr isEqualToString:@""]) {
        if ([self isAllSpace:inputView.text]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"发布内容不能为空" delegate:nil cancelButtonTitle:@"是" otherButtonTitles: nil , nil];
            [alert show];
            return;
        }
    }
    
    //防止用户重复点击，所以网络还在发送上次请求的时候，isPublish为YES
    if (isPublish) {
        return;
    }
    isPublish=YES;
    //范俊说以后如果这个被枪毙了，可以考虑当超出150字的时候提示alertView超出字数，并只出现一次
    NSString* publishContent=inputView.text.length>kPublishLimitNumber?[inputView.text substringToIndex:kPublishLimitNumber]:inputView.text;
    if (PublishNum ==1) {
        NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithObjectsAndKeys:userIdStr,@"EntityID",publishContent,@"ActiveText",[LoginSqlite getdata:@"userType"],@"Category",userIdStr,@"CreatedBy",publishImageStr,@"PictureStrings", nil];
        [CommentApi SendActivesWithBlock:^(NSMutableArray *posts, NSError *error) {
            isPublish=NO;
            PublishNum = 1;
            if(!error){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"发布成功" delegate:nil cancelButtonTitle:@"是" otherButtonTitles: nil , nil];
                [alert show];
                [self inputViewGetNew];
//                publishImage.image = [GetImagePath getImagePath:@"人脉－发布动态_03a"];
//                inputView.text =@"";
//                publishImageStr =@"";
            }else{
                [LoginAgain AddLoginView:NO];
            }
        } dic:dic noNetWork:nil];

    }else if (PublishNum ==2) {
        //NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithObjectsAndKeys:publishContent,@"ProductDescription",userIdStr,@"CreatedBy",publishImageStr,@"ProductImageStrings", nil];
/*
        [ProductModel AddProductInformationWithBlock:^(NSMutableArray *posts, NSError *error) {
            isPublish=NO;
            PublishNum = 2;
            if(!error){
                NSDictionary *dic = [posts objectAtIndex:0];
                NSString *productId = [[[dic objectForKey:@"d"] objectForKey:@"data"] objectForKey:@"id"];
                NSLog(@"===>%@",productId);
                NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:productId,@"id",userIdStr,@"PublishedBy", nil];
                
                [ProductModel PublishProductInformationWithBlock:^(NSMutableArray *posts, NSError *error) {
                    if(!error){
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"发布成功" delegate:nil cancelButtonTitle:@"是" otherButtonTitles: nil , nil];
                        [alert show];
                        [self inputViewGetNew];
//                        publishImage.image = [GetImagePath getImagePath:@"人脉－发布动态_03a"];
//                        inputView.text =@"";
//                        publishImageStr =@"";
                    }else{
                        [LoginAgain AddLoginView:NO];
                    }
                } dic:parameters noNetWork:nil];
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"发布失败" delegate:nil cancelButtonTitle:@"是" otherButtonTitles: nil , nil];
                [alert show];
            }
        } dic:dic noNetWork:nil];
        */
    }
}

-(BOOL)isAllSpace:(NSString*)content{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@" " options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:content options:0 range:NSMakeRange(0, [content length])];
    return numberOfMatches==content.length;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    NSLog(@"dealloc");
}
@end
