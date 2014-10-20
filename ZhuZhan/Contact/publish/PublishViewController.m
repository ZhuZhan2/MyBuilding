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
@interface PublishViewController ()

@end

@implementation PublishViewController
@synthesize toolBar,inputView,alertLabel,leftBtnImage,rightBtnImage,publishImage,camera,publishImageStr;
static int PublishNum =1;//1 发布动态  2，发布产品
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = RGBCOLOR(237, 237, 237);
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 5, 29, 28.5)];
    [leftButton setBackgroundImage:[GetImagePath getImagePath:@"icon_04"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    //RightButton设置属性
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, 50, 19.5)];
    [rightButton setTitle:@"清空" forState:UIControlStateNormal];
    rightButton.titleLabel.textColor = [UIColor whiteColor];
    [rightButton addTarget:self action:@selector(clearAll) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    self.title = @"发布";



    inputView = [[UITextView alloc] initWithFrame:CGRectMake(15, 10, 290, 220)];
    inputView.delegate = self;
    inputView.backgroundColor=[UIColor clearColor];
    inputView.returnKeyType = UIReturnKeySend;
    inputView.font = [UIFont systemFontOfSize:17];
    [inputView becomeFirstResponder];
    [self.view addSubview:inputView];
    
    alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(67, 38, 120, 30)];
    alertLabel.text = @"您在做什么?";
    alertLabel.textColor = GrayColor;
    alertLabel.alpha = 0.6;
    alertLabel.textAlignment =NSTextAlignmentLeft;
    [inputView addSubview:alertLabel];
    

    publishImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 74.5, 60, 60)];
    publishImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 6, 60, 60)];
    publishImage.image = [GetImagePath getImagePath:@"人脉－发布动态_03a"];
    publishImage.userInteractionEnabled =YES;
    [inputView addSubview:publishImage];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(beginToAddImage)];
    [publishImage addGestureRecognizer:tap];
    inputView.textContainer.exclusionPaths=@[[UIBezierPath bezierPathWithRect:[inputView convertRect:publishImage.frame fromView:inputView]]];
    
    toolBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 312, 320, 40)];
    toolBar.image = [GetImagePath getImagePath:@"人脉－发布动态_15a"];
    toolBar.userInteractionEnabled = YES;
    [self.view addSubview:toolBar];


    UIButton *textBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    textBtn.frame = CGRectMake(0, 0, 158, 40);
    leftBtnImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 11.5, 19, 17)];
    leftBtnImage.image = [GetImagePath getImagePath:@"人脉－发布动态_09a"];
    leftBtnImage.userInteractionEnabled = YES;
    [textBtn addSubview:leftBtnImage];
    UILabel *leftBtnLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 100, 30)];
    leftBtnLabel.text = @"想说些什么...";
    [textBtn addSubview:leftBtnLabel];
    
    [textBtn addTarget:self action:@selector(publshActivities) forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:textBtn];
    
    UIButton *photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    photoBtn.frame = CGRectMake(162, 0, 160, 40);
    rightBtnImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 11.5, 19, 17)];
    rightBtnImage.image = [GetImagePath getImagePath:@"人脉－发布动态_13a"];
    rightBtnImage.userInteractionEnabled = YES;
    [photoBtn addSubview:rightBtnImage];
    UILabel *rightBtnLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 100, 30)];
    rightBtnLabel.text = @"产品信息";
    [photoBtn addSubview:rightBtnLabel];
    [photoBtn addTarget:self action:@selector(publshProduct) forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:photoBtn];
    
    
    leftBtnImage.image = [GetImagePath getImagePath:@"人脉－发布动态_07a"];
    rightBtnImage.image = [GetImagePath getImagePath:@"人脉－发布动态_13a"];
    publishImageStr =@"";

}

-(void)viewWillAppear:(BOOL)animated{

    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
}

-(void)viewDidDisappear:(BOOL)animated{

    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}


//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    toolBar.frame =CGRectMake(0, kScreenHeight-height-40, 320, 40);
}


-(void)beginToAddImage
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"手机相册", nil];
    [actionSheet showInView:self.view.superview];
}

-(void)publshActivities
{
    NSLog(@"想说些什么");
    NSLog(@"%@",NSStringFromCGRect([inputView.subviews[0] frame]));
    leftBtnImage.image = [GetImagePath getImagePath:@"人脉－发布动态_07a"];
    rightBtnImage.image = [GetImagePath getImagePath:@"人脉－发布动态_13a"];
    PublishNum =1;
    
}

