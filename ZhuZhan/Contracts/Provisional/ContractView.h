//
//  ContractView.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/30.
//
//

#import <UIKit/UIKit.h>
#import "MessageTextView.h"
@protocol ContractViewDelegate <NSObject>
-(void)beginTextView;
-(void)endTextView:(NSString *)str;
@end
@interface ContractView : UIView<UITextViewDelegate>
@property(nonatomic,strong)MessageTextView *textView;
@property(nonatomic,weak)id<ContractViewDelegate>delegate;
@end
