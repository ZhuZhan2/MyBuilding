//
//  StartManView.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/30.
//
//

#import <UIKit/UIKit.h>
@protocol StartManViewDelegate <NSObject>
-(void)textFiedDidBegin:(UITextField *)textField;
-(void)textFiedDidEnd:(NSString *)str textField:(UITextField *)textField;
-(void)showActionSheet;
@end
@interface StartManView : UIView<UITextFieldDelegate>
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIView *cutLine;
@property(nonatomic,strong)UIButton *contactBtn;
@property(nonatomic,strong)UIImageView *arrowImageView;
@property(nonatomic,strong)UILabel *contactLabel;
@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,strong)UILabel *messageLabel;
@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,weak)id<StartManViewDelegate>delegate;
@end
