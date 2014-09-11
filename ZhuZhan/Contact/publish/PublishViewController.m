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
@interface PublishViewController ()

@end

@implementation PublishViewController
@synthesize toolBar,inputView,alertLabel,leftBtnImage,rightBtnImage,publishImage,camera,publishImageStr;
static int PublishNum =0;//0没有选择不能发布 1 发布动态  2，发布产品
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

    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 5, 29, 28.5)];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"icon_04.png"] forState:UIControlStateNormal];
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



    inputView = [[UITextView alloc] initWithFrame:CGRectMake(10, 42, 300, 220)];
    inputView.delegate = self;
    inputView.returnKeyType = UIReturnKeySend;
    inputView.font = [UIFont systemFontOfSize:16];
    inputView.text =@"             ";
    [inputView becomeFirstResponder];
    [self.view addSubview:inputView];
    
    alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 110, 120, 30)];
    alertLabel.text = @"您在做什么?";
    alertLabel.textColor = GrayColor;
    alertLabel.alpha = 0.6;
    alertLabel.textAlignment =NSTextAlignmentLeft;
    [self.view addSubview:alertLabel];
    

    publishImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 74.5, 60, 60)];
    publishImage.image = [UIImage imageNamed:@"人脉－发布动态_03a"];
    publishImage.userInteractionEnabled =YES;
    [self.view addSubview:publishImage];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(beginToAddImage)];
    [publishImage addGestureRecognizer:tap];
    
    toolBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 312, 320, 40)];
    toolBar.image = [UIImage imageNamed:@"人脉－发布动态_15a"];
    toolBar.userInteractionEnabled = YES;
    [self.view addSubview:toolBar];


    UIButton *textBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    textBtn.frame = CGRectMake(0, 0, 158, 40);
    leftBtnImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 11.5, 19, 17)];
    leftBtnImage.image = [UIImage imageNamed:@"人脉－发布动态_09a"];
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
    rightBtnImage.image = [UIImage imageNamed:@"人脉－发布动态_13a"];
    rightBtnImage.userInteractionEnabled = YES;
    [photoBtn addSubview:rightBtnImage];
    UILabel *rightBtnLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 100, 30)];
    rightBtnLabel.text = @"产品信息";
    [photoBtn addSubview:rightBtnLabel];
    [photoBtn addTarget:self action:@selector(publshProduct) forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:photoBtn];
    

}

-(void)beginToAddImage
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"手机相册", nil];
    [actionSheet showInView:self.view.superview];
}

-(void)publshActivities
{
    NSLog(@"想说些什么");
leftBtnImage.image = [UIImage imageNamed:@"人脉－发布动态_07a"];
rightBtnImage.image = [UIImage imageNamed:@"人脉－发布动态_13a"];
    PublishNum =1;

    }

-(void)publshProduct{
  NSLog(@"发布产品信息");
    leftBtnImage.image = [UIImage imageNamed:@"人脉－发布动态_09a"];
    rightBtnImage.image = [UIImage imageNamed:@"人脉－发布动态_11a"];
    
    PublishNum =2;
    
    

    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    camera = [[Camera alloc] init];
    camera.delegate = self;
    [self.view addSubview:camera.view];
    [camera modifyUserIconWithButtonIndex:buttonIndex WithButtonTag:110120];
    
}




-(void)publishImage:(NSString *)imageStr andImage:(UIImage *)image;
{
    [inputView becomeFirstResponder];
    publishImageStr = imageStr;
//    CGRect frame = CGRectMake(image.size.width/2-30, image.size.height/2-30, 60, 60);
//   image=[UIImage imageWithCGImage:CGImageCreateWithImageInRect([image CGImage], frame)];
    publishImage.image = image;
    
}

-(void)openKeyboard
{
    [inputView becomeFirstResponder];
}

-(void)leftBtnClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)clearAll
{
    publishImage.image = [UIImage imageNamed:@"人脉－发布动态_03a"];
    inputView.text =@"             ";
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text; {
    
//    NSLog(@"Text **%@mm",text);

    alertLabel.hidden = YES;
    if ([@"\n" isEqualToString:text] == YES) { //发送的操作
//        if ([inputView.text length] <13) {
//            inputView.text =@"             ";
//        }
//        inputView.text = [inputView.text substringFromIndex:13];;
//        inputView.text =@"             ";
        [self goToPublish];
        
        return NO;
    }
    if ([@"" isEqualToString:text] == YES) {
        CGPoint cursorPosition = [textView caretRectForPosition:textView.selectedTextRange.start].origin;
        NSLog(@"===%lf,%f",cursorPosition.x,cursorPosition.y);
        if ((cursorPosition.x==58.720001 &&cursorPosition.y==7)||(cursorPosition.x==63.279999 &&cursorPosition.y==7)) {
            
            
            if ([inputView.text length] <14) {
               inputView.text =@"             ";
                return NO;
            }
            
            [@" " stringByAppendingString:inputView.text];
            return NO;

        }

        else if(cursorPosition.x<63.281014 && cursorPosition.y==7){
            NSLog(@"韩海龙");
            [@" " stringByAppendingString:inputView.text];
            return NO;
        }
        
    }
    
    return YES;
}


-(void)goToPublish
{
    NSString *userIdStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSLog(@"******userId****** %@",userIdStr);
    if (PublishNum ==0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择发布类型" delegate:nil cancelButtonTitle:@"是" otherButtonTitles: nil , nil];
        [alert show];
    }
    if ([inputView.text isEqualToString:@"             "]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"发布内容不能为空" delegate:nil cancelButtonTitle:@"是" otherButtonTitles: nil , nil];
        [alert show];
        return;
    }
    if (PublishNum ==1) {

        NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithObjectsAndKeys:userIdStr,@"EntityID",inputView.text,@"ActiveText",publishImageStr,@"PictureStrings",@"Personal",@"Type",userIdStr,@"CreatedBy", nil];
        
        [CommentApi SendActivesWithBlock:^(NSMutableArray *posts, NSError *error) {
            NSLog(@"******posts***** %@",posts);
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"发布成功" delegate:nil cancelButtonTitle:@"是" otherButtonTitles: nil , nil];
            [alert show];
            publishImage.image = [UIImage imageNamed:@"人脉－发布动态_03a"];
            inputView.text =@"             ";
            PublishNum =0;
            
        } dic:dic];

    }
    
    if (PublishNum ==2) {
        NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithObjectsAndKeys:@"21344",@"ProductName",inputView.text,@"ProductDescription",publishImageStr,@"ProductImageStrings",userIdStr,@"CreatedBy", nil];
        [ProductModel AddProductInformationWithBlock:^(NSMutableArray *posts, NSError *error) {
            
            
            NSDictionary *dic = [posts objectAtIndex:0];
            NSString *productId = [[[dic objectForKey:@"d"] objectForKey:@"data"] objectForKey:@"id"];
            
            NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:productId,@"id",userIdStr,@"PublishedBy", nil];
            
            [ProductModel PublishProductInformationWithBlock:^(NSMutableArray *posts, NSError *error) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"发布成功" delegate:nil cancelButtonTitle:@"是" otherButtonTitles: nil , nil];
                [alert show];
                
                publishImage.image = [UIImage imageNamed:@"人脉－发布动态_03a"];
                inputView.text =@"             ";
                            PublishNum =0;
                
            } dic:parameters];
            
            
        } dic:dic];

    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
