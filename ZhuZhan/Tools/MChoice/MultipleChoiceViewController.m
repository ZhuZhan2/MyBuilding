//
//  MultipleChoiceViewController.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-27.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "MultipleChoiceViewController.h"
#import "MChoiceTableViewCell.h"
@interface Item : NSObject

@property (retain, nonatomic) NSString *title;

@property (assign, nonatomic) BOOL isChecked;

@end

@implementation Item

@end
@interface MultipleChoiceViewController ()

@end

@implementation MultipleChoiceViewController
@synthesize showArr,dataArr;
@synthesize delegate;
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
    self.view.layer.cornerRadius = 8;//设置那个圆角的有多圆
    self.view.layer.masksToBounds = YES;//设为NO去试试。设置YES是保证添加的图片覆盖视图的效果
    UIImageView *bgimageView = [[UIImageView alloc] init];
    if(self.flag == 0){
        bgimageView.frame = CGRectMake(0, 0, 272, 350);
        [bgimageView setImage:[GetImagePath getImagePath:@"高级搜索-多选_03a"]];
    }else{
        bgimageView.frame = CGRectMake(0, 0, 272, 270);
        [bgimageView setImage:[GetImagePath getImagePath:@"高级搜索-多选_03aA"]];
    }
    [self.view addSubview:bgimageView];
    
    self.dataArr = [[NSMutableArray alloc] init];
    self.showArr = [NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<self.arr.count; i++) {
        Item *item = [[Item alloc] init];
        item.title = [self.arr objectAtIndex:i];
        item.isChecked = NO;
        [self.showArr addObject:item];
        [self.dataArr addObject:@""];
    }
    
    _tableView = [[UITableView alloc] init];
    if(self.flag == 0){
        _tableView.frame = CGRectMake(1, 55, 269, 247);
    }else{
        _tableView.frame = CGRectMake(1, 55, 269, 157);
    }
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 41;
    _tableView.allowsSelectionDuringEditing = YES;
    _tableView.scrollEnabled = NO;
    _tableView.separatorStyle = NO;
    [self.view addSubview:_tableView];
    
    UIButton *complated = [UIButton buttonWithType:UIButtonTypeCustom];
    if(self.flag == 0){
        complated.frame = CGRectMake(0,305, 135, 44);
    }else{
        complated.frame = CGRectMake(0,225, 135, 44);
    }
    [complated setTitle:@"确认" forState:UIControlStateNormal];
    [complated setTitleColor:BlueColor forState:UIControlStateNormal];
    complated.titleLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:16];
    [complated addTarget:self action:@selector(complatedClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:complated];
    
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    if(self.flag == 0){
        cancel.frame = CGRectMake(136,305, 135, 44);
    }else{
        cancel.frame = CGRectMake(136,225, 135, 44);
    }
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    cancel.titleLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:16];
    [cancel addTarget:self action:@selector(CancelClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancel];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 3, 270, 50)];
    titleLabel.text = @"请选择搜索条件";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:18];
    [self.view addSubview:titleLabel];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.showArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    MChoiceTableViewCell *cell = (MChoiceTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[MChoiceTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
	cell.accessoryType = UITableViewCellAccessoryNone;
	cell.textLabel.textColor = [UIColor blackColor];
    Item* item = [self.showArr objectAtIndex:indexPath.row];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 200, 30)];
    title.text = item.title;
    title.font = [UIFont systemFontOfSize:14];
	[cell addSubview:title];
	[cell setChecked:item.isChecked];
    
    if(indexPath.row != self.showArr.count-1){
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 41, 229, 1)];
        [imageView setBackgroundColor:[UIColor blackColor]];
        [cell addSubview:imageView];
        imageView.alpha = 0.2;
    }
    cell.selectionStyle = NO;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Item* item = [self.showArr objectAtIndex:indexPath.row];
	MChoiceTableViewCell *cell = (MChoiceTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    item.isChecked = !item.isChecked;
    [cell setChecked:item.isChecked];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(item.isChecked){
        [self.dataArr insertObject:item.title atIndex:indexPath.row];
    }else{
        [self.dataArr removeObjectAtIndex:indexPath.row];
    }
}

-(void)CancelClick{
    if ([delegate respondsToSelector:@selector(backMChoiceViewController)]){
        [delegate backMChoiceViewController];
    }
}

-(void)complatedClick{
    if(self.dataArr.count !=0){
        if ([delegate respondsToSelector:@selector(choiceData:index:)]){
            [delegate choiceData:self.dataArr index:self.flag];
        }
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"请选择用途！"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil,nil];
        [alert show];
    }
}
@end
