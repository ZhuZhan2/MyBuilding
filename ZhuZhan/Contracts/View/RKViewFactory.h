//
//  RKViewFactory.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/26.
//
//

#import <Foundation/Foundation.h>

@interface RKViewFactory : NSObject
+ (UIView*)noHistorySearchResultsViewWithTop:(CGFloat)top;

+ (UIView*)noSearchResultsViewWithTop:(CGFloat)top;

+ (void)imageViewWithImageView:(UIImageView*)imageView imageUrl:(NSString*)imageUrl defaultImageName:(NSString*)defaultImageName;
@end
