//
//  DemanDetailViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/18.
//
//

#import "DemanDetailViewController.h"
#import "DemandDetailViewCell.h"
#import "DemandChatViewCell.h"


@interface DemanDetailViewController ()

@property(nonatomic,strong)RKDemandDetailController* detailController;
@property(nonatomic,strong)RKDemandChatController* chatController;

@property(nonatomic,strong)UIView* contentView;
@end

@implementation DemanDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    [self initStageChooseViewWithStages:@[@"报价",@"对话"] numbers:nil];
    [self.view insertSubview:self.contentView belowSubview:self.stageChooseView];
}

-(void)stageBtnClickedWithNumber:(NSInteger)stageNumber{
    UIView* lastView=stageNumber?self.detailController.view:self.chatController.view;
    [lastView endEditing:YES];
    lastView.hidden=YES;
    
    UIView* newView=stageNumber?self.chatController.view:self.detailController.view;
    newView.hidden=NO;
    [self.contentView addSubview:newView];
}

-(UIView *)contentView{
    if (!_contentView) {
        CGFloat y=CGRectGetMaxY(self.stageChooseView.frame);
        CGFloat height=kScreenHeight-y;
        _contentView=[[UIView alloc]initWithFrame:CGRectMake(0, y, kScreenWidth, height)];
    }
    return _contentView;
}

-(void)initNavi{
    self.title=self.titleStr;
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
}
@end
