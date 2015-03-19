//
//  AddMarkView.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/19.
//
//

#import <UIKit/UIKit.h>

@protocol AddMarkViewDelegate <NSObject>
-(void)beginTextView;
-(void)endTextView:(NSString *)str;
@end

@interface AddMarkView : UIView<UITextViewDelegate>
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIImageView *cutLine;
@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)UILabel *placeLabel;
@property(nonatomic,weak)id<AddMarkViewDelegate>delegate;
@end
