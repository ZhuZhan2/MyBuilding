//
//  MoneyView.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/30.
//
//

#import <UIKit/UIKit.h>
#import "MessageTextView.h"

@protocol MoneyViewDelegate <NSObject>
-(void)textFiedDidBegin:(UITextField *)textField;
-(void)textFiedDidEnd:(NSString *)str textField:(UITextField *)textField;
@end

@interface MoneyView : UIView<UITextFieldDelegate>
@property(nonatomic,strong)UITextField *textFied;
@property(nonatomic,strong)UIView *cutLine;
@property(nonatomic,weak)id<MoneyViewDelegate>delegate;
@end
