//
//  PersonalHeadView.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/6/17.
//
//

#import <UIKit/UIKit.h>

@protocol PersonalHeadViewDelegate <NSObject>
-(void)selectBlock:(int)index;
@end

@interface PersonalHeadView : UIView
@property(nonatomic,strong)NSString *avatarUrl;
@property(nonatomic,strong)NSString *userName;
@property(nonatomic,weak)id<PersonalHeadViewDelegate>delegate;
@end
