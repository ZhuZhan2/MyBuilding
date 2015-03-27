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

@end

@implementation DemandAskPriceChatController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadList];
}


-(void)loadList{
    NSLog(@"loadList");
    [AskPriceApi GetCommentListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            
        }
    } tradeId:self.askPriceModel.a_id tradeUserAndCommentUser:[NSString stringWithFormat:@"%@:%@",self.askPriceModel.a_createdBy,self.quotesModel.a_loginId] startIndex:0 noNetWork:nil];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [DemandChatViewCell carculateTotalHeightWithModel:self.chatModels[indexPath.row]];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DemandChatViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"chatCell"];
    if (!cell) {
        cell=[[DemandChatViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"chatCell"];
    }
    DemandChatViewCellModel* model=self.chatModels[indexPath.row];
    cell.model=model;
    return cell;
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
