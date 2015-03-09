//
//  ChatBaseViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/5.
//
//

#import "ChatBaseViewController.h"
@interface ChatBaseViewController()
@property(nonatomic,strong)UIButton* rightBtn;
@property(nonatomic,strong)UIButton* leftBtn;

@property(nonatomic,strong)UISearchBar* searchBar;
@end

@implementation ChatBaseViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.leftBtnIsBack=YES;
    self.view.backgroundColor=[UIColor whiteColor];
}

-(void)setRightBtnWithImage:(UIImage*)image{
    if (!_rightBtn) {
        _rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
        [_rightBtn addTarget:self action:@selector(rightBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:_rightBtn];
    }
    [_rightBtn setBackgroundImage:image forState:UIControlStateNormal];
}

-(void)setRightBtnWithText:(NSString*)text{
    if (!_rightBtn) {
        UIFont* font=[UIFont systemFontOfSize:15];
        _rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, [text boundingRectWithSize:CGSizeMake(9999, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.width, 20)];
        [_rightBtn addTarget:self action:@selector(rightBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        _rightBtn.titleLabel.font=font;
        _rightBtn.titleLabel.textAlignment=NSTextAlignmentRight;
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:_rightBtn];
    }
    [_rightBtn setTitle:text forState:UIControlStateNormal];
}

-(void)rightBtnClicked{
    
}


-(void)setLeftBtnWithImage:(UIImage*)image{
    if (!_leftBtn) {
        _leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
        [_leftBtn setBackgroundImage:image forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(leftBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:_leftBtn];
    }else{
        [_leftBtn setBackgroundImage:image forState:UIControlStateNormal];
    }
}

-(void)leftBtnClicked{
    if (self.leftBtnIsBack) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)initTableView{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, self.searchBar?self.searchBar.frame.size.height+64:0, kScreenWidth, kScreenHeight-49-(self.searchBar?self.searchBar.frame.size.height:0)) style:UITableViewStylePlain];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

-(void)initSearchBar{
    self.searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, 320, 43)];
    self.searchBar.placeholder = @"搜索";
    self.searchBar.tintColor = [UIColor grayColor];
    self.searchBar.backgroundImage=[self imageWithColor:RGBCOLOR(223, 223, 223)];
    self.searchBar.delegate=self;
    [self.view addSubview:self.searchBar];
}

- (UIImage *)imageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
