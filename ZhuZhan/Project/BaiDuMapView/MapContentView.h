//
//  MapContentView.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-7-14.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "projectModel.h"

@protocol MapContentViewDelegate <NSObject>
-(void)gotoLoginView;
-(void)addFocus:(NSInteger)index isFocused:(BOOL)isFocused;
@end

@interface MapContentView : UIView
@property(nonatomic,strong)UIImageView *backgroundImageView;
@property(nonatomic,strong)UIImageView *cutLine;
@property(nonatomic,strong)UIImageView *redImageView;
@property(nonatomic,strong)UILabel *countLabel;
@property(nonatomic,strong)UILabel *stageLabel;
@property(nonatomic,strong)UIButton *focusBtn;
@property(nonatomic,strong)UILabel *projectName;
@property(nonatomic,strong)UILabel *projectAddress;
@property(nonatomic,strong)UILabel *projectInvestment;
@property(nonatomic,strong)UILabel *projectArea;
@property(nonatomic,strong)UILabel *projectInvestmentCount;
@property(nonatomic,strong)UILabel *projectAreaCount;
@property(nonatomic,strong)UILabel *lastUpdatedTime;
@property(nonatomic,strong)UILabel *lastUpdatedTimeCount;
@property(nonatomic,strong)NSString *isFocused;
@property(nonatomic,strong)projectModel *model;
@property(nonatomic,strong)NSString *number;
@property(nonatomic)NSInteger index;
@property(nonatomic,weak)id<MapContentViewDelegate>delegate;
- (id)initWithFrame:(CGRect)frame model:(projectModel *)model number:(NSString *)number index:(NSInteger)index;
@end
