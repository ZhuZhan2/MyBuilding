//
//  RKMuchImageViews.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/18.
//
//

#import <UIKit/UIKit.h>

@protocol RKMuchImageViewsDelegate <NSObject>

-(void)imageCilckWithRKMuchImageViews:(NSString *)imageUrl type:(NSString *)type;

@end

@interface RKMuchImageViews : UIView
@property(nonatomic,strong)NSArray* models;
@property(nonatomic,weak)id<RKMuchImageViewsDelegate>delegate;
+(CGSize)carculateTotalHeightWithModels:(NSArray*)models width:(CGFloat)width;
+(RKMuchImageViews*)muchImageViewsWithWidth:(CGFloat)width title:(NSString*)title isAskPrice:(BOOL)isAskPrice;
-(NSArray*)editCenters;
@end
