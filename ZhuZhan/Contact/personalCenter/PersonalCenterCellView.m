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
    UIView* contentView=[self getContentViewWithImageUrl:imageUrl content:content category:category];
    [view addSubview:contentView];
    
    view.frame=CGRectMake(0, 0, 320, contentView.frame.size.height+20);
    return view;
}

+(UIView *)getContentViewWithImageUrl:(NSString *)imageUrl content:(NSString *)content category:(NSString *)category{
    UIView* view=[[UIView alloc]initWithFrame:CGRectZero];
    view.backgroundColor=[UIColor whiteColor];
    
    CGFloat contentX=10;
    CGFloat height=0;
    imageUrl=@"dasdas";
    if (![imageUrl isEqualToString:@""]) {
        EGOImageView* imageView=[[EGOImageView alloc]initWithPlaceholderImage:[GetImagePath getImagePath:@"公司认证员工_05a"]];
        imageView.frame=CGRectMake(10, 10, 60, 60);
        imageView.imageURL=[NSURL URLWithString:@"http://pic2.ooopic.com/01/27/78/24b1OOOPICa7.jpg"];//[NSURL URLWithString:[NSString stringWithFormat:@"%s%@",serverAddress,imageUrl]];
        [view addSubview:imageView];
        contentX=80;
    }
    
    //contentLabel
    UILabel* contentLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    UIFont* font=[UIFont systemFontOfSize:13];
    contentLabel.numberOfLines=3;
    //reminderLabel
    UILabel* reminderLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    if (![imageUrl isEqualToString:@""]) {
        contentLabel.frame=CGRectMake(contentX, 8, 235-contentX-10, 47);
        reminderLabel.frame=CGRectMake(contentX, 8+47, contentLabel.frame.size.width, 15);
    }
    contentLabel.font=font;
    contentLabel.text=content;
    contentLabel.backgroundColor=[UIColor greenColor];
    [view addSubview:contentLabel];
    
    reminderLabel.font=font;
    
    reminderLabel.attributedText;
    

    view.frame=CGRectMake(70, 10, 235, 80);
    return view;
}

@end
