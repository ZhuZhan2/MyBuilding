//
//  MarketPopView.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/6/4.
//
//

#import "MarketPopView.h"

@interface MarketPopView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIButton *bgBtn;
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation MarketPopView

-(id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self addSubview:self.bgBtn];
        [self addSubview:self.tableView];
    }
    return self;
}

-(UIButton *)bgBtn{
    if(!_bgBtn){
        _bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _bgBtn.frame = self.frame;
        _bgBtn.backgroundColor = [UIColor clearColor];
        [_bgBtn addTarget:self action:@selector(bgBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bgBtn;
}

-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(160, 55, 149, 265) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        UIView* headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 149, 10)];
        _tableView.tableHeaderView = headerView;
        
        UIImageView* back = [[UIImageView alloc]initWithFrame:_tableView.bounds];
        back.image = [GetImagePath getImagePath:@"selectBox"];
        _tableView.backgroundView = back;
    }
    return _tableView;
}

-(void)bgBtnAction{
    if([self.delegate respondsToSelector:@selector(closePopView)]){
        [self.delegate closePopView];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellIdentifier = [NSString stringWithFormat:@"Cell"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self.delegate respondsToSelector:@selector(selectIndex:)]){
        [self.delegate selectIndex:indexPath.row];
    }
}
@end
