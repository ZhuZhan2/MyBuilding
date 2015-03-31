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
@property(nonatomic,strong)UILabel *titleLabel;//参与用户label
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIImageView *cutLine;
@property(nonatomic,strong)UITextField *textFied;
@property(nonatomic,weak)id<MoneyViewDelegate>delegate;
-(id)initWithFrame:(CGRect)frame isOver:(BOOL)isOver;
-(void)GetHeightOverWithBlock:(void (^)(double height))block str:(NSString *)str;
@end
