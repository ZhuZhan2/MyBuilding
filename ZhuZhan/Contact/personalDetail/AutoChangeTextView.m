//
//  AutoChangeTextView.m
//  ZhuZhan
//
//  Created by Jack on 14-9-4.
//
//

#import "AutoChangeTextView.h"

@implementation AutoChangeTextView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.editable =NO;
        self.textAlignment = NSTextAlignmentLeft;
        self.font = [UIFont systemFontOfSize:14];
    }
    return self;
}


@end
