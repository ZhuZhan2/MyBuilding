//
//  RecommendLetterViewController.h
//  ZhuZhan
//
//  Created by Jack on 14-8-29.
//
//

#import <UIKit/UIKit.h>

@interface RecommendLetterViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate>

@property (nonatomic,strong)UIImageView *iconImageView;
@property (nonatomic,strong)UITextField *themeField;
@property (nonatomic,strong)UITextView *contentView;
@end
