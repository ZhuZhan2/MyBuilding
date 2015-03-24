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
#import "RKDemandDetailController.h"
#import "RKDemandChatController.h"

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
    [self.contentView addSubview:stageNumber?self.chatController.view:self.detailController.view];
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
    self.title=@"买家的用户名，懂？";
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
}

-(RKDemandDetailController *)detailController{
    if (!_detailController) {
        _detailController=[[RKDemandDetailController alloc]init];
        _detailController.superViewController=self;
    }
    return _detailController;
}

-(RKDemandChatController *)chatController{
    if (!_chatController) {
        _chatController=[[RKDemandChatController alloc]init];
    }
    return _chatController;
}
@end
