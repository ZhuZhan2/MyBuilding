//
//  ErrorView.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-11.
//
//

#import <UIKit/UIKit.h>


@protocol ErrorViewDelegate <NSObject>

-(void)reloadView;

@end
@interface ErrorView : UIView
@property(nonatomic,weak)id<ErrorViewDelegate>delegate;
@end
