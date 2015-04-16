//
//  ContractsBtnToolBar.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/4/16.
//
//

#import "ContractsBtnToolBar.h"

@interface ContractsBtnToolBar ()
@property (nonatomic, strong)NSArray* btns;
@property (nonatomic)CGFloat contentMaxWidth;

@property (nonatomic)CGFloat top;
@property (nonatomic)CGFloat bottom;
@property (nonatomic)CGFloat contentHeight;
@end

@implementation ContractsBtnToolBar
+(ContractsBtnToolBar*)contractsBtnToolBarWithBtns:(NSArray*)btns contentMaxWidth:(CGFloat)contentMaxWidth top:(CGFloat)top bottom:(CGFloat)bottom contentHeight:(CGFloat)contentHeight{
    ContractsBtnToolBar* btnToolBar=[[ContractsBtnToolBar alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, top+bottom+contentHeight)];
    btnToolBar.backgroundColor=AllBackDeepGrayColor;
    btnToolBar.top=top;
    btnToolBar.bottom=bottom;
    btnToolBar.contentHeight=contentHeight;
    btnToolBar.btns=btns;
    btnToolBar.contentMaxWidth=contentMaxWidth;
    [btnToolBar setUp];
    return btnToolBar;
}

-(void)setUp{
    CGFloat const sideDistance=(kScreenWidth-self.contentMaxWidth)/2;
    __block CGFloat totalBtnWidth=0;
    [self.btns enumerateObjectsUsingBlock:^(UIButton* btn, NSUInteger idx, BOOL *stop) {
        CGRect frame=btn.frame;
        totalBtnWidth+=frame.size.width;
    }];
    
    CGFloat const everyDistance=(self.contentMaxWidth-totalBtnWidth)/(self.btns.count-1);
    __block CGFloat nowX=sideDistance;
    [self.btns enumerateObjectsUsingBlock:^(UIButton* btn, NSUInteger idx, BOOL *stop) {
        if (idx) {
            nowX+=everyDistance;
        }
        
        CGRect frame=btn.frame;
        frame.origin.x=nowX;
        frame.origin.y=self.top;
        btn.frame=frame;
        
        nowX+=CGRectGetWidth(frame);
        [self addSubview:btn];
    }];
    
    [self.btns enumerateObjectsUsingBlock:^(UIButton* btn, NSUInteger idx, BOOL *stop) {
        btn.tag=idx;
        [btn addTarget:self action:@selector(btnsClicked:) forControlEvents:UIControlEventTouchUpInside];
    }];
}

-(void)btnsClicked:(UIButton*)btn{
    if ([self.delegate respondsToSelector:@selector(contractsBtnToolBarClickedWithBtn:index:)]) {
        [self.delegate contractsBtnToolBarClickedWithBtn:btn index:btn.tag];
    }
}
@end
