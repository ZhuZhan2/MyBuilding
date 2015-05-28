//
//  CompanyViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-5.
//  Copyright (c) 2014年 zpzchina. All rights reserved.
//

#import "CompanyViewController.h"
#import "CompanyMemberViewController.h"
#import "MoreCompanyViewController.h"
#import "ProjectApi.h"
#import "CompanyApi.h"
#import "ContactModel.h"
#import "LoginSqlite.h"
#import "ConnectionAvailable.h"
#import "MBProgressHUD.h"
#import "IsFocusedApi.h"
#import "AskPriceMainViewController.h"

@interface CompanyViewController ()
@property(nonatomic,strong)UIScrollView* myScrollView;
@property(nonatomic)NSInteger memberNumber;
@property(nonatomic,strong)UIImageView* imageView;
@property(nonatomic,strong)UILabel* noticeLabel;
@property(nonatomic)BOOL isFocused;
@property (nonatomic, strong)UIButton* askPriceBtn;
@end

@implementation CompanyViewController

-(BOOL)isFocused{
    return [self.model.a_focused isEqualToString:@"1"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initMyScrollViewAndNavi];//scollview和navi初始
    [self initFirstView];//第一个文字view初始
    if (self.needNoticeView) [self initSecondView];//第二个文字view初始
    [self initThirdView];
}

//给MyScrollView的contentSize加高度
-(void)scrollViewAddView:(UIView*)view{
    CGSize size=self.myScrollView.contentSize;
    size.height+=view.frame.size.height;
    self.myScrollView.contentSize=size;
    [self.myScrollView addSubview:view];
}

-(void)initFirstView{
    //view的初始,后面为在上添加label button等
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, self.needNoticeView?155:115)];
    [self scrollViewAddView:view];
    
    UIImage *appleImage = [GetImagePath getImagePath:@"公司－我的公司_02a"] ;
    //公司图标
    UIImageView* companyImageView=[[UIImageView alloc]init];
    [companyImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.model.a_companyLogo]] placeholderImage:appleImage];
    companyImageView.layer.cornerRadius=37.5;
    companyImageView.layer.masksToBounds=YES;
    companyImageView.frame=CGRectMake(15, 20, 75, 75);
    [view addSubview:companyImageView];
    
    //公司名称label
    UILabel* companyLabel=[[UILabel alloc]initWithFrame:CGRectMake(105, 20, 200, 50)];
    //companyLabel.backgroundColor=[UIColor yellowColor];
    companyLabel.numberOfLines=2;
    companyLabel.textColor=RGBCOLOR(62, 127, 226);
    NSString* companyName=self.model.a_companyName;
    companyLabel.text=companyName;
    companyLabel.font=[UIFont boldSystemFontOfSize:19];
    [view addSubview:companyLabel];
    
    //公司行业label
    UILabel* businessLabel=[[UILabel alloc]initWithFrame:CGRectMake(105, 72                                                                                                                                        , 300, 20)];
    businessLabel.text=[NSString stringWithFormat:@"企业行业：%@",self.model.a_companyIndustry];
    businessLabel.font=[UIFont boldSystemFontOfSize:15];
    businessLabel.textColor=RGBCOLOR(168, 168, 168);
    [view addSubview:businessLabel];
    
    //发起均价按钮
    if (!self.needNoticeView) return;
    self.askPriceBtn.center = CGPointMake(kScreenWidth*0.5, 102+CGRectGetHeight(self.askPriceBtn.frame)*0.5);
    [view addSubview:self.askPriceBtn];
}

-(void)handleContent{
    UIImage* image=[GetImagePath getImagePath:self.isFocused?@"公司－我的公司_05b":@"公司－我的公司_05a"];
    if (!self.imageView){
        self.imageView=[[UIImageView alloc]initWithImage:image];
    }else{
        self.imageView.image=image;
    }
    self.noticeLabel.text=self.isFocused?@"已关注":@"加关注";
    self.noticeLabel.textColor=self.isFocused?RGBCOLOR(141, 196, 62):RGBCOLOR(226, 97, 97);
}

-(void)initSecondView{
    self.noticeLabel=[[UILabel alloc]initWithFrame:CGRectMake(45, 16, 100, 20)];
    [self handleContent];
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, self.myScrollView.contentSize.height, self.imageView.frame.size.width, self.imageView.frame.size.height)];
    [self scrollViewAddView:view];
    [view addSubview:self.imageView];
    
    self.noticeLabel.font=[UIFont boldSystemFontOfSize:16];
    [view addSubview:self.noticeLabel];
    
    UIButton* noticeBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 116, 49)];
    [noticeBtn addTarget:self action:@selector(noticeCompany:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:noticeBtn];
    
    UILabel* memberCountLabel=[[UILabel alloc]initWithFrame:CGRectMake(165, 16, 150, 20)];
    memberCountLabel.text=[NSString stringWithFormat:@"企业员工%@人",self.model.a_companyEmployeeNumber];
    memberCountLabel.font=[UIFont boldSystemFontOfSize:16];
    memberCountLabel.textColor=RGBCOLOR(62, 127, 226);
    [view addSubview:memberCountLabel];
    
    UIButton* memberBtn=[[UIButton alloc]initWithFrame:CGRectMake(116, 0, 204, 49)];
    [memberBtn addTarget:self action:@selector(gotoMemberView) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:memberBtn];
}

