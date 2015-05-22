//
//  MyFocusUserController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/5/22.
//
//

#import "MyFocusUserController.h"
#import "projectModel.h"
#import "ProjectTableViewCell.h"
#import "ProgramDetailViewController.h"
#import "ProjectApi.h"
#import "ErrorCode.h"
@interface MyFocusUserController()

@end

@implementation MyFocusUserController
- (void)setUp{
    [super setUp];
    [self loadList];
    [self setUpRefreshWithNeedHeaderRefresh:YES needFooterRefresh:YES];
}

-(void)loadList{
    self.startIndex = 0;
    [self startLoading];
    [ProjectApi GetPiProjectSeachWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.models = posts[0];
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
    } startIndex:0 keywords:@"" noNetWork:^{
        [self endLoading];
        [ErrorView errorViewWithFrame:CGRectMake(0, 50, 320, kScreenHeight-50) superView:self.view reloadBlock:^{
            [self loadList];
        }];
    }];
}

- (void)headerRereshing{
    [self startLoading];
    [ProjectApi GetPiProjectSeachWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.startIndex = 0;
            self.models = posts[0];
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
        [self endLoading];
    }startIndex:0 keywords:@"" noNetWork:^{
        [self endLoading];
        [ErrorView errorViewWithFrame:CGRectMake(0, 50, 320, kScreenHeight-50) superView:self.view reloadBlock:^{
            [self headerRereshing];
        }];
    }];
}

- (void)footerRereshing{
    [self startLoading];
    [ProjectApi GetPiProjectSeachWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.startIndex++;
            [self.models addObjectsFromArray:posts[0]];
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
        [self endLoading];
    }startIndex:(int)self.startIndex+1 keywords:@"" noNetWork:^{
        [self endLoading];
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
@end
