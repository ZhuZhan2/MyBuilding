//
//  ChooseProductSmallStage.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/17.
//
//

#import "ChooseProductSmallStage.h"

@interface ChooseProductSmallStage ()

@end

@implementation ChooseProductSmallStage
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    [self initTableView];
}

-(void)initNavi{
    self.title=@"请选择产品分类";
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
    [self setRightBtnWithText:@"确定"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 11;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
@end
