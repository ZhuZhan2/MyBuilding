//
//  MyFocusCompanyController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/5/22.
//
//

#import "MyFocusCompanyController.h"
#import "CompanyModel.h"
#import "ProjectTableViewCell.h"
#import "CompanyDetailViewController.h"
#import "IsFocusedApi.h"
#import "ErrorCode.h"
#import "LoginSqlite.h"
#import "MyFocusProductCell.h"
@interface MyFocusCompanyController()<MyFocusProductCellDelegate>

@end

@implementation MyFocusCompanyController
- (void)setUp{
    [super setUp];
    [self loadList];
    [self setUpRefreshWithNeedHeaderRefresh:YES needFooterRefresh:YES];
}

-(void)loadList{
    self.startIndex = 0;
    [self startLoading];
    [IsFocusedApi GetCompanyFocusWithBlock:^(NSMutableArray *posts, NSError *error) {
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
    [IsFocusedApi GetCompanyFocusWithBlock:^(NSMutableArray *posts, NSError *error) {
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
        [ErrorView errorViewWithFrame:CGRectMake(0, 50, 320, kScreenHeight-50) superView:self.view reloadBlock:^{
            [self headerRereshing];
        }];
    }];
}

- (void)footerRereshing{
    [IsFocusedApi GetCompanyFocusWithBlock:^(NSMutableArray *posts, NSError *error) {
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
    MyFocusProductCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell){
        cell = [[MyFocusProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.mainImageName = @"默认图_公司头像";
    }
    CompanyModel* dataModel = self.models[indexPath.row];
    
    MyFocusProductCellModel* cellModel = [[MyFocusProductCellModel alloc] init];
    cellModel.mainImageUrl = dataModel.a_companyLogo;
    cellModel.title = dataModel.a_companyName;
    cellModel.content = dataModel.a_companyIndustry;
    cellModel.status = [dataModel.a_focused isEqualToString:@"1"]?RKBtnStatusFinishSucess:RKBtnStatusNotStart;
    cellModel.indexPath = indexPath;
    
    cell.model = cellModel;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [MyFocusProductCell totalHeight];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CompanyModel *model = self.models[indexPath.row];
    CompanyDetailViewController* vc=[[CompanyDetailViewController alloc]init];
    vc.companyId = model.a_id;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)focusBtnClicked:(NSIndexPath *)indexPath{
    CompanyModel* dataModel = self.models[indexPath.row];
    BOOL addNotice = ![dataModel.a_focused isEqualToString:@"1"];
    NSString* companyId = dataModel.a_id;
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:companyId forKey:@"targetId"];
    [dic setObject:@"02" forKey:@"targetCategory"];
    [IsFocusedApi AddFocusedListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:addNotice?@"关注成功":@"取消关注成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            dataModel.a_focused = addNotice?@"1":@"0";
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

@end
