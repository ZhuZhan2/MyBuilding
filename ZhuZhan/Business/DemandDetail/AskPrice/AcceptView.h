//
//  AcceptView.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/4/7.
//
//

#import <UIKit/UIKit.h>
@class AcceptView;
@protocol AcceptViewDelegate <NSObject>
-(void)acceptViewSureBtnClicked:(AcceptView*)acceptView;
@end

@interface AcceptView : UIButton
@property(nonatomic,readonly)NSInteger sequnce;
@property(nonatomic,strong,readonly)NSArray* userNames;
@property(nonatomic,weak)id<AcceptViewDelegate>delegate;
-(instancetype)initWithUserNames:(NSArray*)userNames;
@end
