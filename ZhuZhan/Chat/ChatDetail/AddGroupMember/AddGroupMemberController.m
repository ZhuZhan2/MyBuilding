//
//  AddGroupMemberController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/11.
//
//

#import "AddGroupMemberController.h"
#import "AddImageView.h"
#import "ChooseContactsViewController.h"
@interface AddGroupMemberController ()<AddImageViewDelegate>
@property(nonatomic,strong)AddImageView* addImageView;
@property(nonatomic,strong)UIView* secondView;
@property(nonatomic,strong)UITableView* tableView;
@end

#define backColor RGBCOLOR(242, 242, 242)

@implementation AddGroupMemberController
-(void)viewDidLoad{
    [super viewDidLoad];
    [self initNavi];
    [self initTableView];
    self.tableView.backgroundColor=backColor;
}

-(void)initNavi{
    self.title=@"群成员(等待接口完成再修改)";
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
    self.view.backgroundColor=backColor;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height=0;
    switch (indexPath.row) {
        case 0:
            height=CGRectGetHeight(self.addImageView.frame);
            break;
        case 1:
            height=CGRectGetHeight(self.secondView.frame);
            break;
    }
    return height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (indexPath.row==0) {
        [cell.contentView addSubview:self.addImageView];
    }else{
        [cell.contentView addSubview:self.secondView];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(AddImageView *)addImageView{
    if (!_addImageView) {
        NSMutableArray* array=[NSMutableArray arrayWithCapacity:5];
        for (int i=0; i<5; i++) {
            AddImageViewModel* model=[[AddImageViewModel alloc]init];
            model.name=@[@"顶顶顶顶",@"定定",@"啦啦啦"][arc4random()%3];
            [array addObject:model];
        }
        _addImageView=[AddImageView addImageViewWithModels:array];
        _addImageView.delegate=self;
    }
    return _addImageView;
}

-(UIView *)secondView{
    if (!_secondView) {
        _secondView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 175)];
        _secondView.backgroundColor=backColor;
        [self setUpSecondView];
    }
    return _secondView;
}

-(void)setUpSecondView{
    //setObject
    UIView* backView=[[UIView alloc]initWithFrame:CGRectMake(0, 18, kScreenWidth, 92)];
    backView.backgroundColor=[UIColor whiteColor];
    {
        UILabel* nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(35, 0, 200, CGRectGetHeight(backView.frame)*0.5)];
        UILabel* notificationLabel=[[UILabel alloc]initWithFrame:CGRectMake(35, CGRectGetHeight(backView.frame)*0.5, 150, CGRectGetHeight(backView.frame)*0.5)];
        UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-40, 17, 20, 20)];
        UISwitch* switchBtn=[[UISwitch alloc]init];
        switchBtn.center=CGPointMake(262, 67);
        
        nameLabel.text=@"群聊名称";
        notificationLabel.text=@"新消息通知";
        imageView.image=[GetImagePath getImagePath:@"添加联系人入群"];
        
        [backView addSubview:nameLabel];
        [backView addSubview:notificationLabel];
        [backView addSubview:imageView];
        [backView addSubview:switchBtn];
    }
    for (int i=0; i<3; i++) {
        UIView* view=[self seperatorLine];
        view.center=CGPointMake(kScreenWidth*0.5, -0.5+i%3*CGRectGetHeight(backView.frame)/2);
        [backView addSubview:view];
    }
    
    
    {
        UIButton* btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 255, 37)];
        [btn setBackgroundImage:[GetImagePath getImagePath:@"退出本群按钮带字"] forState:UIControlStateNormal];
        btn.center=CGPointMake(kScreenWidth*0.5, 155);
        [_secondView addSubview:btn];
    }
    [_secondView addSubview:backView];
}

-(UIView*)seperatorLine{
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    view.backgroundColor=RGBCOLOR(215, 215, 215);
    return view;
}

-(void)addImageBtnClicked{
    ChooseContactsViewController* vc=[[ChooseContactsViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
