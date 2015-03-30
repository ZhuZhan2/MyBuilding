//
//  MessageTextView.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/30.
//
//

#import <UIKit/UIKit.h>

@interface MessageTextView : UITextView
@property (nonatomic, copy) NSString *placeHolder;
@property (nonatomic, strong) UIColor *placeHolderTextColor;
//行数
- (NSUInteger)numberOfLinesOfText;
//每行的高度
+ (NSUInteger)maxCharactersPerLine;
//文本占据自身适应宽带的行数
+ (NSUInteger)numberOfLinesForMessage:(NSString *)text;
- (NSUInteger)numberOfLines:(NSString *)text;
@end
