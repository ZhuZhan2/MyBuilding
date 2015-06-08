//
//  MarketFlowView.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/6/4.
//
//

#import <UIKit/UIKit.h>

@protocol MarketFlowViewDataSource;
@protocol MarketFlowViewDelegate;

//向前滚向后滚
typedef enum {
    PageDirectionPrevious = 0,
    PageDirectionDown
} PageDirectionE;

@interface MarketFlowView : UIView
@property(nonatomic,weak)id<MarketFlowViewDataSource>dataSource;
@property(nonatomic,weak)id<MarketFlowViewDelegate>delegate;
@property(nonatomic,strong)UIImageView *defaultImageView;
@property(nonatomic)CGFloat padding;
- (void)reloadData;
-(UIView *)dequeueReusableCell;
@end

@protocol MarketFlowViewDataSource <NSObject>
//返回总页数
- (NSInteger)numberOfPagesInFlowView:(MarketFlowView *)flowView;
//页面卡片大小
- (CGSize)sizeForPageInFlowView:(MarketFlowView *)flowView;
//当前页面
- (UIView *)flowView:(MarketFlowView *)flowView cellForPageAtIndex:(NSInteger)index;
@end

@protocol  MarketFlowViewDelegate<NSObject>
//重置页面
- (void)didReloadData:(UIView *)cell cellForPageAtIndex:(NSInteger)index;

//不一定实现的方法
@optional
- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(MarketFlowView *)flowView;
- (void)didSelectItemAtIndex:(NSInteger)index inFlowView:(MarketFlowView *)flowView;
@end