//
//  PersonalInfoController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/5/22.
//
//

#import "PersonalInfoController.h"
#import "ContactModel.h"
#import "MyCenterModel.h"
#import "ParticularsModel.h"
@interface PersonalInfoController ()
@property(nonatomic,strong)NSArray* views;
@property(nonatomic,strong)UIView* view1;
@property(nonatomic,strong)UIView* view2;
@property(nonatomic,strong)UIView* view3;
@property(nonatomic,strong)ParticularsModel* model;
@end

@implementation PersonalInfoController
- (void)setUp{
    [super setUp];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self loadList];
}

-(void)loadList{
    self.startIndex = 0;
    [self startLoading];
    NSLog(@"targetId=%@",self.targetId);
    [ContactModel UserDetailsWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            if(posts.count !=0){
                MyCenterModel* centerModel = posts[0];
                self.model = [[ParticularsModel alloc] init];
                self.model.dict = centerModel.dict[@"workHistory"] ;
                self.view1 = nil;
                self.view2 = nil;
                self.view3 = nil;
                self.views = nil;
                [self.tableView reloadData];
            }
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorCode alert];
            }
        }
         [self endLoading];
    } userId:self.targetId noNetWork:^{
        [self endLoading];
        [ErrorCode alert];
    }];
}

- (void)startLoading{
    [super startLoading];
    NSLog(@"开始");
}

- (void)endLoading{
    [super endLoading];
    NSLog(@"结束");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.views.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = NO;
    }
    [cell.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [cell addSubview:self.views[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UIView* view = self.views[indexPath.row];
    return CGRectGetHeight(view.frame);
}

- (NSArray *)views{
    if (!_views) {
        _views = @[self.view1,self.view2,self.view3];
    }
    return _views;
}

- (UIView *)view1{
    if (!_view1) {
        _view1 = [[UIView alloc] initWithFrame:CGRectZero];
        
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(17.5, 15, 0, 0)];
        label.font = [UIFont systemFontOfSize:16];
        label.numberOfLines = 0;
        label.text = self.model.a_company;
        [self autoLabel:label maxWidth:285];
        [_view1 addSubview:label];
        
        _view1.frame = CGRectMake(0, 0, kScreenWidth, CGRectGetMaxY(label.frame));
    }
   return _view1;
}

- (UIView *)view2{
    if (!_view2) {
        _view2 = [[UIView alloc] initWithFrame:CGRectZero];
        
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(17.5, 7, 0, 0)];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = AllLightGrayColor;
        label.numberOfLines = 0;
        NSString* inTime = self.model.a_inDate;
        NSString* outTime = [self.model.a_outDate isEqualToString:@""]?@"目前":self.model.a_outDate;
        label.text = [NSString stringWithFormat:@"(%@—%@)",inTime,outTime];
        [self autoLabel:label maxWidth:285];
        [_view2 addSubview:label];
        
        _view2.frame = CGRectMake(0, 0, kScreenWidth, CGRectGetMaxY(label.frame));
    }
    return _view2;
}

- (UIView *)view3{
    if (!_view3) {
        _view3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(17.5, 14, 0, 0)];
        label.font = [UIFont systemFontOfSize:15];
        label.numberOfLines = 0;
        label.text = self.model.a_company;
        [self autoLabel:label maxWidth:285];
        [_view3 addSubview:label];
        
        _view3.frame = CGRectMake(0, 0, kScreenWidth, CGRectGetMaxY(label.frame));

    }
    return _view3;
}

- (void)autoLabel:(UILabel*)label maxWidth:(CGFloat)maxWidth{
    CGRect bounds = [label.text boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label.font} context:nil];
    CGRect frame = label.frame;
    frame.size = bounds.size;
    label.frame = frame;
}
@end
