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
-(void)headClick:(NSString *)userId;
@end

@interface ImageAndLabelView : UIView
+(ImageAndLabelView*)imageAndLabelViewWithImageUrl:(NSString*)imageUrl content:(NSString*)content userId:(NSString *)userId isAddImage:(BOOL)isAddImage delegate:(id<ImageAndLabelViewDelegate>)delegate;
@end
