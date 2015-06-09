//
//  MarketPopView.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/6/4.
//
//

#import <UIKit/UIKit.h>

@protocol MarketPopViewDelegate <NSObject>
-(void)closePopView;
-(void)selectIndex:(NSInteger)index;
@end

@interface MarketPopView : UIView
@property(nonatomic,weak)id<MarketPopViewDelegate>delegate;
@end
