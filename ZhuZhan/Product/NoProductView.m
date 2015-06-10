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
        UIImageView *bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(87, 148, 147, 158)];
        [bgImage setImage:[GetImagePath getImagePath:@"search_empty2"]];
        [self addSubview:bgImage];
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if([self.delegate respondsToSelector:@selector(closeKeboard)]){
        [self.delegate closeKeboard];
    }
}
@end
