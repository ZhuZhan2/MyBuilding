//
//  ChatMessageImageView.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/5/18.
//
//

#import <UIKit/UIKit.h>

@interface ChatMessageImageView : UIImageView
@property(nonatomic)BOOL isSelf;
- (instancetype)initWithFrame:(CGRect)frame isSelf:(BOOL)isSelf;
@end