-(void)initThirdView{
    NSString* str=self.model.a_companyDescription;
    CGRect bounds=[str boundingRectWithSize:CGSizeMake(280, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(20, 15, 280, bounds.size.height)];
    label.numberOfLines=0;
    label.text=str;
    label.font=[UIFont systemFontOfSize:15];
    label.textColor=GrayColor;
    
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, self.myScrollView.contentSize.height, 320, label.frame.size.height+30)];
    [view addSubview:label];
    [self scrollViewAddView:view];
    
    if (!self.needNoticeView) {
        UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 4)];
        imageView.image=[GetImagePath getImagePath:@"公司－我的公司_11a"];
        [view addSubview:imageView];
    }
}

-(void)initMyScrollViewAndNavi{
    //myScrollView初始化
    self.myScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, kScreenHeight-49)];
    self.myScrollView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:self.myScrollView];
    
    //navi初始化
    self.title = @"我的企业";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:19], NSFontAttributeName,nil]];
    
    UIButton* button=[UIButton buttonWithType:UIButtonTypeSystem];
    button.frame=CGRectMake(0, 0, 50, 30);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont systemFontOfSize:14];
    [button setTitle:@"更多" forState:UIControlStateNormal];
    button.backgroundColor=[UIColor clearColor];
    [button addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
}

-(void)noticeCompany:(UIButton*)btn{
    if (![ConnectionAvailable isConnectionAvailable]) {
        [MBProgressHUD myShowHUDAddedTo:self.view animated:YES];
        return;
    }
    
    btn.userInteractionEnabled=NO;
    if (self.isFocused) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:self.model.a_id forKey:@"targetId"];
        [dic setObject:@"02" forKey:@"targetCategory"];
        [IsFocusedApi AddFocusedListWithBlock:^(NSMutableArray *posts, NSError *error) {
            if (!error) {
                self.model.a_focused=@"0";
                [self handleContent];
            }else{
                if([ErrorCode errorCode:error] == 403){
                    [LoginAgain AddLoginView:NO];
                }else{
                    [ErrorCode alert];
                }
            }
            btn.userInteractionEnabled=YES;
        } dic:dic noNetWork:^{
            [ErrorCode alert];
        }];
    }else{
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:self.model.a_id forKey:@"targetId"];
        [dic setObject:@"02" forKey:@"targetCategory"];
        [IsFocusedApi AddFocusedListWithBlock:^(NSMutableArray *posts, NSError *error) {
            if(!error){
                self.model.a_focused=@"1";
                [self handleContent];
            }else{
                if([ErrorCode errorCode:error] == 403){
                    [LoginAgain AddLoginView:NO];
                }else{
                    [ErrorCode alert];
                }
            }
            btn.userInteractionEnabled=YES;
        } dic:dic noNetWork:^{
            [ErrorCode alert];
        }];
    }
    
    NSLog(@"用户选择了关注");
}

-(void)gotoMemberView{
    CompanyMemberViewController* memberVC=[[CompanyMemberViewController alloc]init];
    memberVC.companyId = self.model.a_id;
    [self.navigationController pushViewController:memberVC animated:YES];
}

-(void)more{
    MoreCompanyViewController* moreVC=[[MoreCompanyViewController alloc]init];
    moreVC.isCompanyIdentify=YES;
    [self.navigationController pushViewController:moreVC animated:YES];
}

- (void)gotoAskPrice{
    NSLog(@"询价");
    //因为该界面为自己公司的详情，所以一定登录了，不用判断是否登录
    AskPriceMainViewController *view = [[AskPriceMainViewController alloc] init];
    view.userId = self.model.a_id;
    view.userName = self.model.a_loginName;
    view.closeAnimation = YES;
    [self.navigationController pushViewController:view animated:YES];
}

- (UIButton *)askPriceBtn{
    if (!_askPriceBtn) {
        _askPriceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _askPriceBtn.frame = CGRectMake(0, 0, kScreenWidth, 44);
        [_askPriceBtn setImage:[GetImagePath getImagePath:@"发起询价"] forState:UIControlStateNormal];
        [_askPriceBtn addTarget:self action:@selector(gotoAskPrice) forControlEvents:UIControlEventTouchUpInside];
    }
    return _askPriceBtn;
}
@end
