//
//  AskPriceMessageCell.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/4/16.
//
//

#import <UIKit/UIKit.h>
#import "AskPriceMessageModel.h"
#import "TableViewHeightCell.h"

@interface AskPriceMessageCell : TableViewHeightCell
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UIView *cutLine;
@property(nonatomic,strong)AskPriceMessageModel *model;
@end
