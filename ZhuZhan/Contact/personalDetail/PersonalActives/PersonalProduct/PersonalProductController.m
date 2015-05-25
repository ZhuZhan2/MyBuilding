//
//  PersonalProductController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/5/22.
//
//

#import "PersonalProductController.h"
#import "MyFocusProductCellModel.h"
#import "MyFocusProductCell.h"
#import "IsFocusedApi.h"
#import "ErrorCode.h"
#import "LoginSqlite.h"
#import "ProductModel.h"
#import "ProductDetailViewController.h"
@interface PersonalProductController()<MyFocusProductCellDelegate>

@end

@implementation PersonalProductController
- (void)setUp{
    [super setUp];
    [self loadList];
    [self setUpRefreshWithNeedHeaderRefresh:YES needFooterRefresh:YES];
}

-(void)loadList{
    self.startIndex = 0;
    [self startLoading];
    
    [ProductModel GetProductListWithBlock:^(NSMutableArray *posts, NSError *error) {
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
    } startIndex:0 productDesc:@"" userId:self.targetId productIds:@"" noNetWork:^{
        [self endLoading];
        [ErrorView errorViewWithFrame:CGRectMake(0, 50, 320, kScreenHeight-50) superView:self.view reloadBlock:^{
            [self loadList];
        }];
        
    } ];
}

- (void)headerRereshing{
    [self startLoading];
    [ProductModel GetProductListWithBlock:^(NSMutableArray *posts, NSError *error) {
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
        [self endLoading];
    } startIndex:0 productDesc:@"" userId:self.targetId productIds:@"" noNetWork:^{
        [self endLoading];
        [ErrorView errorViewWithFrame:CGRectMake(0, 50, 320, kScreenHeight-50) superView:self.view reloadBlock:^{
            [self headerRereshing];
        }];
    }];
}

- (void)footerRereshing{
    [self startLoading];
    [ProductModel GetProductListWithBlock:^(NSMutableArray *posts, NSError *error) {
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
        [self endLoading];
    } startIndex:(int)self.startIndex+1 productDesc:@"" userId:self.targetId productIds:@"" noNetWork:^{
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
    MyFocusProductCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell){
        cell = [[MyFocusProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.delegate = self;
    }
    ProductModel* dataModel = self.models[indexPath.row];
    
    MyFocusProductCellModel* cellModel = [[MyFocusProductCellModel alloc] init];
    cellModel.mainImageUrl = dataModel.a_originImageUrl;
    cellModel.title = dataModel.a_name;
    cellModel.content = dataModel.a_content;
    cellModel.status = [dataModel.a_isFocused isEqualToString:@"1"]?RKBtnStatusFinishSucess:RKBtnStatusNotStart;
    cellModel.indexPath = indexPath;
    
    cell.model = cellModel;
    cell.selectionStyle = NO;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [MyFocusProductCell totalHeight];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ProductModel* model=self.models[indexPath.row];
    ProductDetailViewController* vc=[[ProductDetailViewController alloc]initWithProductModel:model];
    vc.type = @"01";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)focusBtnClicked:(NSIndexPath *)indexPath{
    ProductModel* dataModel = self.models[indexPath.row];
    BOOL addNotice = ![dataModel.a_isFocused isEqualToString:@"1"];
    NSString* productId = dataModel.a_id;
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:productId forKey:@"targetId"];
    [dic setObject:@"04" forKey:@"targetCategory"];
    [IsFocusedApi AddFocusedListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:addNotice?@"关注成功":@"取消关注成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            dataModel.a_isFocused = addNotice?@"1":@"0";
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
