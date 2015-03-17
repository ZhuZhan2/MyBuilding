//
//  ChooseProductBigStage.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/17.
//
//

#import "ChooseProductBigStage.h"

@interface ChooseProductBigStage ()

@end

@implementation ChooseProductBigStage
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    //[self setUpSearchBarWithNeedTableView:YES];
    //[self initTableView];
}

-(void)initNavi{
    self.title=@"请选择产品大类";
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 11;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
@end
