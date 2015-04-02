//
//  RKDemandDetailController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/19.
//
//

#import "RKDemandDetailController.h"
#import "RKImageModel.h"

@interface RKDemandDetailController ()
@property (nonatomic, strong)UIButton* closeBtn;
@end

@implementation RKDemandDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    [self reloadTableViewExtra];
    NSLog(@"detailModels ===>%@",self.detailModels);
}

-(void)initTableView{
    CGFloat y=64+46;
    CGFloat height=kScreenHeight-y;
    self.tableView=[[RKBaseTableView alloc]initWithFrame:CGRectMake(0, y, kScreenWidth, height) style:UITableViewStylePlain];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
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
    
    self.closeBtn=[[UIButton alloc]initWithFrame:CGRectMake(btnX, btnY, btnWidth, btnHeight)];
    [self.closeBtn addTarget:self action:@selector(closeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.closeBtn];
    
    self.closeBtn.userInteractionEnabled=!self.isFinish;
    [self.closeBtn setBackgroundImage:[GetImagePath getImagePath:self.isFinish?@"关--闭灰":@"关--闭"] forState:UIControlStateNormal];
    
    
    self.tableView.tableFooterView=view;
}

-(BOOL)isFinish{
    return ![self.quotesModel.a_status isEqualToString:@"进行中"];
}

-(void)closeBtnClicked{
    NSLog(@"closeBtnClicked");
}

-(void)viewWillDisappear:(BOOL)animated{
    
}

-(void)viewWillAppear:(BOOL)animated{
    
}

-(DemandDetailCellModel*)cellModelWithDataModel:(QuotesDetailModel*)dataModel{
    DemandDetailCellModel* cellModel=[[DemandDetailCellModel alloc]init];
    
    cellModel.userName=dataModel.a_quoteUser;
    cellModel.userDescribe=dataModel.a_quoteIsVerified;
    cellModel.time=dataModel.a_createdTime;
    //cellModel.numberDescribe=[NSString stringWithFormat:@"第%@次报价",dataModel.a_quoteTimes];
    cellModel.numberDescribe = dataModel.a_quoteTimes;
    cellModel.content=dataModel.a_quoteContent;
    NSMutableArray *array1 = [[NSMutableArray alloc] init];
    [dataModel.a_quoteAttachmentsArr enumerateObjectsUsingBlock:^(ImagesModel *model, NSUInteger idx, BOOL *stop) {
        RKImageModel *imageModel = [[RKImageModel alloc] init];
        imageModel.imageUrl =  model.a_location;
        imageModel.isUrl = model.a_isUrl;
        [array1 addObject:imageModel];
    }];
    NSMutableArray *array2 = [[NSMutableArray alloc] init];
    [dataModel.a_qualificationsAttachmentsArr enumerateObjectsUsingBlock:^(ImagesModel *model, NSUInteger idx, BOOL *stop) {
        RKImageModel *imageModel = [[RKImageModel alloc] init];
        imageModel.imageUrl =  model.a_location;
        imageModel.isUrl = model.a_isUrl;
        [array2 addObject:imageModel];
    }];
    NSMutableArray *array3 = [[NSMutableArray alloc] init];
    [dataModel.a_otherAttachmentsArr enumerateObjectsUsingBlock:^(ImagesModel *model, NSUInteger idx, BOOL *stop) {
        RKImageModel *imageModel = [[RKImageModel alloc] init];
        imageModel.imageUrl =  model.a_location;
        imageModel.isUrl = model.a_isUrl;
        [array3 addObject:imageModel];
    }];
    cellModel.array1=array1;
    cellModel.array2=array2;
    cellModel.array3=array3;
    return cellModel;
}
@end
