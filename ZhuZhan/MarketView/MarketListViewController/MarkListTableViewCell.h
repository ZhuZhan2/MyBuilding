//
//  MarkListTableViewCell.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/6/4.
//
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
#import "MarketListTitleView.h"
#import "MarketModel.h"

@interface MarkListTableViewCell : BaseTableViewCell
@property(nonatomic,strong)MarketListTitleView *titleView;
@property(nonatomic,strong)MarketModel *marketModel;
+ (CGFloat)carculateCellHeightWithModel:(MarketModel *)cellModel;
@end
