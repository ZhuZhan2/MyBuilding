//
//  ReceiveView.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/30.
//
//

#import <UIKit/UIKit.h>
@protocol ReceiveViewDelegate <NSObject>
-(void)textFiedDidBegin:(UITextField *)textField;
-(void)textFiedDidEnd:(NSString *)str textField:(UITextField *)textField;
@end
@interface ReceiveView : UIView<UITextFieldDelegate>
@property(nonatomic,strong)UIButton *addPersona;
@property(nonatomic,strong)UILabel *personaLabel;
@property(nonatomic,strong)UIImageView *addImageView;
@property(nonatomic,strong)UIView *cutLine;
@property(nonatomic,strong)UIButton *contactBtn;
@property(nonatomic,strong)UIImageView *arrowImageView;
@property(nonatomic,strong)UILabel *contactLabel;
@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,strong)UILabel *messageLabel;
@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,weak)id<ReceiveViewDelegate>delegate;
@end
