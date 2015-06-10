//
//  MarkListView.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/6/4.
//
//

#import <UIKit/UIKit.h>
#import "MarketModel.h"
@interface MarkListView : UIView
@property(nonatomic,strong)UIImageView *cutLine;
@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *typeLabel;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UILabel *firstTitleLabel;
@property(nonatomic,strong)UILabel *firstContentLabel;
@property(nonatomic,strong)UILabel *secondTitleLabel;
@property(nonatomic,strong)UILabel *secondContentLabel;
@property(nonatomic,strong)MarketModel *model;
@end
