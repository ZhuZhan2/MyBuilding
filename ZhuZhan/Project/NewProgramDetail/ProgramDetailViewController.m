//
//  ProgramDetailViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 14-8-26.
//
//

#import "ProgramDetailViewController.h"
#import "ProjectApi.h"
@interface ProgramDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UIButton* backButton;
@property(nonatomic,strong)UITableView* contentTableView;
@property(nonatomic,strong)UITableView* selectTableView;
@end

@implementation ProgramDetailViewController

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
    self.view.backgroundColor=[UIColor whiteColor];
    [ProjectApi SingleProjectWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            NSLog(@"==========%@",posts[0]);
            [self loadSelf];
        }else{
            
        }
    } projectId:self.ID];
    // Do any additional setup after loading the view.
}

-(void)loadSelf{
    [self initNavi];
    [self initTableView];
}

-(void)initTableView{
    self.contentTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64+10, 320, 568-64-20) style:UITableViewStylePlain];
    self.contentTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.contentTableView.backgroundColor=[UIColor redColor];
    [self.view addSubview:self.contentTableView];
}

-(void)back{
    [self.backButton removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initNavi{
    self.backButton=[[UIButton alloc]initWithFrame:CGRectMake(0,5,29,28.5)];
    [self.backButton setImage:[UIImage imageNamed:@"icon_04.png"] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.navigationController.navigationBar addSubview:self.backButton];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
