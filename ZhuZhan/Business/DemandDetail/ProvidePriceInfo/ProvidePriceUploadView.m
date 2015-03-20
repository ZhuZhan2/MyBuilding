//
//  ProvidePriceUploadView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/20.
//
//

#import "ProvidePriceUploadView.h"
#import "RKMuchImageViews.h"
@interface ProvidePriceUploadView ()
@property(nonatomic,strong)UIView* btnsView;
@property(nonatomic,strong)UILabel* remindLabel;
@property(nonatomic,strong)RKMuchImageViews* priceMuchImage;
@property(nonatomic,strong)RKMuchImageViews* qualityMuchImage;
@property(nonatomic,strong)RKMuchImageViews* otherMuchImage;
@end

@implementation ProvidePriceUploadView
+(ProvidePriceUploadView*)uploadViewWithFirstAccessorys:(NSArray*)firstAccessorys secondAccessory:(NSArray*)secondAccessory thirdAccessory:(NSArray*)thirdAccessory maxWidth:(CGFloat)maxWidth topDistance:(CGFloat)topDistance bottomDistance:(CGFloat)bottomDistance{
    ProvidePriceUploadView* view=[[ProvidePriceUploadView alloc]initWithFrame:CGRectZero];
    [view setUp];
    return view;
}

-(void)setUp{
    
}
/*
 @property(nonatomic,strong)UIView* btnsView;
 @property(nonatomic,strong)UILabel* remindLabel;
 @property(nonatomic,strong)RKMuchImageViews* priceMuchImage;
 @property(nonatomic,strong)RKMuchImageViews* qualityMuchImage;
 @property(nonatomic,strong)RKMuchImageViews* otherMuchImage;
 */
-(UIView *)btnsView{
    if (!_btnsView) {
        _btnsView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 75, 26)];
    }
    return _btnsView;
}
@end
