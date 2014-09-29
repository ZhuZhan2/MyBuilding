//
//  NBLabel.h
//  图文混排,除第一行,末尾为...
//
//  Created by 孙元侃 on 14-9-29.
//  Copyright (c) 2014年 sunyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NBLabel : UIView
@property(nonatomic)NSInteger line;
@property(nonatomic,strong)NSAttributedString* attributedText;
+(NBLabel *)labelWithLabelWidth:(CGFloat)labelWidth imageSize:(CGSize)imageSize font:(UIFont*)font lineHeight:(CGFloat)lineHeight;
@end
