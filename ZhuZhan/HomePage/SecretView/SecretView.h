//
//  SecretView.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/6/26.
//
//

#import <UIKit/UIKit.h>

@protocol SecretViewDelegate <NSObject>
-(void)closeView;
@end

@interface SecretView : UIView
@property(nonatomic,weak)id<SecretViewDelegate>delegate;
@end
