//
//  DemandAskPriceChatController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/24.
//
//

#import "DemandAskPriceChatController.h"
#import "AskPriceApi.h"
@interface DemandAskPriceChatController ()
@property(nonatomic,copy)NSString* sendContent;
@end

@implementation DemandAskPriceChatController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadList];
}


-(void)loadList{
    [AskPriceApi GetCommentListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            
        }
    } tradeId:self.askPriceModel.a_id tradeUserAndCommentUser:[NSString stringWithFormat:@"%@:%@",self.askPriceModel.a_createdBy,self.quotesModel.a_loginId] startIndex:0 noNetWork:nil];
}
/**
 *tradeId	string	询价ID	必填	不可为空
 *tradeCode	string	询价code	必填	不可为空
 *tradeUserAndCommentUser	string	询价人ID:报价人ID	必填	不可为空
 *contents
 */
-(void)sendWithContent:(NSString*)content{
    NSString* tradeUserAndCommentUser=[NSString stringWithFormat:@"%@:%@",self.askPriceModel.a_createdBy,self.quotesModel.a_loginId];
    NSMutableDictionary* dic=[@{@"tradeId":self.askPriceModel.a_id,
                                @"tradeCode":self.askPriceModel.a_tradeCode,
                                @"tradeUserAndCommentUser":tradeUserAndCommentUser,
                                @"contents":content} mutableCopy];
    [AskPriceApi AddCommentWithBlock:^(NSMutableArray *posts, NSError *error) {
        
    } dic:dic noNetWork:nil];
}

-(void)chatToolSendBtnClickedWithContent:(NSString *)content{
    [self sendWithContent:content];
}

-(NSMutableArray *)chatModels{
    if (!_chatModels) {
        _chatModels=[NSMutableArray array];
    }
    return _chatModels;
}
@end
