//
//  DecorationProject.m
//  ZpzchinaMobile
//
//  Created by 孙元侃 on 14-8-25.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "DecorationProject.h"
#import "MyFactory.h"

@interface DecorationProject ()
@property(nonatomic)NSInteger part;
@property(nonatomic,weak)id<ShowPageDelegate>delegate;
@end

@implementation DecorationProject

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
    self.firstView=[[UIView alloc]initWithFrame:CGRectZero];
    
    UIView* view2=[MyFactory getNoLineTitleViewWithTitle:@"装修阶段" titleImage:[GetImagePath getImagePath:@"icon04"]];
    
    //每阶段有图到只有第一个阶段有图的转换代码
//    NSArray* images=[self.delegate getImageViewWithImageAndCountWithIndexPath:[MyIndexPath getIndexPart:self.part section:0]];
//    UIView* view0=[MyFactory getImageViewWithImageUrl:images.count?images[0]:@"No" count:images.count];
//    if (images.count) {
//        view0.tag=0;
//        [MyFactory addButtonToView:view0 target:self action:@selector(chooseImageView:) forControlEvents:UIControlEventTouchUpInside];
//    }
    
    NSArray* secondStrs=[self.delegate getBlackTwoLinesWithStrsWithIndexPath:[MyIndexPath getIndexPart:self.part section:0]];
    UIView* view1=[MyFactory getBlackTwoLinesWithFirstStr:@[@"弱电安装",@"装修情况",@"装修进度"] secondStr:secondStrs];
    
    //每阶段有图到只有第一个阶段有图的转换代码
//    NSArray* tempAry=@[view2,view0,view1];
    NSArray* tempAry=@[view2,view1];

    CGFloat height=0;
    for (int i=0; i<tempAry.count; i++) {
        CGRect frame=[tempAry[i] frame];
        frame.origin.y=height;
        [tempAry[i] setFrame:frame];
        [self.firstView addSubview:tempAry[i]];
        height+=[tempAry[i] frame].size.height;
    }
    
    self.firstView.frame=CGRectMake(0, 0, 320,height);;
}

-(instancetype)initWithDecorationProjectWithDelegate:(id<ShowPageDelegate>)delegate part:(NSInteger)part{
    self=[super init];
    if (self) {
        self.part=part;
        self.delegate=delegate;
        //装修阶段
        [self getFirstView];

        
        NSArray* tempAry=@[self.firstView];
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

+(DecorationProject*)getDecorationProjectWithDelegate:(id<ShowPageDelegate>)delegate part:(NSInteger)part{
    return [[DecorationProject alloc]initWithDecorationProjectWithDelegate:delegate part:part];
}
@end
