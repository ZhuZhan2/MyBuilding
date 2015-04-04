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
#import "RKImageModel.h"
#import "DemandDetailProvidePriceController.h"
@interface ProvidePriceInfoController ()<RKCameraDelegate,ProvidePriceUploadViewDelegate,UIActionSheetDelegate,UIAlertViewDelegate,DemandDetailProvidePriceDelegate>
@property(nonatomic,strong)UIView* firstView;
@property(nonatomic,strong)UIView* secondView;
@property(nonatomic,strong)UIView* thirdView;
@property(nonatomic,strong)UIView* fourthView;
@property(nonatomic,strong)RKUpAndDownView* fifthView;
@property(nonatomic,strong)ProvidePriceUploadView* sixthView;
@property(nonatomic,strong)NSArray* contentViews;
@property(nonatomic,strong)RKCamera* cameraControl;

@property(nonatomic,strong)NSMutableArray* array1;
@property(nonatomic,strong)NSMutableArray* array2;
@property(nonatomic,strong)NSMutableArray* array3;

@property(nonatomic,strong)UIView* topView;
@property(nonatomic)NSInteger cameraCategory;

@property(nonatomic)NSInteger needPostGroupCount;
@property(nonatomic)NSInteger finishPostGroupCount;
@end

@implementation ProvidePriceInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    [self initTopView];
    [self initTableView];
    [self initTableViewExtra];
    [self addKeybordNotification];
}

-(void)rightBtnClicked{
    if(self.array1.count==0&&self.array2.count==0&&self.array3.count ==0){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"请先上传附件" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    if([self isContainsEmoji:[self.fifthView textViewText]]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@" 备注中不能含有表情" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    [self firstPost];
}

-(void)firstPost{
    self.rightBtn.userInteractionEnabled=NO;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:self.askPriceModel.a_tradeCode forKey:@"tradeCode"];
    [dic setObject:self.askPriceModel.a_id forKey:@"bookBuildingId"];
    [dic setObject:[self.fifthView textViewText] forKey:@"quoteContent"];
    [AskPriceApi AddQuotesWithBlock:^(NSMutableArray *posts, NSError *error) {
        self.rightBtn.userInteractionEnabled=YES;
        //
        if(!error){
            NSString* quotesId=posts[0];
            [self secondPostFirstStepWithQuotesId:quotesId];
        }
    } dic:dic noNetWork:nil];
}

-(void)secondPostFirstStepWithQuotesId:(NSString*)quotesId{
    NSArray* allImages=@[self.array1,self.array2,self.array3];
    
    for (int i=0; i<allImages.count; i++) {
        NSArray* images=allImages[i];
        if (!images.count) continue;
        self.needPostGroupCount++;
        NSMutableArray* newImageDatas=[NSMutableArray array];
        for (RKImageModel* imageModel in images) {
            NSData* imageData=UIImageJPEGRepresentation(imageModel.image, 0.5);
            [newImageDatas addObject:imageData];
        }
        [self secondPostSecondStepWithImages:newImageDatas category:[NSString stringWithFormat:@"%d",i] quotesId:quotesId];
    }
}

-(void)sucessPost{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"报价成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (self.isFirstQuote) {
        DemandDetailProvidePriceController *view = [[DemandDetailProvidePriceController alloc] init];
        view.askPriceModel = self.askPriceModel;
        view.quotesModel = self.quotesModel;
        view.delegate = self;
        view.isFirstQuote=self.isFirstQuote;//YES
        [self.navigationController pushViewController:view animated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)backAndLoad{
    if ([self.delegate respondsToSelector:@selector(backAndLoad)]) {
        [self.delegate backAndLoad];
    }
}

-(void)secondPostSecondStepWithImages:(NSMutableArray*)images category:(NSString*)category quotesId:(NSString*)quotesId{
    NSMutableDictionary* dic=[@{@"category":category,
                                @"tradeCode":self.askPriceModel.a_tradeCode,
                                @"quotesId":quotesId}
                              mutableCopy];
    [AskPriceApi AddAttachmentWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            self.finishPostGroupCount++;
            if (self.finishPostGroupCount==self.needPostGroupCount) {
                [self sucessPost];
            }
        }
    } dataArr:images dic:dic noNetWork:nil];
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
        cell.clipsToBounds=YES;
    }
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UIView* view=self.contentViews[indexPath.row];
    CGRect frame=view.frame;
    frame.origin.x=(kScreenWidth-CGRectGetWidth(view.frame))/2;
    view.frame=frame;
    [cell.contentView addSubview:view];
    
    UIView* seperatorLine=[RKShadowView seperatorLine];
    frame=seperatorLine.frame;
    frame.origin.y=CGRectGetHeight(view.frame)-CGRectGetHeight(seperatorLine.frame);
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
    [self imageDeleteWithIndexpath:[NSIndexPath indexPathForRow:btn.tag inSection:0]];
}

