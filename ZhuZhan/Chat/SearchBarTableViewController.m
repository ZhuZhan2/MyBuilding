//
//  SearchBarTableViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/10.
//
//

#import "SearchBarTableViewController.h"

@implementation SearchBarTableViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    [self initTableView];
}

-(void)reloadSearchBarTableViewData{
    [self.tableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(searchBarTableView:heightForRowAtIndexPath:)]) {
        return [self.delegate searchBarTableView:tableView heightForRowAtIndexPath:indexPath];
    }else{
        return 44;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.delegate respondsToSelector:@selector(searchBarTableView:numberOfRowsInSection:)]) {
        return [self.delegate searchBarTableView:tableView numberOfRowsInSection:section];
    }else{
        return 0;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([self.delegate respondsToSelector:@selector(searchBarNumberOfSectionsInTableView:)]) {
        return [self.delegate searchBarNumberOfSectionsInTableView:tableView];
    }else{
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate searchBarTableView:tableView cellForRowAtIndexPath:indexPath]) {
        return [self.delegate searchBarTableView:tableView cellForRowAtIndexPath:indexPath];
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}
@end
