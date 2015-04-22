//
//  ContractsListSearchController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/31.
//
//

#import "ContractsListSearchController.h"

@interface ContractsListSearchController ()
@property(nonatomic,strong)NSString *statusStr;
@property(nonatomic,strong)NSString *otherStr;
@property(nonatomic,strong)NSMutableArray* models;
@end

@implementation ContractsListSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)loadList{
    
}

-(CGFloat)searchBarTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 0;
}

-(UITableViewCell *)searchBarTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    return nil;
}

-(void)searchBarTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}
@end
