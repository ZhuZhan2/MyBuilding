//
//  MainBuild.m
//  ZpzchinaMobile
//
//  Created by 孙元侃 on 14-8-25.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "MainBuild.h"
#import "MyFactory.h"
@interface MainBuild ()
@property(nonatomic)NSInteger part;
@property(nonatomic,weak)id<ShowPageDelegate>delegate;
@end
@implementation MainBuild

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)getFirstView{
    ////地平阶段
    self.firstView=[[UIView alloc]initWithFrame:CGRectZero];
    
    NSArray* secondStrs=[self.delegate getTwoLinesTitleViewFirstStrsAndSecondStrsWithIndexPath:[MyIndexPath getIndexPart:self.part section:0]];
    UIView* view0=[MyFactory getTwoLinesTitleViewWithTitle:@"地平阶段" titleImage:[UIImage imageNamed:@"XiangMuXiangQing_2/Subject_02@2x.png"] firstStrs:@[@"实际开工时间"] secondStrs:secondStrs];
    
    NSArray* images=[self.delegate getImageViewWithImageAndCountWithIndexPath:[MyIndexPath getIndexPart:self.part section:0]];
    UIView* view1=[MyFactory getImageViewWithImage:images[0] count:[images[1] integerValue]];
    
    NSArray* fiveStrs=[self.delegate getThreeContactsViewThreeTypesFiveStrsWithIndexPath:[MyIndexPath getIndexPart:self.part section:0]];
    UIView* view2=[MyFactory getThreeContactsViewThreeTypesFiveStrs:fiveStrs];
    
    NSArray* tempAry=@[view0,view1,view2];
    CGFloat height=0;
    for (int i=0; i<tempAry.count; i++) {
        CGRect frame=[tempAry[i] frame];
        frame.origin.y=height;
        [tempAry[i] setFrame:frame];
        [self.firstView addSubview:tempAry[i]];
        height+=[tempAry[i] frame].size.height;
    }
    self.firstView.frame=CGRectMake(0, 0, 320,height);
}
-(void)getSecondView{
    //桩基基坑
    self.secondView=[[UIView alloc]initWithFrame:CGRectZero];
    
    UIView* view0=[MyFactory getNoLineTitleViewWithTitle:@"桩基基坑" titleImage:[UIImage imageNamed:@"XiangMuXiangQing_2/Subject_02@2x.png"]];
    
    NSArray* images=[self.delegate getImageViewWithImageAndCountWithIndexPath:[MyIndexPath getIndexPart:self.part section:1]];
    UIView* view1=[MyFactory getImageViewWithImage:images[0] count:[images[1] integerValue]];
    
    NSArray* fiveStrs=[self.delegate getThreeContactsViewThreeTypesFiveStrsWithIndexPath:[MyIndexPath getIndexPart:self.part section:1]];
    UIView* view2=[MyFactory getThreeContactsViewThreeTypesFiveStrs:fiveStrs];
    
    NSArray* tempAry=@[view0,view1,view2];
    CGFloat height=0;
    for (int i=0; i<tempAry.count; i++) {
        CGRect frame=[tempAry[i] frame];
        frame.origin.y=height;
        [tempAry[i] setFrame:frame];
        [self.secondView addSubview:tempAry[i]];
        height+=[tempAry[i] frame].size.height;
    }
    self.secondView.frame=CGRectMake(0, 0, 320,height);
}
-(void)getThirdView{
    //主体施工
    self.thirdView=[[UIView alloc]initWithFrame:CGRectZero];
    
    UIView* view0=[MyFactory getNoLineTitleViewWithTitle:@"主体施工" titleImage:[UIImage imageNamed:@"XiangMuXiangQing_2/Subject_02@2x.png"]];
    
    NSArray* images=[self.delegate getImageViewWithImageAndCountWithIndexPath:[MyIndexPath getIndexPart:self.part section:2]];
    UIView* view1=[MyFactory getImageViewWithImage:images[0] count:[images[1] integerValue]];
    
    NSArray* tempAry=@[view0,view1];
    CGFloat height=0;
    for (int i=0; i<tempAry.count; i++) {
        CGRect frame=[tempAry[i] frame];
        frame.origin.y=height;
        [tempAry[i] setFrame:frame];
        [self.thirdView addSubview:tempAry[i]];
        height+=[tempAry[i] frame].size.height;
    }
    self.thirdView.frame=CGRectMake(0, 0, 320,height);
}
-(void)getFourthView{
    //消防/景观绿化
    self.fourthView=[[UIView alloc]initWithFrame:CGRectZero];
    
    UIView* view0=[MyFactory getNoLineTitleViewWithTitle:@"消防/景观绿化" titleImage:[UIImage imageNamed:@"XiangMuXiangQing_2/Subject_02@2x.png"]];
    
    NSArray* secondStrs=[self.delegate getBlackTwoLinesWithStrsWithIndexPath:[MyIndexPath getIndexPart:self.part section:3]];
    UIView* view1=[MyFactory getBlackTwoLinesWithFirstStr:@[@"消防",@"景观绿化"] secondStr:secondStrs];
    
    NSArray* tempAry=@[view0,view1];
    CGFloat height=0;
    for (int i=0; i<tempAry.count; i++) {
        CGRect frame=[tempAry[i] frame];
        frame.origin.y=height;
        [tempAry[i] setFrame:frame];
        [self.fourthView addSubview:tempAry[i]];
        height+=[tempAry[i] frame].size.height;
    }
    self.fourthView.frame=CGRectMake(0, 0, 320,height);
}

-(instancetype)initWithMainBuildWithDelegate:(id<ShowPageDelegate>)delegate part:(NSInteger)part{
    self=[super init];
    if (self) {
        self.part=part;
        self.delegate=delegate;
        //地平阶段
        [self getFirstView];
        //桩基基坑
        [self getSecondView];
        //主体施工
        [self getThirdView];
        //消防/景观绿化
        [self getFourthView];
        
        NSArray* tempAry=@[self.firstView,self.secondView,self.thirdView,self.fourthView];
        CGFloat height=0;
        for (int i=0; i<tempAry.count; i++) {
            CGRect frame=[tempAry[i] frame];
            frame.origin.y=height;
            [tempAry[i] setFrame:frame];
            [self addSubview:tempAry[i]];
            height+=[tempAry[i] frame].size.height;
        }
        self.frame=CGRectMake(0, 0, 320, height);
    }
    return self;
}

+(MainBuild*)getMainBuildWithDelegate:(id<ShowPageDelegate>)delegate part:(NSInteger)part{
    return [[MainBuild alloc]initWithMainBuildWithDelegate:delegate part:part];
}
@end
