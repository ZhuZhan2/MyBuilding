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
/*
 NSArray* imageNames=@[@"不同意迷你带字",@"同意迷你带字",@"上传迷你带字",@"选项按钮"];
 NSArray* imageNames=@[@"不同意小带字",@"同意小带字",@"上传小带字"];
 NSArray* imageNames=@[@"不同意带字",@"同意带字"];
 
 _btnToolBar=[ContractsBtnToolBar contractsBtnToolBarWithBtns:btns contentMaxWidth:295 top:5 bottom:30 contentHeight:37];
 _btnToolBar=[ContractsBtnToolBar contractsBtnToolBarWithBtns:btns contentMaxWidth:270 top:5 bottom:30 contentHeight:37];
 */
@interface ContractsBtnToolBar : UIView
+(ContractsBtnToolBar*)contractsBtnToolBarWithBtns:(NSArray*)btns contentMaxWidth:(CGFloat)contentMaxWidth top:(CGFloat)top bottom:(CGFloat)bottom contentHeight:(CGFloat)contentHeight;
@property (nonatomic, weak)id<ContractsBtnToolBarDelegate> delegate;
@end
