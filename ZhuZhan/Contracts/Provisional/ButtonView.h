//
//  ButtonView.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/31.
//
//

#import <UIKit/UIKit.h>

@interface ButtonView : UIView
@property(nonatomic,strong)UIButton *sumbitBtn;
@property(nonatomic,strong)UIButton *agreeBtn;
@property(nonatomic,strong)UIButton *noAgreeBtn;
@property(nonatomic,strong)UIButton *closeBtn;
@property(nonatomic,strong)UIButton *changeBtn;
@property(nonatomic,strong)UIButton *saveBtn;

//flage 1 提交 2同意 不同意 3关闭 保存 4关闭 修改
-(id)initWithFrame:(CGRect)frame flag:(int)flag;
@end
