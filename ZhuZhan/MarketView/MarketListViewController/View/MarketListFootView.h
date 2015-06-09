//
//  MarketListFootView.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/6/9.
//
//

#import <UIKit/UIKit.h>

@protocol MarketListFootViewDelegate <NSObject>
-(void)addFriend;
@end

@interface MarketListFootView : UIView
@property (nonatomic,strong)UIImageView *cutLine1;
@property (nonatomic,strong)UIImageView *cutLine2;
@property (nonatomic,strong)UILabel *countLabel;
@property (nonatomic,strong)UIButton *addFriend;
@property (nonatomic,weak)id<MarketListFootViewDelegate>delegate;
+ (CGFloat)footViewHeight;
-(void)setCount:(NSString *)count isSelf:(BOOL)isSelf;
@end
