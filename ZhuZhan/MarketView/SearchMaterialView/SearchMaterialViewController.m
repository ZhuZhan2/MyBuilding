//
//  SearchMaterialViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/5/5.
//
//

#import "SearchMaterialViewController.h"
#import "MarketSearchViewController.h"
#import "HomePageViewController.h"
#import "AppDelegate.h"
#import "EndEditingGesture.h"
#import "SinglePickerView.h"
#import "LoginSqlite.h"
#import "MarketApi.h"
#define FONT [UIFont systemFontOfSize:16];
@interface SearchMaterialViewController ()<UITextFieldDelegate,UITextViewDelegate,UIActionSheetDelegate>
@property(nonatomic,strong)UIButton *searchBtn;
@property(nonatomic,strong)UIView *searchView;
@property(nonatomic,strong)UITextField *nameTextField;
@property(nonatomic,strong)UITextField *phoneTextField;
@property(nonatomic,strong)UIImageView *imageView1;
@property(nonatomic,strong)UIImageView *imageView2;
@property(nonatomic,strong)UIImageView *imageView3;
@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)UILabel *placeLabel;
@property(nonatomic,strong)UIButton *categoryBtn;
@property(nonatomic,strong)UIButton *submitBtn;
@property(nonatomic,strong)UILabel *categoryLabel;
@property(nonatomic,strong)SinglePickerView *singleView;
@property(nonatomic,strong)UIButton *bgBtn;
@property(nonatomic,strong)NSString *categoryStr;
@property(nonatomic,strong)UIView* loadingView;
@property(nonatomic,strong)UIActivityIndicatorView* activityView;
@end

@implementation SearchMaterialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 25, 22)];
    [leftButton setBackgroundImage:[GetImagePath getImagePath:@"013"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    //[self.searchView addSubview:self.searchBtn];
    //self.navigationItem.titleView = self.searchView;
    self.title = @"小布帮你找";
    
    [self addTitle];
    [self.view addSubview:self.imageView1];
    [self.view addSubview:self.imageView2];
    [self.view addSubview:self.imageView3];
    [self.view addSubview:self.nameTextField];
    [self.view addSubview:self.phoneTextField];
    [self.view addSubview:self.categoryBtn];
    [self.categoryBtn addSubview:self.categoryLabel];
    [self.view addSubview:self.textView];
    [self.view addSubview:self.placeLabel];
    [self.view addSubview:self.submitBtn];
    
    [EndEditingGesture addGestureToView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIButton *)searchBtn{
    if(!_searchBtn){
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchBtn.frame = CGRectMake(0, 0, 254, 28);
        [_searchBtn setImage:[GetImagePath getImagePath:@"MarketSearch"] forState:UIControlStateNormal];
        [_searchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
        _searchBtn.adjustsImageWhenHighlighted = NO;
    }
    return _searchBtn;
}

-(UIView *)searchView{
    if(!_searchView){
        _searchView = [[UIView alloc] initWithFrame:CGRectMake(47, 26, 254, 28)];
    }
    return _searchView;
}

-(void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)searchAction{
    MarketSearchViewController *view = [[MarketSearchViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //恢复tabBar
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarRestore];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //隐藏tabBar
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarHide];
}

-(void)addTitle{
    NSArray *arr = [[NSArray alloc] initWithObjects:@"联系人",@"联系电话",@"主题", nil];
    for(int i=0;i<arr.count;i++){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(24, i*65+69, 272, 18)];
        label.text = arr[i];
        label.font = FONT;
        label.textColor = RGBCOLOR(85, 103, 166);
        [self.view addSubview:label];
    }
}

-(UIImageView *)imageView1{
    if(!_imageView1){
        _imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(24, 93, 272, 35)];
        _imageView1.image = [GetImagePath getImagePath:@"find_insetbox"];
    }
    return _imageView1;
}

-(UIImageView *)imageView2{
    if(!_imageView2){
        _imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(24, 158, 272, 35)];
        _imageView2.image = [GetImagePath getImagePath:@"find_insetbox"];
    }
    return _imageView2;
}

