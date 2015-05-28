//
//  MyTableView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 14/12/3.
//
//

#import "MyTableView.h"
@implementation MyTableView
-(void)reloadData{
    [super reloadData];
    [MyTableView contentFooter:self];
}

+(void)contentFooter:(UITableView*)tableView{
    CGFloat orginFooterHeight=tableView.tableFooterView.frame.size.height;
    CGFloat contentHeightWithOutFooter=tableView.contentSize.height-orginFooterHeight;
    CGFloat reduce=tableView.frame.size.height-contentHeightWithOutFooter-64+6;
    NSLog(@"reduce ===> %f",reduce);
    if (reduce>=0) {
        tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, reduce)];
    }else{
        tableView.tableFooterView=nil;
    }
}

+(void)reloadDataWithTableView:(UITableView*)tableView{
    [tableView reloadData];
    [MyTableView contentFooter:tableView];
}

+(void)hasData:(UITableView*)tableView{
    //tableView.tableFooterView.backgroundColor = [UIColor yellowColor];
    CGFloat orginFooterHeight=tableView.tableFooterView.frame.size.height;
    NSLog(@"orginFooterHeight ==> %f",orginFooterHeight);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(95,(orginFooterHeight-177)/2, 130, 177)];
    imageView.image = [GetImagePath getImagePath:@"nodata"];
    [tableView.tableFooterView addSubview:imageView];
}

+(void)noSearchData:(UITableView*)tableView{
    CGFloat orginFooterHeight=tableView.tableFooterView.frame.size.height;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(95,(orginFooterHeight-177)/2, 130, 177)];
    imageView.image = [GetImagePath getImagePath:@"nodata"];
    [tableView.tableFooterView addSubview:imageView];
}

+(void)removeFootView:(UITableView*)tableView{
    tableView.tableFooterView=nil;
}
@end
