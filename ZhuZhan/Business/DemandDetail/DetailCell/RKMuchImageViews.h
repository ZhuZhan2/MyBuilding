//
//  RKMuchImageViews.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/18.
//
//

#import <UIKit/UIKit.h>

@interface RKMuchImageViews : UIView
@property(nonatomic,strong)NSArray* models;
+(CGSize)carculateTotalHeightWithModels:(NSArray*)models width:(CGFloat)width;
+(RKMuchImageViews*)muchImageViewsWithWidth:(CGFloat)width title:(NSString*)title;
-(NSArray*)editCenters;
@end
