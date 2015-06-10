//
//  MyFocusProjectController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/5/22.
//
//

#import "MyFocusProjectController.h"
#import "projectModel.h"
#import "ProjectTableViewCell.h"
#import "ProgramDetailViewController.h"
#import "ProjectApi.h"
#import "ErrorCode.h"
#import "IsFocusedApi.h"
#import "LoginSqlite.h"
@interface MyFocusProjectController()<ProjectTableViewCellDelegate>

@end

@implementation MyFocusProjectController
- (void)setUp{
    [super setUp];
    [self loadList];
    [self setUpRefreshWithNeedHeaderRefresh:YES needFooterRefresh:YES];
}

-(void)loadList{
    self.startIndex = 0;
    [self startLoading];
    [IsFocusedApi GetProjectFocusWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.models = posts;
            [self.tableView reloadData];
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorView errorViewWithFrame:CGRectMake(0, 50, 320, kScreenHeight-50) superView:self.view reloadBlock:^{
                    [self loadList];
                }];
            }
        }
        [self endLoading];
    } userId:[LoginSqlite getdata:@"userId"] startIndex:0 noNetWork:^{
        [self endLoading];
        [ErrorView errorViewWithFrame:CGRectMake(0, 50, 320, kScreenHeight-50) superView:self.view reloadBlock:^{
            [self loadList];
        }];
    }];
}

- (void)headerRereshing{
    [IsFocusedApi GetProjectFocusWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.startIndex = 0;
            self.models = posts;
            [self.tableView reloadData];
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorView errorViewWithFrame:CGRectMake(0, 50, 320, kScreenHeight-50) superView:self.view reloadBlock:^{
                    [self headerRereshing];
                }];
            }
        }
    } userId:[LoginSqlite getdata:@"userId"] startIndex:0 noNetWork:^{
        [self endLoading];
        [ErrorView errorViewWithFrame:CGRectMake(0, 50, 320, kScreenHeight-50) superView:self.view reloadBlock:^{
            [self headerRereshing];
        }];
    }];
}

- (void)footerRereshing{
    [IsFocusedApi GetProjectFocusWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.startIndex++;
            [self.models addObjectsFromArray:posts];
            [self.tableView reloadData];
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorView errorViewWithFrame:CGRectMake(0, 50, 320, kScreenHeight-50) superView:self.view reloadBlock:^{
                    [self footerRereshing];
                }];
            }
        }
    } userId:[LoginSqlite getdata:@"userId"] startIndex:(int)self.startIndex+1 noNetWork:^{
        [ErrorView errorViewWithFrame:CGRectMake(0, 50, 320, kScreenHeight-50) superView:self.view reloadBlock:^{
            [self footerRereshing];
        }];
    }];
}

- (void)startLoading{
    [super startLoading];
    NSLog(@"开始");
}

- (void)endLoading{
    [super endLoading];
    NSLog(@"结束");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"ProjectTableViewCell"];
    ProjectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    projectModel *model = self.models[indexPath.row];
    if(!cell){
        cell = [[ProjectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.model = model;
    cell.selectionStyle = NO;
    cell.delegate = self;
    cell.indexPath = indexPath;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGSize defaultSize = DEFAULT_CELL_SIZE;
    CGSize cellSize = [ProjectTableViewCell sizeForCellWithDefaultSize:defaultSize setupCellBlock:^id(id<CellHeightDelegate> cellToSetup) {
        projectModel *model = self.models[indexPath.row];
        [((ProjectTableViewCell *)cellToSetup) setModel:model];
        return cellToSetup;
    }];
    return cellSize.height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ProgramDetailViewController* vc=[[ProgramDetailViewController alloc]init];
    projectModel *model = self.models[indexPath.row];
    vc.projectId = model.a_id;
    vc.isFocused = model.isFocused;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)addFocused:(NSIndexPath *)indexPath{
    projectModel *model = self.models[indexPath.row];
    if([model.isFocused isEqualToString:@"0"]){
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:model.a_id forKey:@"targetId"];
        [dic setObject:@"03" forKey:@"targetCategory"];
        [IsFocusedApi AddFocusedListWithBlock:^(NSMutableArray *posts, NSError *error) {
            if(!error){
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"关注成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
                model.isFocused = @"1";
                [self.models replaceObjectAtIndex:indexPath.row withObject:model];
                [self.tableView reloadData];
            }else{
                if([ErrorCode errorCode:error] == 403){
                    [LoginAgain AddLoginView:NO];
                }else{
                    [ErrorCode alert];
                }
            }
        } dic:dic noNetWork:nil];
    }else{
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:model.a_id forKey:@"targetId"];
        [dic setObject:@"03" forKey:@"targetCategory"];
        [IsFocusedApi AddFocusedListWithBlock:^(NSMutableArray *posts, NSError *error) {
            if(!error){
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"取消关注成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
                model.isFocused = @"0";
                [self.models replaceObjectAtIndex:indexPath.row withObject:model];
                [self.tableView reloadData];
            }else{
                if([ErrorCode errorCode:error] == 403){
                    [LoginAgain AddLoginView:NO];
                }else{
                    [ErrorCode alert];
                }
            }
        } dic:dic noNetWork:^{
            [ErrorCode alert];
        }];
    }
}
@end
