//
//  OverProvisionalViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/31.
//
//

#import "OverProvisionalViewController.h"
#import "CodeView.h"
#import "StartManView.h"
@interface OverProvisionalViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *viewArr;
@property(nonatomic,strong)CodeView *codeView;
@property(nonatomic,strong)StartManView *startMainView;
@property(nonatomic)float startMainViewHeight;
@end

@implementation OverProvisionalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 132, 320, kScreenHeight-132)];
        //_tableView = [[UITableView alloc] initWithFrame:self.view.frame];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = NO;
    }
    return _tableView;
}

-(CodeView *)codeView{
    if(!_codeView){
        _codeView = [[CodeView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
    }
    return _codeView;
}

-(StartManView *)startMainView{
    if(!_startMainView){
        _startMainView = [[StartManView alloc] init];
        [_startMainView GetHeightWithBlock:^(double height) {
            if(height<60){
                height = 60;
            }
            self.startMainViewHeight = height;
            _startMainView.frame = CGRectMake(0, 0, 320, height);
        } str:@""];
    }
    return _startMainView;
}

-(NSMutableArray *)viewArr{
    if(!_viewArr){
        _viewArr = [NSMutableArray array];
        [_viewArr addObject:self.codeView];
        [_viewArr addObject:self.startMainView];
    }
    return _viewArr;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.viewArr.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",(long)indexPath.row);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    cell.selectionStyle = NO;
    [cell.contentView addSubview:self.viewArr[indexPath.row]];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
@end
