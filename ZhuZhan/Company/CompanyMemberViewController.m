//
//  CompanyMemberViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 14-8-7.
//
//

#import "CompanyMemberViewController.h"

@interface CompanyMemberViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView* myTableView;
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
        self.view.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initMyTableView];
    // Do any additional setup after loading the view.
}

-(void)initMyTableView{
    CGRect tableViewFrame=self.view.frame;
    tableViewFrame.origin.x+=10;
    tableViewFrame.origin.y+=10;
    tableViewFrame.size.width-=20;
    tableViewFrame.size.height-=55+10;
    
    CGRect shadowView=tableViewFrame;
    shadowView.size.height=self.memberNumber*50;
    UIView* view=[[UIView alloc]initWithFrame:shadowView];
    view.backgroundColor=[UIColor whiteColor];
    view.layer.shadowColor=[[UIColor grayColor]CGColor];
    view.layer.shadowOpacity=1;
    view.layer.shadowOffset=CGSizeMake(0, .1);
    [self.view addSubview:view];
    
    
    //NSLog(@"%f",self.myTableView.contentSize.height);
    self.myTableView=[[UITableView alloc]initWithFrame:tableViewFrame style:UITableViewStylePlain];
    
    self.myTableView.backgroundColor=[UIColor redColor];
    
    
//    self.myTableView.layer.shadowColor=[[UIColor blackColor]CGColor];
//    self.myTableView.layer.shadowOpacity=1;
//    
//    self.myTableView.layer.shadowOffset=CGSizeMake(0, .1);
    
    self.myTableView.delegate=self;
    self.myTableView.dataSource=self;
    
    
    self.myTableView.separatorInset=UIEdgeInsetsMake(20, 20, 20, 20);
    self.myTableView.allowsSelection=NO;
    
    [self.view addSubview:self.myTableView];
    
//    frame=self.view.frame;
//    frame.size.height-=160;
//    self.view.frame=frame;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.memberNumber;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        
    }

    cell.contentView.backgroundColor=[UIColor whiteColor];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
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
