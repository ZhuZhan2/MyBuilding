//
//  RKViewFactory.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/26.
//
//

#import "RKViewFactory.h"

@implementation RKViewFactory
+ (UIView *)noHistorySearchResultsViewWithTop:(CGFloat)top{
    UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 152, 158)];
    imageView.center = CGPointMake(kScreenWidth*0.5, CGRectGetHeight(imageView.frame)*0.5+top);
    imageView.image = [GetImagePath getImagePath:@"search_empty"];
    
    UIView* noDataView = [[UIView alloc]init];
    noDataView.backgroundColor = [UIColor whiteColor];
    [noDataView addSubview:imageView];
    return noDataView;
}

+ (UIView *)noSearchResultsViewWithTop:(CGFloat)top{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 154, 123)];
    imageView.center = CGPointMake(kScreenWidth*0.5, CGRectGetHeight(imageView.frame)*0.5+top);
    imageView.image = [GetImagePath getImagePath:@"暂无内容"];
    
    UIView* noDataView = [[UIView alloc]init];
    noDataView.backgroundColor = AllBackLightGratColor;
    [noDataView addSubview:imageView];
    return noDataView;
}
@end
