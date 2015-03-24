//
//  ProvidePriceInfoController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/20.
//
//

#import "ProvidePriceInfoController.h"
#import "TopView.h"
#import "RKLeftAndRightView.h"
#import "RKUpAndDownView.h"
#import "RKShadowView.h"
#import "ProvidePriceUploadView.h"
#import "RKPointKit.h"
#import "RKCamera.h"
#import "AskPriceApi.h"
@interface ProvidePriceInfoController ()<RKCameraDelegate,ProvidePriceUploadViewDelegate,UIActionSheetDelegate>
@property(nonatomic,strong)UIView* firstView;
@property(nonatomic,strong)UIView* secondView;
@property(nonatomic,strong)UIView* thirdView;
@property(nonatomic,strong)UIView* fourthView;
@property(nonatomic,strong)UIView* fifthView;
@property(nonatomic,strong)ProvidePriceUploadView* sixthView;
@property(nonatomic,strong)NSArray* contentViews;
@property(nonatomic,strong)RKCamera* cameraControl;

@property(nonatomic,strong)UIView* topView;
@end

@implementation ProvidePriceInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    [self initTopView];
    [self initTableView];
    [self initTableViewExtra];
}

-(void)rightBtnClicked{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:self.askPriceModel.a_tradeCode forKey:@"tradeCode"];
    [dic setObject:self.askPriceModel.a_id forKey:@"bookBuildingId"];
    [dic setObject:@"岳志强fuck" forKey:@"quoteContent"];
    [AskPriceApi AddQuotesWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
        
        }
    } dic:dic noNetWork:nil];
}

-(void)initNavi{
    self.title=@"报价资料";
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
    [self setRightBtnWithText:@"提交"];
}

-(void)initTopView{
    self.topView=[[TopView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 48) firstStr:[NSString stringWithFormat:@"询价%@",self.askPriceModel.a_time] secondStr:[NSString stringWithFormat:@"流水号:%@",self.askPriceModel.a_tradeCode] colorArr:@[[UIColor blackColor],AllLightGrayColor]];
    [self.view addSubview:self.topView];
}

-(void)initTableViewExtra{
    CGRect frame=self.tableView.frame;
    CGFloat extraHeight=CGRectGetHeight(self.topView.frame);
    frame.origin.y+=extraHeight;
    frame.size.height-=extraHeight;
    self.tableView.frame=frame;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.contentViews.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGRectGetHeight([self.contentViews[indexPath.row] frame]);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UIView* view=self.contentViews[indexPath.row];
    CGRect frame=view.frame;
    frame.origin.x=(kScreenWidth-CGRectGetWidth(view.frame))/2;
    view.frame=frame;
    [cell.contentView addSubview:view];
    
    UIView* seperatorLine=[RKShadowView seperatorLineWithHeight:2];
    frame=seperatorLine.frame;
    frame.origin.y=CGRectGetHeight(view.frame)-CGRectGetHeight(seperatorLine.frame)+1;
    seperatorLine.frame=frame;
    [cell.contentView addSubview:seperatorLine];
    
    
    if (view==self.sixthView) {
        [[self.sixthView editCenters] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [(NSArray*)obj enumerateObjectsUsingBlock:^(id subObj, NSUInteger subIdx, BOOL *subStop) {
                CGPoint point=self.sixthView.frame.origin;
                CGPoint subPoint=[subObj CGPointValue];
                CGPoint newPoint=[RKPointKit point:point addSubPoint:subPoint];
                UIButton* cancelBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
                [cancelBtn setBackgroundImage:[GetImagePath getImagePath:@"priceX"] forState:UIControlStateNormal];
                cancelBtn.tag=subIdx;
                cancelBtn.center=newPoint;
                [cell.contentView addSubview:cancelBtn];
                NSString* actionStr;
                switch (idx) {
                    case 0:
                        actionStr=@"firstAccessoryStageCancelBtnClickedWithBtn:";
                        break;
                    case 1:
                        actionStr=@"secondAccessoryStageCancelBtnClickedWithBtn:";
                        break;
                    case 2:
                        actionStr=@"thirdAccessoryStageCancelBtnClickedWithBtn:";
                        break;
                }
                [cancelBtn addTarget:self action:NSSelectorFromString(actionStr) forControlEvents:UIControlEventTouchUpInside];
            }];
        }];
    }
    return cell;
}

