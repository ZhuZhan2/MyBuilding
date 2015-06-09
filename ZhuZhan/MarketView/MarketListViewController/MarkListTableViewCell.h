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
#import "MarketListFootView.h"

@protocol MarkListTableViewCellDelegate <NSObject>
-(void)addFriend:(NSIndexPath *)indexPath;
@end

@interface MarkListTableViewCell : BaseTableViewCell<MarketListFootViewDelegate>
@property(nonatomic,strong)MarketListTitleView *titleView;
@property(nonatomic,strong)MarketListFootView *footView;
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UILabel *firstTitleLabel;
@property(nonatomic,strong)UILabel *firstContentLabel;
@property(nonatomic,strong)UILabel *secondTitleLabel;
@property(nonatomic,strong)UILabel *secondContentLabel;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,strong)MarketModel *marketModel;
@property(nonatomic,strong)id<MarkListTableViewCellDelegate>delegate;
+ (CGFloat)carculateCellHeightWithModel:(MarketModel *)cellModel;
@end
