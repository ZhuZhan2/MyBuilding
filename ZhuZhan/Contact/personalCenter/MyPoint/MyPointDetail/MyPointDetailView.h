//
//  MyPointDetailView.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/7/13.
//
//

#import <UIKit/UIKit.h>

@interface MyPointDetailView : UIView
+ (MyPointDetailView*)myPointDetailViewWithMainTitle:(NSString*)mainTitle subTitle:(NSString*)subTitle;
@property (nonatomic, strong)UILabel* mainTitleLabel;
@property (nonatomic, strong)UILabel* subTitleLabel;
@property (nonatomic, strong)UIView* bottomView;
@end
