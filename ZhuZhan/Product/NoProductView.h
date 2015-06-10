//
//  NoProductView.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/1/22.
//
//

#import <UIKit/UIKit.h>

@protocol NoProductViewDelegate <NSObject>
-(void)closeKeboard;
@end

@interface NoProductView : UIScrollView
@property(nonatomic,weak)id<NoProductViewDelegate>delegate;
- (id)initWithFrame:(CGRect)frame;
- (id)initWithFrameSearch:(CGRect)frame;
@end
