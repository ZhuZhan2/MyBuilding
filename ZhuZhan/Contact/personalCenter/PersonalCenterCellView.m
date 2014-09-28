//
//  PersonalCenterCellView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 14-9-28.
//
//
#import "PersonalCenterCellView.h"
#import "EGOImageView.h"
#define viewWidth 200
@implementation PersonalCenterCellView
+(UIView *)getPersonalCenterCellViewWithImageUrl:(NSString *)imageUrl content:(NSString *)content category:(NSString *)category{
    UIView* view=[[UIView alloc]initWithFrame:CGRectZero];
    CGFloat contentX=10;
    CGFloat height=0;
    if (![imageUrl isEqualToString:@""]) {
        EGOImageView* imageView=[[EGOImageView alloc]initWithPlaceholderImage:[GetImagePath getImagePath:@"公司认证员工_05a"]];
        imageView.frame=CGRectMake(10, 10, 70, 70);
        imageView.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%s%@",serverAddress,imageUrl]];
        [view addSubview:imageView];
        contentX=90;
    }
    UILabel* contentLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    contentLabel.numberOfLines=3;
    UILabel* reminderLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    if (![imageUrl isEqualToString:@""]) {
        contentLabel.frame=CGRectMake(contentX, 10, 200, 50);
    }
    return view;
}

@end
