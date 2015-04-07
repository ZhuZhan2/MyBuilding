//
//  DemandDetailProvidePriceController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/24.
//
//

#import "DemandDetailProvidePriceController.h"
#import "DemandProvidePriceDetailController.h"
#import "DemandProvidePriceChatController.h"
@interface DemandDetailProvidePriceController ()

@end

@implementation DemandDetailProvidePriceController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.askPriceModel.a_requestName;
}

-(void)demandDetailControllerLeftBtnClicked{
    [self.stageChooseView stageLabelClickedWithSequence:1];
}

-(void)leftBtnClicked{
    if([self.delegate respondsToSelector:@selector(backAndLoad)]){
        [self.delegate backAndLoad];
    }
    UIViewController* vc;
    NSInteger index=[self.navigationController.viewControllers indexOfObject:self];
    if (self.isFirstQuote) {
        vc=self.navigationController.viewControllers[index-2];
    }else{
        vc=self.navigationController.viewControllers[index-1];
    }
    [self.navigationController popToViewController:vc animated:YES];
}

-(void)backView{
    [self leftBtnClicked];
}

-(void)rightBtnClicked{
    UIActionSheet* actionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"回复",@"报价",@"关闭", nil];
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

-(RKDemandDetailController *)detailController{
    if (!_detailController) {
        _detailController=[[DemandProvidePriceDetailController alloc]init];
        _detailController.askPriceModel = self.askPriceModel;
        _detailController.quotesModel = self.quotesModel;
        _detailController.superViewController=self;
        _detailController.delegate=self;
    }
    return _detailController;
}

-(RKDemandChatController *)chatController{
    if (!_chatController) {
        _chatController=[[DemandProvidePriceChatController alloc]init];
        _chatController.askPriceModel = self.askPriceModel;
        _chatController.quotesModel = self.quotesModel;
    }
    return _chatController;
}
@end
