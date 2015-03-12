//
//  ImageAndLabelView.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/11.
//
//

#import <UIKit/UIKit.h>

@protocol ImageAndLabelViewDelegate <NSObject>
-(void)addImageBtnClicked;
@end

@interface ImageAndLabelView : UIView
+(ImageAndLabelView*)imageAndLabelViewWithImageUrl:(NSString*)imageUrl content:(NSString*)content isAddImage:(BOOL)isAddImage delegate:(id<ImageAndLabelViewDelegate>)delegate;
@end