-(UIImageView *)imageView3{
    if(!_imageView3){
        _imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(24, 270, 272, 130)];
        _imageView3.image = [GetImagePath getImagePath:@"find_insetbox2"];
    }
    return _imageView3;
}

-(UITextField *)nameTextField{
    if(!_nameTextField){
        _nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(24, 93, 272, 35)];
        _nameTextField.placeholder = @"请输入您的姓名";
        _nameTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
        _nameTextField.leftView.userInteractionEnabled = NO;
        _nameTextField.leftViewMode = UITextFieldViewModeAlways;
        _nameTextField.returnKeyType = UIReturnKeyDone;
        _nameTextField.delegate = self;
        [_nameTextField setValue:[UIFont systemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
        [_nameTextField setValue:AllNoDataColor forKeyPath:@"_placeholderLabel.textColor"];
        if(![[LoginSqlite getdata:@"userName"] isEqualToString:@""]){
            _nameTextField.text = [LoginSqlite getdata:@"contactName"];
        }
    }
    return _nameTextField;
}

-(UITextField *)phoneTextField{
    if(!_phoneTextField){
        _phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(24, 158, 272, 35)];
        _phoneTextField.placeholder = @"请输入您的电话";
        _phoneTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
        _phoneTextField.leftView.userInteractionEnabled = NO;
        _phoneTextField.leftViewMode = UITextFieldViewModeAlways;
        _phoneTextField.returnKeyType = UIReturnKeyDone;
        _phoneTextField.delegate = self;
        _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
        [_phoneTextField setValue:[UIFont systemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
        [_phoneTextField setValue:AllNoDataColor forKeyPath:@"_placeholderLabel.textColor"];
        if(![[LoginSqlite getdata:@"userPhone"] isEqualToString:@""]){
            _phoneTextField.text = [LoginSqlite getdata:@"contactTel"];
        }
    }
    return _phoneTextField;
}

-(UITextView *)textView{
    if(!_textView){
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(32, 270, 257, 130)];
        _textView.delegate = self;
        _textView.font = FONT;
        _textView.returnKeyType = UIReturnKeyDone;
        _textView.backgroundColor = [UIColor clearColor];
    }
    return _textView;
}

-(UILabel *)placeLabel{
    if(!_placeLabel){
        _placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 270, 272, 35)];
        _placeLabel.font = FONT;
        _placeLabel.textColor = AllNoDataColor;
        _placeLabel.numberOfLines = 2;
        _placeLabel.text = @"请把让我们帮你的事情输入";
    }
    return _placeLabel;
}