-(void)publshProduct{
  NSLog(@"发布产品信息");
    leftBtnImage.image = [GetImagePath getImagePath:@"人脉－发布动态_09a"];
    rightBtnImage.image = [GetImagePath getImagePath:@"人脉－发布动态_11a"];
    
    PublishNum =2;
    
    

    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    [inputView resignFirstResponder];
    camera = [[Camera alloc] init];
    camera.delegate = self;
    [self.view addSubview:camera.view];
    [camera modifyUserIconWithButtonIndex:buttonIndex WithButtonTag:110120];
    
}




-(void)publishImage:(NSString *)imageStr andImage:(UIImage *)image;
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
    publishImage.image = [GetImagePath getImagePath:@"人脉－发布动态_03a"];
    inputView.text =@"";
    publishImageStr = @"";
}

-(void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length) {
        [alertLabel removeFromSuperview];
    }else{
        [inputView addSubview:alertLabel];
    }
}

-(void)goToPublish
{

    NSString *userIdStr = [LoginSqlite getdata:@"userId" defaultdata:@""];
NSLog(@"******publishImageStr******%@&&",publishImageStr);

    if ([inputView.text isEqualToString:@""]&&[publishImageStr isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"发布内容不能为空" delegate:nil cancelButtonTitle:@"是" otherButtonTitles: nil , nil];
        [alert show];
        inputView.text =@"             ";
        return;
    }

    if (PublishNum ==1) {
        NSLog(@"publishImageStr ==> %@",publishImageStr);
        NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithObjectsAndKeys:userIdStr,@"EntityID",inputView.text,@"ActiveText",@"Personal",@"Category",userIdStr,@"CreatedBy",publishImageStr,@"PictureStrings", nil];
            NSLog(@"******dic****** %@",dic);
        NSString *headBlankStr =@"             ";
        inputView.text = [NSString stringWithFormat:@"%@%@",headBlankStr,inputView.text];
        
        [CommentApi SendActivesWithBlock:^(NSMutableArray *posts, NSError *error) {
            if(!error){
                NSLog(@"******posts***** %@",posts);
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"发布成功" delegate:nil cancelButtonTitle:@"是" otherButtonTitles: nil , nil];
                [alert show];
                publishImage.image = [GetImagePath getImagePath:@"人脉－发布动态_03a"];
                inputView.text =@"             ";
                publishImageStr =@"";
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"发布失败" delegate:nil cancelButtonTitle:@"是" otherButtonTitles: nil , nil];
                [alert show];

            }
        } dic:dic];

    }
    
    if (PublishNum ==2) {
        NSLog(@"publishImageStr ==> %@",publishImageStr);
        NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithObjectsAndKeys:@"21344",@"ProductName",inputView.text,@"ProductDescription",userIdStr,@"CreatedBy",publishImageStr,@"ProductImageStrings", nil];
            NSLog(@"******dic****** %@",dic);
        NSString *headBlankStr =@"             ";
        inputView.text = [NSString stringWithFormat:@"%@%@",headBlankStr,inputView.text];
          NSLog(@"******userId****** %@",userIdStr);
        [ProductModel AddProductInformationWithBlock:^(NSMutableArray *posts, NSError *error) {
            if(!error){
                NSDictionary *dic = [posts objectAtIndex:0];
                NSString *productId = [[[dic objectForKey:@"d"] objectForKey:@"data"] objectForKey:@"id"];
                
                NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:productId,@"id",@"a8909c12-d40e-4cdb-b834-e69b7b9e13c0",@"PublishedBy", nil];
                
                [ProductModel PublishProductInformationWithBlock:^(NSMutableArray *posts, NSError *error) {
                    if(!error){
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"发布成功" delegate:nil cancelButtonTitle:@"是" otherButtonTitles: nil , nil];
                        [alert show];
                        
                        publishImage.image = [GetImagePath getImagePath:@"人脉－发布动态_03a"];
                        inputView.text =@"             ";
                        publishImageStr =@"";
                    }else{
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"发布失败" delegate:nil cancelButtonTitle:@"是" otherButtonTitles: nil , nil];
                        [alert show];

                    }
                    
                } dic:parameters];
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"发布失败" delegate:nil cancelButtonTitle:@"是" otherButtonTitles: nil , nil];
                [alert show];
            }
        } dic:dic];

    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    NSLog(@"dealloc");
    NSLog(@"%@",publishImage);
}
@end
