//
//  MarketView.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/5/5.
//
//

#import <UIKit/UIKit.h>
#import "AdScrollView.h"
#import "AdDataModel.h"

@protocol MarketViewDelegate <NSObject>
-(void)gotoContactView;
@end

@interface MarketView : UIView<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)AdScrollView *adScrollView;
@property(nonatomic,strong)UIImageView *centerImageView;
@property(nonatomic,strong)UIImageView *phoneImageView;
@property(nonatomic,strong)UIImageView *homeImageView;
@property(nonatomic,strong)UIButton *contactBtn;
@property(nonatomic,strong)UIButton *searchBtn;
@property(nonatomic,strong)UIViewController *controller;
@property(nonatomic,weak)id<MarketViewDelegate>delegate;
-(id)initWithFrame:(CGRect)frame controller:(UIViewController *)controller;
@end