-(UIButton *)categoryBtn{
    if(!_categoryBtn){
        _categoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _categoryBtn.frame = CGRectMake(24, 222, 272, 35);
        [_categoryBtn setImage:[GetImagePath getImagePath:@"choicebox"] forState:UIControlStateNormal];
        [_categoryBtn addTarget:self action:@selector(categoryAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _categoryBtn;
}

-(UILabel *)categoryLabel{
    if(!_categoryLabel){
        _categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 260, 35)];
        _categoryLabel.text = @"请选择分类";
        _categoryLabel.font = FONT;
        _categoryLabel.textColor = AllNoDataColor;
    }
    return _categoryLabel;
}

-(UIButton *)submitBtn{
    if(!_submitBtn){
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn.frame = CGRectMake(24, 430, 272, 40);
        [_submitBtn setImage:[GetImagePath getImagePath:@"find_findbutton"] forState:UIControlStateNormal];
        [_submitBtn addTarget:self action:@selector(submitBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

-(UIButton *)bgBtn{
    if(!_bgBtn){
        _bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _bgBtn.frame = self.view.frame;
        [_bgBtn addTarget:self action:@selector(bgBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bgBtn;
}

-(void)categoryAction{
    [self.nameTextField resignFirstResponder];
    [self.phoneTextField resignFirstResponder];
    [self.textView resignFirstResponder];
    [self.view addSubview:self.bgBtn];
    self.singleView = [[SinglePickerView alloc]initWithTitle:CGRectMake(0, 0, 320, 260) title:nil Arr:@[@"我要找项目",@"我要找材料",@"我要找公司",@"我要找关系",@"我要找合作",@"其他"] delegate:self];
    [self.singleView showInView:self.view];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.nameTextField resignFirstResponder];
    return YES;
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    self.view.transform = CGAffineTransformMakeTranslation(0, -200);
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    self.view.transform = CGAffineTransformIdentity;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    self.placeLabel.alpha=!textView.text.length;
    if ([@"\n" isEqualToString:text]){
        [textView resignFirstResponder];
    }
    return YES;
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    self.singleView = (SinglePickerView *)actionSheet;
    if(buttonIndex == 0) {
        NSLog(@"Cancel");
    }else {
        self.categoryStr = self.singleView.selectStr;
        self.categoryLabel.text = self.singleView.selectStr;
        self.categoryLabel.textColor = [UIColor blackColor];
    }
    [self.bgBtn removeFromSuperview];
    self.bgBtn = nil;
}

-(void)bgBtnAction{
    [self.singleView cancelClick];
    [self.bgBtn removeFromSuperview];
    self.bgBtn = nil;
}

-(void)submitBtnAction{
    if([[self.nameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]){
        [self showAlertView:@"姓名不能为空"];
        return;
    }
    
    if([[self.phoneTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]){
        [self showAlertView:@"手机号不能为空"];
        return;
    }
    
    if([self.categoryStr isEqualToString:@""] || !self.categoryStr){
        [self showAlertView:@"分类不能为空"];
        return;
    }
    
    [self postContent];
}

-(void)showAlertView:(NSString *)msg{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

-(void)postContent{
    [self startLoadingView];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:self.nameTextField.text forKey:@"userName"];
    [dic setObject:self.phoneTextField.text forKey:@"cellphone"];
    [dic setObject:self.categoryStr forKey:@"subjects"];
    [dic setObject:self.textView.text forKey:@"contents"];
    [MarketApi AddWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            [self showAlertView:@"提交成功"];
            if(![[LoginSqlite getdata:@"userId"] isEqualToString:@""]){
                self.categoryStr = @"";
                self.categoryLabel.text = @"请选择分类";
                self.categoryLabel.textColor = AllNoDataColor;
                self.textView.text = @"";
            }else{
                self.nameTextField.text = @"";
                self.phoneTextField.text = @"";
                self.categoryStr = @"";
                self.categoryLabel.text = @"请选择分类";
                self.categoryLabel.textColor = AllNoDataColor;
                self.textView.text = @"";
            }
        }else{
            [ErrorCode alert];
        }
        [self stopLoadingView];
    } dic:dic noNetWork:^{
        [self stopLoadingView];
        [ErrorCode alert];
    }];
}

-(UIView *)loadingView{
    if (!_loadingView) {
        _loadingView=[[UIView alloc]initWithFrame:self.view.bounds];
        _loadingView.backgroundColor=[[UIColor alloc]initWithRed:0 green:0 blue:0 alpha:.5];
        
        self.activityView.center=_loadingView.center;
        [_loadingView addSubview:self.activityView];
    }
    return _loadingView;
}

-(UIActivityIndicatorView *)activityView{
    if (!_activityView) {
        _activityView=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    }
    return _activityView;
}

-(void)startLoadingView{
    [self.activityView startAnimating];
    [self.navigationController.view addSubview:self.loadingView];
}

-(void)stopLoadingView{
    [self.activityView stopAnimating];
    [self.loadingView removeFromSuperview];
}
@end
