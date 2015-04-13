//
//  MessageTableView.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/4/11.
//
//

#import "MessageTableView.h"

@implementation MessageTableView

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    if ([self.delegate respondsToSelector:@selector(touchesBeganInMessageTableView)]) {
        [self.delegate touchesBeganInMessageTableView];
    }
}

- (void)setContentSize:(CGSize)contentSize
{
    if (!CGSizeEqualToSize(self.contentSize, CGSizeZero))
    {
        if (contentSize.height > self.contentSize.height)
        {
            CGPoint offset = self.contentOffset;
            offset.y += (contentSize.height - self.contentSize.height);
            self.contentOffset = offset;
        }
    }
    [super setContentSize:contentSize];
}
@end
