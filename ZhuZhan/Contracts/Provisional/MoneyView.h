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
-(void)textFiedDidBegin;
-(void)textFiedDidEnd:(NSString *)str;
@end

@interface MoneyView : UIView<UITextFieldDelegate>
@property(nonatomic,strong)UITextField *textFied;
@property(nonatomic,strong)UIView *cutLine;
@property(nonatomic,weak)id<MoneyViewDelegate>delegate;
@end
