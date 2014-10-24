//
//  ClauseViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 14/10/24.
//
//

#import "ClauseViewController.h"

@interface ClauseViewController ()

@end

@implementation ClauseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNaviAndSelf];
    [self loadContent];
    [self loadSureBtn];
}

-(void)userSure{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)loadNaviAndSelf{
    self.title=@"使用条款";
    self.navigationItem.hidesBackButton=YES;
    self.view.backgroundColor=RGBCOLOR(245, 246, 248);
}

-(void)loadContent{
    UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 79, 320, 398)];
    imageView.image=[GetImagePath getImagePath:@"用户条款_02"];
    [self.view addSubview:imageView];
}

-(void)loadSureBtn{
    UIButton* btn=[[UIButton alloc]initWithFrame:CGRectMake(22, 500, 276, 42)];
    [btn setImage:[GetImagePath getImagePath:@"用户条款_05"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(userSure) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
