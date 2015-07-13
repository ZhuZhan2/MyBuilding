//
//  MyPointTopView.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/7/13.
//
//

#import "MyPointTopView.h"
#import "RKShadowView.h"

@interface MyPointTopView()
@property(nonatomic,strong)NSString *pointTitleLabel;
@property(nonatomic,strong)NSString *pointLabel;
@property(nonatomic,strong)UIButton *pointDetailBtn;
@property(nonatomic,strong)UIButton *pointRulesBtn;
@property(nonatomic,strong)UIView *bottomView;
@end

@implementation MyPointTopView
-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
    }
    return self;
}

-(UIView *)bottomView{
    if(!_bottomView){
        
    }
    return _bottomView;
}
@end
