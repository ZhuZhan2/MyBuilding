//
//  MarketSearchProductCell.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/5/5.
//
//

#import <UIKit/UIKit.h>
#import "ProductModel.h"
@interface MarketSearchProductCell : UITableViewCell{
    UIImageView *headImageView;
    UILabel *titleLabel;
    UILabel *contentLabel;
    UILabel *projectCount;
}
@property(nonatomic,strong)ProductModel *model;
@end