-(void)secondAccessoryStageCancelBtnClickedWithBtn:(UIButton*)btn{
    [self imageDeleteWithIndexpath:[NSIndexPath indexPathForRow:btn.tag inSection:1]];
}

-(void)thirdAccessoryStageCancelBtnClickedWithBtn:(UIButton*)btn{
    [self imageDeleteWithIndexpath:[NSIndexPath indexPathForRow:btn.tag inSection:2]];
}

-(void)imageDeleteWithIndexpath:(NSIndexPath*)indexpath{
    NSArray* images=@[self.array1,self.array2,self.array3];
    
    NSMutableArray* array=images[indexpath.section];
    [array removeObjectAtIndex:indexpath.row];
    [self reloadSixthView];
}

-(void)reloadSixthView{
    self.sixthView=nil;
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:5 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)upLoadBtnClickedWithNumber:(NSInteger)number{
    NSArray* images=@[self.array1,self.array2,self.array3];
    NSMutableArray* array=images[number];
    if (array.count>=9) {
        NSArray* categorys=@[@"报价附件",@"资质附件",@"其他附件"];
        NSString* message=[NSString stringWithFormat:@"%@图片数量已达上限",categorys[number]];
        [[[UIAlertView alloc]initWithTitle:@"提醒" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil]show];
        return;
    }
    
    self.cameraCategory=number;
    UIActionSheet* actionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"手机相册",nil];
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==actionSheet.cancelButtonIndex) return;
    self.cameraControl=[RKCamera cameraWithType:!buttonIndex allowEdit:NO deleate:self presentViewController:self.view.window.rootViewController];
}

-(void)cameraWillFinishWithImage:(UIImage *)image isCancel:(BOOL)isCancel{
    NSData *data = UIImageJPEGRepresentation(image, 1);
    if((double)data.length/(1024*1024)>5){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"图片大于5M" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    if (isCancel) return;
    NSArray* images=@[self.array1,self.array2,self.array3];
    NSMutableArray* array=images[self.cameraCategory];
    RKImageModel* imageModel=[RKImageModel imageModelWithImage:image imageUrl:nil isUrl:NO type:nil];
    [array addObject:imageModel];
    [self reloadSixthView];
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
        _fourthView=[RKUpAndDownView upAndDownViewWithUpContent:@"询价说明" downContent:self.askPriceModel.a_remark topDistance:20 bottomDistance:20 maxWidth:kScreenWidth-50];
        
    }
    return _fourthView;
}

-(RKUpAndDownView *)fifthView{
    if (!_fifthView) {
        _fifthView=[RKUpAndDownView upAndDownTextViewWithUpContent:@"备注" topDistance:20 bottomDistance:20 maxWidth:kScreenWidth-50];
        
    }
    return _fifthView;
}

-(ProvidePriceUploadView *)sixthView{
    if (!_sixthView) {
        _sixthView=[ProvidePriceUploadView uploadViewWithFirstAccessory:self.array1 secondAccessory:self.array2 thirdAccessory:self.array3 maxWidth:kScreenWidth-50 topDistance:20 bottomDistance:20 delegate:self];
    }
    return _sixthView;
}

-(NSMutableArray *)array1{
    if (!_array1) {
        _array1=[NSMutableArray array];
    }
    return _array1;
}

-(NSMutableArray *)array2{
    if (!_array2) {
        _array2=[NSMutableArray array];
    }
    return _array2;
}

-(NSMutableArray *)array3{
    if (!_array3) {
        _array3=[NSMutableArray array];
    }
    return _array3;
}

//判断是否是表情
- (BOOL)isContainsEmoji:(NSString *)string {
    NSLog(@"%@",string);
    __block BOOL isEomji = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    isEomji = YES;
                }
            }
        } else {
            // non surrogate
            if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                isEomji = YES;
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                isEomji = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                isEomji = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                isEomji = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                isEomji = YES;
            }
            if (!isEomji && substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                if (ls == 0x20e3) {
                    isEomji = YES;
                }
            }
        }
    }];
    return isEomji;
}
@end
