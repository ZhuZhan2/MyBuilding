//
//  LandInfo.m
//  ZpzchinaMobile
//
//  Created by 孙元侃 on 14-8-21.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "LandInfo.h"
#import "MyFactory.h"
@interface LandInfo ()
@property(nonatomic)NSInteger part;
@property(nonatomic,weak)id<ShowPageDelegate>delegate;
@end

@implementation LandInfo

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)chooseImageView:(UIButton*)button{
    [self.delegate chooseImageViewWithIndexPath:[MyIndexPath getIndexPart:self.part section:0]];
}

-(void)getFirstView{
    //土地规划/拍卖
    self.firstView=[[UIView alloc]initWithFrame:CGRectZero];
    
    NSArray* dataThreeStrs=[self.delegate getThreeLinesTitleViewWithThreeStrsWithIndexPath:[MyIndexPath getIndexPart:self.part section:0]];
    UIView* view0=[MyFactory getThreeLinesTitleViewWithTitle:@"土地规划/拍卖" titleImage:[UIImage imageNamed:@"XiangMuXiangQing/map_01.png"] dataThreeStrs:dataThreeStrs];
    
    NSArray* images=[self.delegate getImageViewWithImageAndCountWithIndexPath:[MyIndexPath getIndexPart:self.part section:0]];
    UIView* view1=[MyFactory getImageViewWithImageUrl:images.count?images[0]:@"No" count:images.count];
    if (images.count) {
        view1.tag=0;
        [MyFactory addButtonToView:view1 target:self action:@selector(chooseImageView:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    NSArray* secondStrs=[self.delegate getBlueTwoLinesWithStrsWithIndexPath:[MyIndexPath getIndexPart:self.part section:0]];
    UIView* view2=[MyFactory getBlueThreeTypesTwoLinesWithFirstStr:@[@"土地面积",@"土地容积率",@"地块用途"] secondStr:secondStrs];
    
    NSArray* fiveStrs=[self.delegate getThreeContactsViewThreeTypesFiveStrsWithIndexPath:[MyIndexPath getIndexPart:self.part section:0]];
    UIView* view3=[MyFactory getThreeContactsViewThreeTypesFiveStrs:fiveStrs];
    [view3 addSubview:[MyFactory getSeperatedLine]];
    
    NSArray* tempAry=@[view0,view1,view2,view3];
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
    //项目立项
    self.secondView=[[UIView alloc]initWithFrame:CGRectZero];
    
    NSArray* threeStrs=[self.delegate getThreeLinesTitleViewWithThreeStrsWithIndexPath:[MyIndexPath getIndexPart:self.part section:1]];
    UIView* view0=[MyFactory getThreeLinesTitleViewWithTitle:@"项目立项" titleImage:[UIImage imageNamed:@"XiangMuXiangQing/map_01.png"] dataThreeStrs:threeStrs];
    
    NSArray* sixStrs=[self.delegate getBlueTwoLinesWithStrsWithIndexPath:[MyIndexPath getIndexPart:self.part section:1]];
    UIView* view1=[MyFactory getBlueTwoLinesWithFirstStr:@[@"预计开工时间",@"建筑层高",@"外资参与",@"预计竣工时间",@"投资额",@"建筑面积"] secondStr:sixStrs];
    
    NSArray* fiveStrs=[self.delegate getThreeContactsViewThreeTypesFiveStrsWithIndexPath:[MyIndexPath getIndexPart:self.part section:1]];
    UIView* view2=[MyFactory getThreeContactsViewThreeTypesFiveStrs:fiveStrs];
    [view2 addSubview:[MyFactory getSeperatedLine]];
    
    UIView* view3=[MyFactory getOwnerTypeViewWithImage:[UIImage imageNamed:@"XiangMuXiangQing/logo@2x.png"] owners:[self.delegate getOwnerTypeViewWithImageAndOwnersWithIndexPath:[MyIndexPath getIndexPart:self.part section:1]]];
    
    NSArray* tempAry=@[view0,view1,view2,view3];
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

-(instancetype)initWithLandInfoWithDelegate:(id<ShowPageDelegate>)delegate part:(NSInteger)part{
    self=[super init];
    if (self) {
        self.part=part;
        self.delegate=delegate;
        //土地规划/拍卖
        [self getFirstView];
        //项目立项
        [self getSecondView];
        
        NSArray* tempAry=@[self.firstView,self.secondView];
        CGFloat height=0;
        for (int i=0; i<tempAry.count; i++) {
            //CGRect frame=[tempAry[i] frame];
            //frame.origin.y=height;
            //[tempAry[i] setFrame:frame];
            [self addSubview:tempAry[i]];
            height+=[tempAry[i] frame].size.height;
        }
        self.frame=CGRectMake(0, 0, 320, height);
    }
    return self;
}

+(LandInfo*)getLandInfoWithDelegate:(id<ShowPageDelegate>)delegate part:(NSInteger)part{
    return [[LandInfo alloc]initWithLandInfoWithDelegate:delegate part:part];
}
@end
