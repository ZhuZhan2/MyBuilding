//
//  RKMuchBtns.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/27.
//
//

#import <UIKit/UIKit.h>

@protocol RKMuchBtnsDelegate <NSObject>

@optional
-(void)muchBtnsClickedWithNumber:(NSInteger)number;

@end

@interface RKMuchBtns : UIView
+(RKMuchBtns*)muchBtnsWithContents:(NSArray*)contents mainSize:(CGSize)mainSize assistSize:(CGSize)assistSize assistStageCounts:(NSArray*)assistStageCounts delegate:(id<RKMuchBtnsDelegate>)delegate;

-(void)contentBtnsClickedWithNumber:(NSInteger)number;

-(void)setContentLabelWithNumber:(NSInteger)number enabled:(BOOL)enabled;

//未实现
-(void)setNormalTextColor:(UIColor*)normalTextColor normalBackColor:(UIColor*)normalBackColor highlightTextColor:(UIColor*)highlightTextColor highlightBackColor:(UIColor*)highlightBackColor;
@end
