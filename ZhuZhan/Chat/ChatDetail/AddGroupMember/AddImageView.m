//
//  AddImageView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/11.
//
//

#import "AddImageView.h"
#import "ImageAndLabelView.h"
#define kSideDistance 20
#define kLineSpace 15
@interface AddImageView()<ImageAndLabelViewDelegate>
@property(nonatomic,strong)NSArray* models;
@end

@implementation AddImageView
+(AddImageView *)addImageViewWithModels:(NSArray *)models{
    AddImageView* view=[[AddImageView alloc]initWithFrame:CGRectZero];
    view.models=models;
    [view setUp];
    
    return view;
}

-(void)setUp{
    CGFloat height=[self addContent];
    self.frame=CGRectMake(0, 0, kScreenWidth, height+2*kSideDistance);
}

-(CGFloat)addContent{
    UIView* backView=[[UIView alloc]initWithFrame:CGRectZero];
    NSInteger oneLineCount=4;
    CGFloat height=0;
    NSMutableArray* array=[NSMutableArray array];
    for (int i=0; i<self.models.count; i++) {
        AddImageViewModel* model=self.models[i];
        ImageAndLabelView* view=[ImageAndLabelView imageAndLabelViewWithImageUrl:model.imageUrl content:model.name isAddImage:NO delegate:nil];
        [array addObject:view];
    }
//    ImageAndLabelView* view=[ImageAndLabelView imageAndLabelViewWithImageUrl:@"" content:@"" isAddImage:YES delegate:self];
//    [array addObject:view];
    
    for (int i=0; i<array.count; i++){
        UIView* view=array[i];
        CGFloat viewWidth=CGRectGetWidth(view.frame);
        CGFloat viewHeight=CGRectGetHeight(view.frame);
        CGFloat space=(kScreenWidth-2*kSideDistance-oneLineCount*viewWidth)/(oneLineCount-1);
        view.center=CGPointMake(viewWidth*0.5+i%oneLineCount*(viewWidth+space), viewHeight*0.5+i/oneLineCount*(viewHeight+kLineSpace));
        height=view.center.y+viewHeight*0.5;
        [backView addSubview:view];
    }
    backView.frame=CGRectMake(kSideDistance, kSideDistance, kScreenWidth-2*kSideDistance, height);
    
    [self addSubview:backView];
    return CGRectGetHeight(backView.frame);
}

-(void)addImageBtnClicked{
    if ([self.delegate respondsToSelector:@selector(addImageBtnClicked)]) {
        [self.delegate addImageBtnClicked];
    }
}
@end

@implementation AddImageViewModel
@end