-(void)firstAccessoryStageCancelBtnClickedWithBtn:(UIButton*)btn{
    NSLog(@"firstStage,%d",(int)btn.tag);
    [self reloadSixthView];
}

-(void)secondAccessoryStageCancelBtnClickedWithBtn:(UIButton*)btn{
    NSLog(@"secondStage,%d",(int)btn.tag);
    [self reloadSixthView];
}

-(void)thirdAccessoryStageCancelBtnClickedWithBtn:(UIButton*)btn{
    NSLog(@"thirdStage,%d",(int)btn.tag);
    [self reloadSixthView];
}

-(void)reloadSixthView{
    self.sixthView=nil;
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:5 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)upLoadBtnClickedWithNumber:(NSInteger)number{
    UIActionSheet* actionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"手机相册",nil];
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==actionSheet.cancelButtonIndex) return;
    self.cameraControl=[RKCamera cameraWithType:!buttonIndex allowEdit:YES deleate:self presentViewController:self.view.window.rootViewController];
}


-(NSArray *)contentViews{
    return @[self.firstView,self.secondView,self.thirdView,self.fourthView,self.fifthView,self.sixthView];
}

-(UIView *)firstView{
    if (!_firstView) {
        _firstView=[RKLeftAndRightView upAndDownViewWithUpContent:@"求购用户" downContent:self.askPriceModel.a_requestName topDistance:20 bottomDistance:20 maxWidth:kScreenWidth-50];
    }
    return _firstView;
}

-(UIView *)secondView{
    if (!_secondView) {
        _secondView=[RKUpAndDownView upAndDownViewWithUpContent:@"产品大类" downContent:self.askPriceModel.a_productBigCategory topDistance:14 bottomDistance:14 maxWidth:kScreenWidth-50];
    }
    return _secondView;
}

-(UIView *)thirdView{
    if (!_thirdView) {
        _thirdView=[RKUpAndDownView upAndDownViewWithUpContent:@"产品分类" downContent:self.askPriceModel.a_productCategory topDistance:14 bottomDistance:14 maxWidth:kScreenWidth-50];

    }
    return _thirdView;
}

-(UIView *)fourthView{
    if (!_fourthView) {
        _fourthView=[RKUpAndDownView upAndDownViewWithUpContent:@"需求描述" downContent:self.askPriceModel.a_remark topDistance:20 bottomDistance:20 maxWidth:kScreenWidth-50];

    }
    return _fourthView;
}

-(UIView *)fifthView{
    if (!_fifthView) {
        _fifthView=[RKUpAndDownView upAndDownViewWithUpContent:@"回复" downContent:@"水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水泥" topDistance:20 bottomDistance:20 maxWidth:kScreenWidth-50];

    }
    return _fifthView;
}

-(ProvidePriceUploadView *)sixthView{
    if (!_sixthView) {
        NSMutableArray* array1=[NSMutableArray array];
        NSMutableArray* array2=[NSMutableArray array];
        NSMutableArray* array3=[NSMutableArray array];
        for (int i=0; i<arc4random()%30; i++) {
            [array1 addObject:@""];
        }
        for (int i=0; i<arc4random()%30; i++) {
            [array2 addObject:@""];
        }
        for (int i=0; i<arc4random()%30; i++) {
            [array3 addObject:@""];
        }
        _sixthView=[ProvidePriceUploadView uploadViewWithFirstAccessory:array1 secondAccessory:array2 thirdAccessory:array3 maxWidth:kScreenWidth-50 topDistance:20 bottomDistance:20 delegate:self];
    }
    return _sixthView;
}
@end
