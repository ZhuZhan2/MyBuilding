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
        UIImageView *bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(94, 138, 130, 177)];
        [bgImage setImage:[GetImagePath getImagePath:@"nodata"]];
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
