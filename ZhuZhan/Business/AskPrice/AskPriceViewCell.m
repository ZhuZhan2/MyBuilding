//
//  AskPriceViewCell.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/17.
//
//

#import "AskPriceViewCell.h"
#import "RKTwoView.h"
#import "AskPriceCellHeader.h"
#import "RKShadowView.h"
@interface AskPriceViewCell ()
@property(nonatomic,strong)AskPriceCellHeader* cellHeader;
@property(nonatomic,strong)UIView* mainView;
@property(nonatomic,strong)UIView* seperatorLineInCell;
@property(nonatomic,strong)UIView* seperatorLineOutCell;
@end

#define headerHeight 40
#define seperatorHeight 10
#define mainViewTopDistance 9
#define mainViewBottomDistance 9

@implementation AskPriceViewCell
+(CGFloat)carculateTotalHeightWithContents:(NSArray*)contents{
    return headerHeight+seperatorHeight+mainViewTopDistance+mainViewBottomDistance+[RKTwoView carculateTotalHeightWithContents:contents];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
    }
    return self;
}

-(UIView *)seperatorLineOutCell{
    if (!_seperatorLineOutCell) {
        _seperatorLineOutCell=[RKShadowView seperatorLineShadowViewWithHeight:seperatorHeight];
    }
    return _seperatorLineOutCell;
}

-(UIView *)seperatorLineInCell{
    if (!_seperatorLineInCell) {
        _seperatorLineInCell=[RKShadowView seperatorLineWithHeight:2];
    }
    return _seperatorLineInCell;
}

-(AskPriceCellHeader *)cellHeader{
    if (!_cellHeader) {
        AskPriceCellHeaderModel* model=[[AskPriceCellHeaderModel alloc]init];
        model.stage=@"询价进行中";
        model.hasNew=arc4random()%2;
        model.number=@"流水号:321312312";
        _cellHeader=[AskPriceCellHeader askPriceCellHeaderStageMode:arc4random()%4 model:model];
        [_cellHeader addSubview:self.seperatorLineInCell];
    }
    return _cellHeader;
}

-(UIView *)mainView{
    if (!_mainView) {
        _mainView=[[UIView alloc]initWithFrame:CGRectZero];
    }
    return _mainView;
}

-(void)setUpMainView{
    [self.mainView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    RKTwoView* view1=[RKTwoView twoViewWithViewMode:RKTwoViewWidthModeWholeLine assistMode:RKTwoViewAssistViewModeIsLabel leftContent:@"参与用户" rightContent:self.contents[0] needAuto:NO];
    RKTwoView* view2=[RKTwoView twoViewWithViewMode:RKTwoViewWidthModeWholeLine assistMode:RKTwoViewAssistViewModeIsLabel leftContent:@"产品大类" rightContent:self.contents[1] needAuto:NO];
    RKTwoView* view3=[RKTwoView twoViewWithViewMode:RKTwoViewWidthModeWholeLine assistMode:RKTwoViewAssistViewModeIsLabel leftContent:@"产品分类" rightContent:self.contents[2] needAuto:NO];
    RKTwoView* view4=[RKTwoView twoViewWithViewMode:RKTwoViewWidthModeWholeLine assistMode:RKTwoViewAssistViewModeIsLabel leftContent:@"需求描述" rightContent:self.contents[3] needAuto:YES];
    
    CGRect frame=view1.frame;
    frame.origin.y+=mainViewTopDistance;
    view1.frame=frame;
    [self.mainView addSubview:view1];
    
    frame=view2.frame;
    frame.origin.y=CGRectGetMaxY(view1.frame);
    view2.frame=frame;
    [self.mainView addSubview:view2];
    
    frame=view3.frame;
    frame.origin.y=CGRectGetMaxY(view2.frame);
    view3.frame=frame;
    [self.mainView addSubview:view3];
    
    frame=view4.frame;
    frame.origin.y=CGRectGetMaxY(view3.frame);
    view4.frame=frame;
    [self.mainView addSubview:view4];
}

-(void)setContents:(NSArray *)contents{
    _contents=contents;
    [self setUpMainView];
    [self reloadAllFrames];
}

-(void)reloadAllFrames{
    self.cellHeader.frame=CGRectMake(0, 0, kScreenWidth, headerHeight);
    self.seperatorLineInCell.frame=CGRectMake(0, CGRectGetMaxY(self.cellHeader.frame)-CGRectGetHeight(self.seperatorLineInCell.frame), kScreenWidth, CGRectGetHeight(self.seperatorLineInCell.frame));
    
    CGFloat height=[RKTwoView carculateTotalHeightWithContents:self.contents]+mainViewTopDistance+mainViewBottomDistance;
    self.mainView.frame=CGRectMake(0, CGRectGetMaxY(self.cellHeader.frame), kScreenWidth, height);
    //self.mainView.clipsToBounds=YES;
    self.seperatorLineOutCell.frame=CGRectMake(0, CGRectGetMaxY(self.mainView.frame), kScreenWidth, seperatorHeight);
}

-(void)setUp{
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.cellHeader];
    [self.cellHeader addSubview:self.seperatorLineInCell];
    [self.contentView addSubview:self.mainView];
    [self.contentView addSubview:self.seperatorLineOutCell];
}


@end
