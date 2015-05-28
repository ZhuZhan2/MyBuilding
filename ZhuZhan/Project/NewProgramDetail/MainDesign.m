//
//  MainDesign.m
//  ZpzchinaMobile
//
//  Created by 孙元侃 on 14-8-25.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "MainDesign.h"
#import "MyFactory.h"

@interface MainDesign ()
@property(nonatomic)NSInteger part;
@property(nonatomic,weak)id<ShowPageDelegate>delegate;
@end

@implementation MainDesign

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
    //地勘阶段
    self.firstView=[[UIView alloc]initWithFrame:CGRectZero];
    
    UIView* view2=[MyFactory getNoLineTitleViewWithTitle:@"地勘阶段" titleImage:[GetImagePath getImagePath:@"icon02"]];
    
    NSArray* images=[self.delegate getImageViewWithImageAndCountWithIndexPath:[MyIndexPath getIndexPart:self.part section:0]];
    UIView* view0=[MyFactory getImageViewWithImageUrl:images.count?images[0]:@"No" count:images.count];
    if (images.count) {
        view0.tag=0;
        [MyFactory addButtonToView:view0 target:self action:@selector(chooseImageView:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    NSMutableArray* fiveStrs=[self.delegate getThreeContactsViewThreeTypesFiveStrsWithIndexPath:[MyIndexPath getIndexPart:self.part section:0]];
    
    UIView* view1=[MyFactory getThreeContactsViewThreeTypesFiveStrs:fiveStrs withContactCategory:@"地勘企业："];
    
    NSArray* tempAry=@[view2,view0,view1];
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
    //主体设计阶段
    self.secondView=[[UIView alloc]initWithFrame:CGRectZero];
    
    //NSArray* secondStrs=[self.delegate getBlackTwoLinesWithStrsWithIndexPath:[MyIndexPath getIndexPart:self.part section:1]];
    NSArray* secondStrs=[self.delegate getTwoLinesTitleViewFirstStrsAndSecondStrsWithIndexPath:[MyIndexPath getIndexPart:self.part section:1]];
    UIView* view0=[MyFactory getTwoLinesTitleViewWithTitle:@"设计阶段" titleImage:[GetImagePath getImagePath:@"icon02"] firstStrs:@[@"主体设计阶段"] secondStrs:secondStrs];
    
    NSMutableArray* fiveStrs=[self.delegate getThreeContactsViewThreeTypesFiveStrsWithIndexPath:[MyIndexPath getIndexPart:self.part section:1]];
    UIView* view1=[MyFactory getThreeContactsViewThreeTypesFiveStrs:fiveStrs withContactCategory:@"设计院："];
    
    
    NSArray* tempAry=@[view0,view1];
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
    //出图阶段
    self.thirdView=[[UIView alloc]initWithFrame:CGRectZero];
    
    NSArray* secondStrs=[self.delegate getTwoLinesTitleViewFirstStrsAndSecondStrsWithIndexPath:[MyIndexPath getIndexPart:self.part section:2]];
    UIView* view0=[MyFactory getTwoLinesTitleViewWithTitle:@"出图阶段" titleImage:[GetImagePath getImagePath:@"icon02"] firstStrs:@[@"预计施工时间",@"预计竣工时间"] secondStrs:secondStrs];
    
    NSMutableArray* fiveStrs=[self.delegate getThreeContactsViewThreeTypesFiveStrsWithIndexPath:[MyIndexPath getIndexPart:self.part section:2]];
    UIView* view1=[MyFactory getThreeContactsViewThreeTypesFiveStrs:fiveStrs withContactCategory:@"业主单位："];
    
    NSArray* boolStrs=[self.delegate getDeviceAndBoolWithDevicesAndBoolStrsWithIndexPath:[MyIndexPath getIndexPart:self.part section:2]];
    UIView* view2=[MyFactory getDeviceAndBoolWithDevic:@[@"电梯",@"空调",@"供暖方式",@"外墙材料",@"钢结构"] boolStrs:boolStrs hideFirstSeparatorLine:!fiveStrs.count];
    
    NSArray* tempAry=@[view0,view1,view2];
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

-(instancetype)initWithMainDesignWithDelegate:(id<ShowPageDelegate>)delegate part:(NSInteger)part{
    self=[super init];
    if (self) {
        self.part=part;
        self.delegate=delegate;
        //地勘阶段
        [self getFirstView];
        //主体设计阶段
        [self getSecondView];
        //出图阶段
        [self getThirdView];
        
        NSArray* tempAry=@[self.firstView,self.secondView,self.thirdView];
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

+(MainDesign *)getMainDesignWithDelegate:(id<ShowPageDelegate>)delegate part:(NSInteger)part{
    return [[MainDesign alloc]initWithMainDesignWithDelegate:delegate part:part];
}
@end
