//
//  DemandDetailAskPriceController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/24.
//
//

#import "DemandDetailAskPriceController.h"
#import "DemandAskPriceDetailController.h"
#import "DemandAskPriceChatController.h"
@interface DemandDetailAskPriceController ()

@end

@implementation DemandDetailAskPriceController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=self.quotesModel.a_loginName;
}

-(void)leftBtnClicked{
    if([self.delegate respondsToSelector:@selector(backAndLoad)]){
        [self.delegate backAndLoad];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)backView{
    [self leftBtnClicked];
}

-(void)rightBtnClicked{
    UIActionSheet* actionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"回复",@"采纳",@"关闭", nil];
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self.detailController leftBtnClickedWithIndexPath:nil];
            break;
        case 1:
            [self.detailController rightBtnClickedWithIndexPath:nil];
            break;
        case 2:
            [self.detailController closeBtnClicked];
            break;
    }
    [self initNavi];
}

-(void)demandDetailControllerLeftBtnClicked{
    [self.stageChooseView stageLabelClickedWithSequence:1];
}

-(RKDemandDetailController *)detailController{
    if (!_detailController) {
        _detailController=[[DemandAskPriceDetailController alloc]init];
        _detailController.quotesModel = self.quotesModel;
        _detailController.askPriceModel = self.askPriceModel;
        _detailController.delegate=self;
        _detailController.superViewController=self;
    }
    return _detailController;
}

-(RKDemandChatController *)chatController{
    if (!_chatController) {
        _chatController=[[DemandAskPriceChatController alloc]init];
        _chatController.askPriceModel = self.askPriceModel;
        _chatController.quotesModel = self.quotesModel;
    }
    return _chatController;
}
@end
