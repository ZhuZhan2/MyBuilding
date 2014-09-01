//
//  SaveConditionsViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-1.
//
//

#import "SaveConditionsViewController.h"
#import "ProjectApi.h"
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
    [bgImage setImage:[UIImage imageNamed:@"高级搜索－1_03a"]];
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
    [nameTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
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
- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField.text.length > 24) {
        textField.text = [textField.text substringToIndex:24];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"名字太长了" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(void)confirmBtnClick{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:nameTextField.text forKey:@"SearchName"];
    [dic setValue:@"0ba5403d-6b6e-425f-b7e6-9555be0c38a9" forKey:@"CreateBy"];
    [dic setValue:string forKey:@"SearchConditions"];
    [ProjectApi SearchConditionWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            [nameTextField resignFirstResponder];
            if([self.delegate respondsToSelector:@selector(backView)]){
                [self.delegate backView];
            }
        }
    } dic:dic];
}

-(void)cancelBtnClick{
    [nameTextField resignFirstResponder];
    if([self.delegate respondsToSelector:@selector(backView)]){
        [self.delegate backView];
    }
}

-(void)setDataDic:(NSMutableDictionary *)dataDic{
    NSMutableString *str = [[NSMutableString alloc] init];
    for(int i=0;i<dataDic.allKeys.count;i++){
        if(![[dataDic objectForKey:[dataDic allKeys][i]] isEqualToString:@""]){
            [str appendString:[NSString stringWithFormat:@"%@ + ",[dataDic objectForKey:[dataDic allKeys][i]]]];
        }
    }
    if(str.length !=0){
        string = [str substringToIndex:([str length]-2)];
    }
}
@end
