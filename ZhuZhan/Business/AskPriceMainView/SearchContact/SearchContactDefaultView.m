//
//  SearchContactDefaultView.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/5/27.
//
//

#import "SearchContactDefaultView.h"
#import "SearchContactTableViewCell.h"
#import "AskPriceApi.h"
#import "UserOrCompanyModel.h"

@interface SearchContactDefaultView ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableDictionary *groupDic;
@property(nonatomic,strong)NSMutableArray *companyArr;
@property(nonatomic,strong)NSMutableArray *friendArr;
@property(nonatomic,strong)NSMutableArray *sectionSelectedArray;
@end

@implementation SearchContactDefaultView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self firstNetWork];
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.tableView];
    }
    return self;
}

-(void)firstNetWork{
    [AskPriceApi GetFriendAndFocusCompanyListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.groupDic = posts[0];
            self.companyArr = self.groupDic[@"focusCompany"];
            self.friendArr = self.groupDic[@"friendList"];
            [self.tableView reloadData];
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self reloadBlock:^{
                    [self firstNetWork];
                }];
            }
        }
    } noNetWork:^{
        [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self reloadBlock:^{
            [self firstNetWork];
        }];
    }];
}

-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.frame.size.height)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = NO;
    }
    return _tableView;
}

-(NSMutableDictionary *)groupDic{
    if(!_groupDic){
        _groupDic = [[NSMutableDictionary alloc] init];
    }
    return _groupDic;
}

-(NSMutableArray *)friendArr{
    if(!_friendArr){
        _friendArr = [NSMutableArray array];
    }
    return _friendArr;
}

-(NSMutableArray *)companyArr{
    if(!_companyArr){
        _companyArr = [NSMutableArray array];
    }
    return _companyArr;
}

-(NSMutableArray *)sectionSelectedArray{
    if (!_sectionSelectedArray) {
        _sectionSelectedArray=[NSMutableArray array];
    }
    return _sectionSelectedArray;
}

-(BOOL)sectionSelectedArrayContainsSection:(NSInteger)section{
    NSString* sectionStr=[NSString stringWithFormat:@"%d",(int)section];
    return  [self.sectionSelectedArray containsObject:sectionStr];
}

-(BOOL)sectionViewClickedWithSection:(NSInteger)section{
    NSString* sectionStr=[NSString stringWithFormat:@"%d",(int)section];
    BOOL isContainsSection=[self.sectionSelectedArray containsObject:sectionStr];
    SEL action=isContainsSection?@selector(removeObject:):@selector(addObject:);
    [self.sectionSelectedArray performSelector:action withObject:sectionStr];
    return isContainsSection;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 47;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    AddressBookModel *model = self.groupArr[section];
    if(section == 0){
        return [self sectionSelectedArrayContainsSection:section]?0:self.friendArr.count;
    }else{
        return [self sectionSelectedArrayContainsSection:section]?0:self.companyArr.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    BOOL isShow=![self sectionSelectedArrayContainsSection:section];
    CGFloat sectionHeight=30;
    UIButton* view=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, sectionHeight)];
    view.backgroundColor=[UIColor whiteColor];
    
    NSString* text;
    if(section == 0){
        text=@"通讯录联系人";
    }else{
        text=@"关注的公司";
    }
    UIFont* textFont=[UIFont systemFontOfSize:14];
    CGFloat labelWidth=[text boundingRectWithSize:CGSizeMake(9999, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:textFont} context:nil].size.width;
    UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(11, 0, labelWidth, sectionHeight)];
    label.text=text;
    label.textColor=GrayColor;
    label.font=[UIFont systemFontOfSize:14];
    [view addSubview:label];
    
    CGFloat imageViewOrginX=CGRectGetWidth(label.frame)+CGRectGetMinX(label.frame)+5;
    UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(imageViewOrginX, 11, 8, 8)];
    imageView.image=[GetImagePath getImagePath:isShow?@"分组打开":@"分组关闭"];
    [view addSubview:imageView];
    
    UIView* seperatorLine1=[SearchContactTableViewCell fullSeperatorLine];
    seperatorLine1.center=CGPointMake(view.center.x, CGRectGetHeight(view.frame));
    [view addSubview:seperatorLine1];
    
    [view addTarget:self action:@selector(sectionDidSelectWithBtn:) forControlEvents:UIControlEventTouchUpInside];
    view.tag=section;
    return view;
}

-(void)sectionDidSelectWithBtn:(UIButton*)btn{
    NSInteger section=btn.tag;
    [self sectionViewClickedWithSection:section];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchContactTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[SearchContactTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(indexPath.section == 0){
        UserOrCompanyModel *model = self.friendArr[indexPath.row];
        cell.companyNameStr = model.a_loginName;
    }else{
        UserOrCompanyModel *model = self.companyArr[indexPath.row];
        cell.companyNameStr = model.a_loginName;
    }
    return cell;
}

@end
