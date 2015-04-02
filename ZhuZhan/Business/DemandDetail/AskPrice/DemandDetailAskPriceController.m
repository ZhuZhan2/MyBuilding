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
}

-(void)leftBtnClicked{
    if([self.delegate respondsToSelector:@selector(backAndLoad)]){
        [self.delegate backAndLoad];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)backView{
    if([self.delegate respondsToSelector:@selector(backAndLoad)]){
        [self.delegate backAndLoad];
    }
    [self.navigationController popViewControllerAnimated:YES];
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
