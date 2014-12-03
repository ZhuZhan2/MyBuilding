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
@end
