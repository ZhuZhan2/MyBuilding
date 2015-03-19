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
#import "RKViewController.h"
typedef enum IsShowingStyle{
    IsShowingDetail,
    IsShowingChat
}IsShowingStyle;

@interface DemanDetailViewController ()<DemandDetailViewCellDelegate>
@property(nonatomic,strong)NSMutableArray* detailModels;
@property(nonatomic,strong)NSMutableArray* chatModels;
@property(nonatomic)IsShowingStyle isShowingStyle;

@property(nonatomic,strong)RKViewController* leftViewController;
@property(nonatomic,strong)RKViewController* rightViewController;
@end

@implementation DemanDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    [self initStageChooseViewWithStages:@[@"报价",@"对话"]];
    [self initTableView];
    [self initChatToolBar];
    [self reloadTableViewExtra];
}

-(void)reloadTableViewExtra{
    self.tableView.backgroundColor=AllBackDeepGrayColor;
    CGFloat tableFooterSpaceHeight=24;
    CGFloat shadowHeight=10;
    CGFloat btnHeight=37;
    CGFloat btnWidth=294;
    CGFloat btnX=(kScreenWidth-btnWidth)/2;
    CGFloat btnY=tableFooterSpaceHeight-shadowHeight;
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, tableFooterSpaceHeight*2-shadowHeight+btnHeight)];
    view.backgroundColor=AllBackDeepGrayColor;
    
    UIButton* btn=[[UIButton alloc]initWithFrame:CGRectMake(btnX, btnY, btnWidth, btnHeight)];
    [btn setBackgroundImage:[GetImagePath getImagePath:@"关--闭"] forState:UIControlStateNormal];
    [view addSubview:btn];
    
    self.tableView.tableFooterView=view;
}

-(NSMutableArray *)detailModels{
    if (!_detailModels) {
        _detailModels=[NSMutableArray array];
        for (int i=0; i<8; i++) {
            DemandDetailCellModel* model=[[DemandDetailCellModel alloc]init];
            model.userName=@"用户名啊用户名啊用户名啊";
            model.userDescribe=@"用户描述啊用户描述啊用户描述啊用";
            model.time=@"2015-01-23 11:47";
            model.numberDescribe=@"第N次报价";
            model.content=@"内容啊内容，内容啊内容，这遥遥无期的代码，写到何处方到尽头啊啊啊啊啊啊啊啊啊啊!内容啊内容，内容啊内容，这遥遥无期的代码，写到何处方到尽头啊啊啊啊啊啊啊啊啊啊!内容啊内容，内容啊内容，这遥遥无期的代码，写到何处方到尽头啊啊啊啊啊啊啊啊啊啊!内容啊内容，内容啊内容，这遥遥无期的代码，写到何处方到尽头啊啊啊啊啊啊啊啊啊啊!";
            model.array1=@[@"",@""];
            model.array2=@[@"",@"",@"",@"",@"",@"",@"",@"",@"",@""];
            model.array3=@[];
            
            [_detailModels addObject:model];
        }
    }
    return _detailModels;
}

-(NSMutableArray *)chatModels{
    if (!_chatModels) {
        _chatModels=[NSMutableArray array];
        for (int i=0; i<8; i++) {
            DemandDetailCellModel* model=[[DemandDetailCellModel alloc]init];
            model.userName=@"用户名啊用户名啊用户名啊";
            model.userDescribe=@"用户描述啊用户描述啊用户描述啊用";
            model.time=@"2015-01-23 11:47";
            model.numberDescribe=@"第N次报价";
            model.content=@"内容啊内容，内容啊内容，这遥遥无期的代码，写到何处方到尽头啊啊啊啊啊啊啊啊啊啊!内容啊内容，内容啊内容，这遥遥无期的代码，写到何处方到尽头啊啊啊啊啊啊啊啊啊啊!内容啊内容，内容啊内容，这遥遥无期的代码，写到何处方到尽头啊啊啊啊啊啊啊啊啊啊!内容啊内容，内容啊内容，这遥遥无期的代码，写到何处方到尽头啊啊啊啊啊啊啊啊啊啊!";
            model.array1=@[@"",@""];
            model.array2=@[@"",@"",@"",@"",@"",@"",@"",@"",@"",@""];
            model.array3=@[];
            
            [_chatModels addObject:model];
        }
    }
    return _chatModels;
}

-(void)initNavi{
    self.title=@"买家的用户名，懂？";
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.isShowingStyle?self.chatModels:self.detailModels count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.isShowingStyle?[DemandChatViewCell carculateTotalHeightWithModel:self.chatModels[indexPath.row ]]:[DemandDetailViewCell carculateTotalHeightWithModel:self.detailModels[indexPath.row]];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isShowingStyle==IsShowingDetail) {
        DemandDetailViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"detailCell"];
        if (!cell) {
            cell=[[DemandDetailViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"detailCell" delegate:self];
        }
        DemandDetailCellModel* model=self.detailModels[indexPath.row];
        model.indexPath=indexPath;
        cell.model=model;
        return cell;
    }else{
        DemandChatViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"chatCell"];
        if (!cell) {
            cell=[[DemandChatViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"chatCell"];
        }
        DemandChatViewCellModel* model=self.chatModels[indexPath.row];
        cell.model=model;
        return cell;
    }
}

-(void)leftBtnClickedWithIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"leftBtnClicked,indexPath==%d",(int)indexPath.row);
}

-(void)rightBtnClickedWithIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"rightBtnClicked,indexPath==%d",(int)indexPath.row);
}

-(void)stageBtnClickedWithNumber:(NSInteger)stageNumber{
    self.isShowingStyle=stageNumber?IsShowingChat:IsShowingDetail;
    [self.tableView reloadData];
    self.tableView.contentOffset=CGPointMake(0, 0);
}
@end
