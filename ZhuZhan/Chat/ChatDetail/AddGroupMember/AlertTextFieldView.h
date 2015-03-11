//
//  AlertTextFieldView.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/11.
//
//

#import "BlackView.h"

@protocol AlertTextFieldViewDelegate <NSObject>
@optional
-(void)sureBtnClickedWithContent:(NSString*)content;
-(void)cancelBtnClicked;
@end

@interface AlertTextFieldView : BlackView
+(UIView *)alertTextFieldViewWithName:(NSString *)name sureBtnTitle:(NSString *)sureBtnTitle cancelBtnTitle:(NSString *)cancelBtnTitle originY:(CGFloat)originY delegate:(id<AlertTextFieldViewDelegate>)delegate;
@end
