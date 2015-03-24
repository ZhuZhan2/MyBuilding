//
//  DemandAskPriceDetailController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/24.
//
//

#import "DemandAskPriceDetailController.h"

@interface DemandAskPriceDetailController ()

@end

@implementation DemandAskPriceDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        DemandDetailViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"detailCell"];
        if (!cell) {
            cell=[[DemandDetailViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"detailCell" delegate:self category:DemandControllerCategoryAskPriceController];
        }
        DemandDetailCellModel* model=self.detailModels[indexPath.row];
        model.indexPath=indexPath;
        cell.model=model;
        return cell;
}
@end
