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
+(RKMuchBtns*)getMuchBtnsWithContents:(NSArray*)contents size:(CGSize)size;
-(void)setNormalTextColor:(UIColor*)normalTextColor normalBackColor:(UIColor*)normalBackColor highlightTextColor:(UIColor*)highlightTextColor highlightBackColor:(UIColor*)highlightBackColor;
@end
