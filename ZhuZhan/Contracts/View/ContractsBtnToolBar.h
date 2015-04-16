//
//  ContractsBtnToolBar.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/4/16.
//
//

#import <UIKit/UIKit.h>

@protocol ContractsBtnToolBarDelegate <NSObject>
-(void)contractsBtnToolBarClickedWithBtn:(UIButton*)btn index:(NSInteger)index;
@end

@interface ContractsBtnToolBar : UIView
+(ContractsBtnToolBar*)contractsBtnToolBarWithBtns:(NSArray*)btns contentMaxWidth:(CGFloat)contentMaxWidth top:(CGFloat)top bottom:(CGFloat)bottom contentHeight:(CGFloat)contentHeight;
@property (nonatomic, weak)id<ContractsBtnToolBarDelegate> delegate;
@end
