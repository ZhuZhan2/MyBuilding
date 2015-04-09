//
//  RecommendFriendViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/4/9.
//
//

#import "RecommendFriendViewController.h"
#import "AddFriendCell.h"
@interface RecommendFriendViewController ()
@property(nonatomic,strong)NSMutableArray* models;
@end

@implementation RecommendFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavi];
    [self setUpSearchBarWithNeedTableView:YES isTableViewHeader:NO];
    [self initTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initNavi{
    self.title=@"添加好友";
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 47;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddFriendCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[AddFriendCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell" needRightBtn:YES];
    }
    [cell setUserName:@"aaa" time:@"bbb" userImageUrl:@"" isFinished:@"" indexPathRow:indexPath.row status:@""];
    cell.selectionStyle = NO;
    
    return cell;
}
@end
