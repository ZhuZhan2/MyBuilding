//
//  VIPhotoView.h
//  VIPhotoViewDemo
//
//  Created by Vito on 1/7/15.
//  Copyright (c) 2015 vito. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VIPhotoViewDelegate <NSObject>
-(void)closeBigImage;
@end

@interface VIPhotoView : UIScrollView
@property(nonatomic,weak)id<VIPhotoViewDelegate> bigImageDelegate;
- (instancetype)initWithFrame:(CGRect)frame andImageData:(NSData *)imageData;
- (instancetype)initWithFrame:(CGRect)frame imageUrl:(NSString *)imageUrl;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com