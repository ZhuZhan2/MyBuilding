//
//  NoProductView.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/1/22.
//
//

#import "NoProductView.h"

@implementation NoProductView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        super.alwaysBounceVertical = YES;
        UIImageView *bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(82, 165, 154, 123)];
        [bgImage setImage:[GetImagePath getImagePath:@"暂无内容"]];
        [self addSubview:bgImage];
    }
    return self;
}

- (id)initWithFrameSearch:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        super.alwaysBounceVertical = YES;
        UIImageView *bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(80.5, 148, 151, 157)];
        [bgImage setImage:[GetImagePath getImagePath:@"search_empty"]];
        [self addSubview:bgImage];
    }
    return self;
}
@end
