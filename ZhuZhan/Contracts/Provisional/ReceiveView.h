//
//  ReceiveView.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/30.
//
//

#import <UIKit/UIKit.h>

@interface ReceiveView : UIView
@property(nonatomic,strong)UILabel *titleLabel;//参与用户label
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIView *addView;
@property(nonatomic,strong)UIImageView *cutLine;
-(id)initWithFrame:(CGRect)frame isOver:(BOOL)isOver;
-(void)GetHeightWithBlock:(void (^)(double height))block str:(NSString *)str;
-(void)GetHeightOverWithBlock:(void (^)(double height))block str:(NSString *)str;
@end
