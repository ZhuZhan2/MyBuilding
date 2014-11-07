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
    //[self loadSureBtn];
}

//-(void)userSure{
//    [self.navigationController popViewControllerAnimated:YES];
//}

-(void)loadNaviAndSelf{
    self.title=@"使用条款";
    //返回按钮
    UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(0,5,29,28.5)];
    [button setImage:[GetImagePath getImagePath:@"013"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];

    self.view.backgroundColor=RGBCOLOR(245, 246, 248);
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)loadContent{
    UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 79, 320, 398)];
    imageView.image=[GetImagePath getImagePath:@"用户条款_02"];
    [self.view addSubview:imageView];
}

//-(void)loadSureBtn{
//    UIButton* btn=[[UIButton alloc]initWithFrame:CGRectMake(22, 500, 276, 42)];
//    [btn setImage:[GetImagePath getImagePath:@"用户条款_05"] forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(userSure) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
