//
//  CommentView.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-3.
//
//

#import "CommentView.h"
#import "EGOImageView.h"
@implementation CommentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
+(CommentView *)setFram:(CommentModel *)model{
    CommentView *commentView = [[CommentView alloc] init];
    UIImageView *topLineImage = [[UIImageView alloc] initWithFrame:CGRectMake(75, 0, 2, 5)];
    [topLineImage setBackgroundColor:[UIColor blackColor]];
    [commentView addSubview:topLineImage];
    topLineImage.alpha =0.2;
    
    EGOImageView *imageView = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:model.imageUrl]];
    [commentView addSubview:imageView];
    return commentView;
}
@end
