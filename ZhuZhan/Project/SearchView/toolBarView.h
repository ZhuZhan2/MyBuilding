//
//  toolBarView.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-19.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol toolBarViewDelegate;
@interface toolBarView : UIView{
    id <toolBarViewDelegate> delegate;
}
@property(nonatomic ,strong) id <toolBarViewDelegate> delegate;
@end
@protocol toolBarViewDelegate <NSObject>
-(void)gotoView:(NSInteger)index;
@end