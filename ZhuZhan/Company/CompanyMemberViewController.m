//
//  CompanyMemberViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 14-8-7.
//
//

#import "CompanyMemberViewController.h"

@interface CompanyMemberViewController ()
@property(nonatomic)NSInteger memberNumber;
@end

@implementation CompanyMemberViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithMemberNumber:(NSInteger)number{
    if ([self init]) {
        self.memberNumber=number;
        //self.tableView.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initMyTableViewAndNavi];
        // Do any additional setup after loading the view.
}

-(void)initMyTableViewAndNavi{
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.allowsSelection=NO;
    
    self.title = @"公司员工";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"地图搜索_01.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont fontWithName:@"GurmukhiMN-Bold" size:19], NSFontAttributeName,nil]];
    
    
    //左back button
    UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [button setImage:[UIImage imageNamed:@"bg-addbutton@2x.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
     
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        
    }
    CGRect shadowView=CGRectMake(10, 10, 300, self.memberNumber*70);
    UIView* view=[[UIView alloc]initWithFrame:shadowView];
    view.backgroundColor=[UIColor whiteColor];
    view.layer.shadowColor=[[UIColor grayColor]CGColor];
    view.layer.shadowOpacity=1;
    view.layer.shadowOffset=CGSizeMake(0, .1);
    
    [cell.contentView addSubview:view];
    [self addViewWithContentView:view];
    
    cell.contentView.backgroundColor=[UIColor whiteColor];
    
    
    return cell;
}

-(void)addViewWithContentView:(UIView*)contentView{
    for (int i=0; i<self.memberNumber; i++) {
        UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, i*70, 70, 70)];
        imageView.image=[UIImage imageNamed:@"面部识别登录1_03.png"];
        [contentView addSubview:imageView];
        
        UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(90, 15+i*70, 200, 30)];
        label.text=@"用户名显示";
        [contentView addSubview:label];
        
        UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(250, 15+i*70, 50, 30)];
        button.frame=CGRectMake(250, 15+i*70, 50, 30);
        [button setImage:[UIImage imageNamed:@"bg-addbutton.png"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(changeButtonImage:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:button];
    }
}

-(void)changeButtonImage:(UIButton*)button{
    [button setImage:[UIImage imageNamed:@"bg-addbutton-highlighted"] forState:UIControlStateNormal];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70*self.memberNumber+40;
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

@end
