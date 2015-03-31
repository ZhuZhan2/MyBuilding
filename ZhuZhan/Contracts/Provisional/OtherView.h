//
//  OtherView.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/30.
//
//

#import <UIKit/UIKit.h>
#import "MessageTextView.h"
@protocol OtherViewDelegate <NSObject>
- (void)textViewDidBeginEditing:(MessageTextView *)textView;
- (void)textViewDidEndEditing:(MessageTextView *)textView;
@end

@interface OtherView : UIView<UITextViewDelegate>
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIView *cutLine;
@property(nonatomic,strong)MessageTextView *textView;
@property(nonatomic,weak)id<OtherViewDelegate>delegate;
-(id)initWithFrame:(CGRect)frame isOver:(BOOL)isOver;
-(void)GetHeightWithBlock:(void (^)(double height))block titleStr:(NSString *)titleStr;
-(void)GetHeightOverWithBlock:(void (^)(double height))block titleStr:(NSString *)titleStr contentStr:(NSString *)contentStr;
//返回最大显示高度
+ (CGFloat)maxHeight;
- (void)adjustTextViewHeightBy:(CGFloat)changeInHeight;
@end
