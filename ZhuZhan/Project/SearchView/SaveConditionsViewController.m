//
//  SaveConditionsViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-1.
//
//

#import "SaveConditionsViewController.h"
#import "ProjectApi.h"
#import "LoginSqlite.h"
#import "ConnectionAvailable.h"
#import "MBProgressHUD.h"
@interface SaveConditionsViewController ()

@end

@implementation SaveConditionsViewController

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
    // Do any additional setup after loading the view.
    UIImageView *bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 271, 173)];
    [bgImage setImage:[GetImagePath getImagePath:@"高级搜索－1_03a"]];
    [self.view addSubview:bgImage];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 28, 271, 16)];
    label.text = @"个人搜索条件";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:label];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 271, 13)];
    label2.text = @"为你本次保存的搜索条件命名";
    label2.textAlignment = NSTextAlignmentCenter;
    label2.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:label2];
    //23,   143   51  372
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtn setFrame:CGRectMake(0, 129, 135, 43)];
    [confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    confirmBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.view addSubview:confirmBtn];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setFrame:CGRectMake(136, 129, 134, 43)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.view addSubview:cancelBtn];
    
    nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(23, 84, 225, 29)];
    nameTextField.placeholder = @"Name";
    nameTextField.delegate = self;
    //[nameTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:nameTextField];
    
    [nameTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//- (void)textFieldDidChange:(UITextField *)textField
//{
//    if (textField.text.length > 24) {
//        textField.text = [textField.text substringToIndex:24];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"名字太长了" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alert show];
//    }
//}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{  //string就是此时输入的那个字符textField就是此时正在输入的那个输入框返回YES就是可以改变输入框的值NO相反
    
    if ([string isEqualToString:@"\n"])  //按会车可以改变
    {
        return YES;
    }
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    
    if (nameTextField == textField)  //判断是否时我们想要限定的那个输入框
    {
        if ([toBeString length] > 20) { //如果输入框内容大于20则弹出警告
            textField.text = [toBeString substringToIndex:20];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"超过最大字数不能输入了" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            return NO;
        }
    }
    return YES;
}

-(void)confirmBtnClick{
    if (![ConnectionAvailable isConnectionAvailable]) {
        [MBProgressHUD myShowHUDAddedTo:self.view animated:YES];
        return;
    }
    if([[LoginSqlite getdata:@"token"] isEqualToString:@""]){
    
    }else{
        if([nameTextField.text isEqualToString:@""]){
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"请输入搜索组名称" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }else{
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setValue:nameTextField.text forKey:@"name"];
            [dic setValue:newstring forKey:@"condition"];
            [ProjectApi SearchConditionWithBlock:^(NSMutableArray *posts, NSError *error) {
                if(!error){
                    [nameTextField resignFirstResponder];
                    if([self.delegate respondsToSelector:@selector(finshSave)]){//保存
                        [self.delegate finshSave];
                    }
                }
            } dic:dic noNetWork:nil];
        }
    }
}

-(void)cancelBtnClick{
    [nameTextField resignFirstResponder];
    if([self.delegate respondsToSelector:@selector(backView)]){
        [self.delegate backView];
    }
}

-(void)setDataDic:(NSMutableDictionary *)dataDic{
    newstring = [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@",dataDic[@"keywords"],dataDic[@"companyName"],dataDic[@"landProvince"],dataDic[@"landCity"],dataDic[@"landDistrict"],dataDic[@"projectStage"],dataDic[@"projectCategory"]];
    NSLog(@"%@",newstring);
}
@end
