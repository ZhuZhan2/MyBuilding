//
//  BaseContractsView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/30.
//
//

#import "BaseContractsView.h"

@interface BaseContractsView ()
@property (nonatomic, strong)UIButton* PDFBtn;
@property (nonatomic, copy)NSString* PDFImageName;

@property (nonatomic, strong)NSMutableArray* btns;
@property (nonatomic, strong)NSArray* btnImageNames;

@property (nonatomic, weak)id<ContractsViewDelegate> delegate;
@end

@implementation BaseContractsView
+(BaseContractsView*)contractsViewWithPDFImageName:(NSString*)PDFImageName btnImageNmaes:(NSArray*)imageNames delegate:(id<ContractsViewDelegate>)delegate size:(CGSize)size{
    BaseContractsView* contractsView=[[BaseContractsView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    contractsView.PDFImageName=PDFImageName;
    contractsView.btnImageNames=imageNames;
    [contractsView setUp];
    return contractsView;
}

-(void)setUp{
    [self addSubview:self.PDFBtn];
    [self.btns enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self addSubview:obj];
    }];
}

-(void)PDFBtnClicked{

}

-(void)btnsClickedWithBtn:(UIButton*)btn{

}

-(NSMutableArray *)btns{
    if (!_btns) {
        _btns=[NSMutableArray array];
        NSInteger btnCount=self.btnImageNames.count;
        CGFloat wholeWidth=294;
        CGFloat width = 0;
        switch (btnCount) {
            case 2:
                width=128;
                break;
            case 3:
                width=92;
                break;
        }
        CGFloat space=(wholeWidth-btnCount*width)/(btnCount-1);
        CGFloat minX=(kScreenWidth-wholeWidth)/2;
        [self.btnImageNames enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UIButton* btn=[[UIButton alloc]initWithFrame:CGRectMake(minX+idx*(width+space), 383, width, 37)];
            [btn setBackgroundImage:[GetImagePath getImagePath:obj] forState:UIControlStateNormal];
            [_btns addObject:btn];
            
            [btn addTarget:self action:@selector(btnsClickedWithBtn:) forControlEvents:UIControlEventTouchUpInside];
        }];
    }
    return _btns;
}

-(UIButton *)PDFBtn{
    if (!_PDFBtn) {
        _PDFBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 160, 194)];
        _PDFBtn.center=CGPointMake(kScreenWidth*0.5, 170);
        [_PDFBtn setBackgroundImage:[GetImagePath getImagePath:self.PDFImageName] forState:UIControlStateNormal];
        [_PDFBtn addTarget:self action:@selector(PDFBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _PDFBtn;
}
@end
