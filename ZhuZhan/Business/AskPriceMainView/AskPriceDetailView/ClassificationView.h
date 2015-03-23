//
//  ClassificationView.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/23.
//
//

#import <UIKit/UIKit.h>
#import "RKShadowView.h"
@interface ClassificationView : UIView
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *cateroryLabel;
@property(nonatomic,strong)UIImageView *cutLine;
@property(nonatomic,strong)UIView *shadowView;
-(void)GetHeightWithBlock:(void (^)(double height))block str:(NSString *)str;
@end
