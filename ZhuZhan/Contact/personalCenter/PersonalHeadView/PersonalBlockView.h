//
//  PersonalBlockView.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/6/17.
//
//

#import <UIKit/UIKit.h>

@protocol PersonalBlockViewDelegate <NSObject>
-(void)clickButton:(int)index;
@end

@interface PersonalBlockView : UIView
@property(nonatomic,strong)UIImage *image;
@property(nonatomic,strong)NSString *title;
@property(nonatomic)int index;
@property(nonatomic,weak)id<PersonalBlockViewDelegate>delegate;
@end
