//
//  PersonalDetailViewController.m
//  ZhuZhan
//
//  Created by Jack on 14-8-27.
//
//

#import "PersonalDetailViewController.h"

@interface PersonalDetailViewController ()

@end

@implementation PersonalDetailViewController

@synthesize contactArr,kImgArr,textViewHeight,titleArr;
static NSString * const PSTableViewCellIdentifier = @"PSTableViewCellIdentifier";


-(id)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont fontWithName:@"GurmukhiMN-Bold" size:19], NSFontAttributeName,
                                                                     nil]];
    
    self.title = @"帐户";
    
    //LeftButton设置属性
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 5, 29, 28.5)];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"icon_04.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    

    
    contactArr = @[@"beibqtds@gmail.com",@"13938439096"];
    kImgArr = @[@"人脉－人的详情_21a",@"人脉－人的详情_23a"];
    titleArr =@[@"email",@"手 机"];
    _pathCover = [[XHPathCover alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200)];
    _pathCover.delegate = self;
    [_pathCover setBackgroundImage:[UIImage imageNamed:@"首页_16.png"]];
    [_pathCover setHeadImageUrl:@"http://www.faceplusplus.com.cn/wp-content/themes/faceplusplus/assets/img/demo/1.jpg"];
    [_pathCover hidewaterDropRefresh];
    [_pathCover setNameFrame:CGRectMake(145, 20, 100, 20) font:[UIFont systemFontOfSize:14]];
    [_pathCover setInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"Jack", XHUserNameKey, nil]];
    
    
    self.tableView.tableHeaderView = self.pathCover;

    
    __weak PersonalDetailViewController *wself = self;
    [_pathCover setHandleRefreshEvent:^{
        [wself _refreshing];
    }];
    
       [self.tableView setSeparatorInset:UIEdgeInsetsZero];//设置tableViewcell下划线的位置没有偏移


}

- (void)_refreshing {
    // refresh your data sources
    __weak PersonalDetailViewController *wself = self;
    double delayInSeconds = 4.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [wself.pathCover stopRefresh];
    });
}



/******************************************************************************************************************/
//滚动是触发的事件
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_pathCover scrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [_pathCover scrollViewDidEndDecelerating:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [_pathCover scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_pathCover scrollViewWillBeginDragging:scrollView];
    
}
/******************************************************************************************************************/

-(void)leftBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;//决定tableview的section
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return 10;
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row==0) {
     
            static NSString *identifier = @"Cell";
            UITableViewCell *companyCell =[tableView dequeueReusableCellWithIdentifier:identifier];
            if (!companyCell) {
                companyCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            
            UILabel *companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 150, 30)];
            companyLabel.textAlignment = NSTextAlignmentLeft;
            companyLabel.text = @"上海深即网络";
            companyLabel.font = [UIFont systemFontOfSize:14];
            [companyCell addSubview:companyLabel];
            
            
            UILabel *positionLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 20, 80, 30)];
            positionLabel.textAlignment = NSTextAlignmentLeft;
            positionLabel.textColor = [UIColor grayColor];
            positionLabel.text = @"lisis";
            positionLabel.font = [UIFont systemFontOfSize:14];
            [companyCell addSubview:positionLabel];
            companyCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return companyCell;

    }
    if (indexPath.row ==1) {
        static NSString *identifier = @"Cell1";
        UITableViewCell *contactCell =[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!contactCell) {
            contactCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = @"联系方式";
        titleLabel.textColor =BlueColor;
        [contactCell addSubview:titleLabel];
        contactCell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"grayColor"]];
        contactCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return contactCell;

    }
    if (indexPath.row ==2 ||indexPath.row==3) {
        static NSString *identifier = @"Cell2";
        UITableViewCell *contactDetailCell =[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!contactDetailCell) {
            contactDetailCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 30)];
        label.text = [titleArr objectAtIndex:indexPath.row-2];
        [contactDetailCell addSubview:label];
        UILabel *commonLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 150, 30)];
        commonLabel.textAlignment = NSTextAlignmentLeft;
        commonLabel.text = [contactArr objectAtIndex:indexPath.row-2];
        commonLabel.font = [UIFont systemFontOfSize:14];
        commonLabel.tag= indexPath.row;
        [contactDetailCell addSubview:commonLabel];
        
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = CGRectMake(250, 10, 30, 30);
        [rightBtn setBackgroundImage:[UIImage imageNamed:[kImgArr objectAtIndex:indexPath.row-2]] forState:UIControlStateNormal];
        [contactDetailCell addSubview:rightBtn];
        contactDetailCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return contactDetailCell;

    }
    if (indexPath.row==4) {
        static NSString *identifier = @"Cell3";
        UITableViewCell *bgCell =[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!bgCell) {
            bgCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor =BlueColor;
        titleLabel.text = @"个人背景";
        [bgCell addSubview:titleLabel];
        bgCell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"grayColor"]];
        bgCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return bgCell;

    }
    if (indexPath.row ==5) {
        static NSString *identifier = @"Cell4";
        UITableViewCell *backGroundCell =[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!backGroundCell) {
            backGroundCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        NSString *textStr =@"oifdjbfddgk;lkhlfgljfdgjfshrfndkjfndiosdhfdfihdiufhudhfidfudfufifhilkhlfgljfdgjfshrfndkjfndiosdhfdfihdiufhudhfidfudfufifhilkhlfgljfdgjfshrfndkjfndiosdhfdfihdiufhudhfidfudfufifhilkhlfgljfdgjfshrfndkjfndiosdhfdfihdiufhudhfidfudfufifhi";
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(20, 60, 280, textViewHeight)];
        textView.editable =NO;
        textView.textAlignment = NSTextAlignmentLeft;
        textView.text = textStr;
        textView.font = [UIFont systemFontOfSize:14];
        
        UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, textViewHeight+60)];
        [backGroundCell addSubview:bgview];
        
        UILabel *companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 280, 30)];
        companyLabel.text = @"上海某某公司";
        companyLabel.textAlignment = NSTextAlignmentLeft;
        [bgview addSubview:companyLabel];
        
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, 280, 30)];
        timeLabel.text = @"XX年XX月－－目前";
        timeLabel.textAlignment = NSTextAlignmentLeft;
        [bgview addSubview:timeLabel];
        [bgview addSubview:textView];
        
        backGroundCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return backGroundCell;
        
    }
    
    if (indexPath.row==6) {
        static NSString *identifier = @"Cell5";
        UITableViewCell *relevantCell =[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!relevantCell) {
            relevantCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor =BlueColor;
        titleLabel.text = @"关联项目";
        [relevantCell addSubview:titleLabel];
        relevantCell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"grayColor"]];
        relevantCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return relevantCell;
        
    }
    

    static NSString *identifier = @"Cell6";
    UITableViewCell *relevantDetailCell =[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!relevantDetailCell) {
        relevantDetailCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame =CGRectMake(40, 10, 30, 30);
    [button setBackgroundImage:[UIImage imageNamed:@"read"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(goToProject:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = indexPath.row+20140903;
    [relevantDetailCell addSubview:button];
    UILabel *ProjectLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 0, 150, 30)];
    ProjectLabel.textAlignment = NSTextAlignmentLeft;
    ProjectLabel.text = @"项目名称显示在这里";
    ProjectLabel.font = [UIFont systemFontOfSize:14];
    [relevantDetailCell addSubview:ProjectLabel];
    
    
    UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 20, 120, 30)];
    addressLabel.textAlignment = NSTextAlignmentLeft;
    addressLabel.textColor = [UIColor grayColor];
    addressLabel.text = @"华南区－上海";
    addressLabel.font = [UIFont systemFontOfSize:14];
    relevantDetailCell.selectionStyle = UITableViewCellSelectionStyleNone;
    [relevantDetailCell addSubview:addressLabel];
    
    return relevantDetailCell;

    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row ==2) {
        [self onClickAttention:indexPath.row];
    }
    if (indexPath.row==3) {
        [self onClickToCall:indexPath.row];
        
    }

    
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row==1 || indexPath.row==4 || indexPath.row==6) {
        return 40;
    }
    if (indexPath.row==5) {
        NSString *textStr =@"oifdjbfddgk;lkhlfgljfdgjfshrfndkjfndiosdhfdfihdiufhudhfidfudfufifhi";
        [self heightForString:textStr fontSize:14 andWidth:280];
        NSLog(@"textViewHeight %f",textViewHeight);
        return textViewHeight+60;
    }
    
    return 50;
    
}


//**************************************************************************************************************
-(void)onClickToCall:(int)indexPathRow//打电话
{
    NSLog(@"***********");
    UILabel *label = (UILabel *)[self.view viewWithTag:indexPathRow];
    NSString *telephone = [NSString stringWithFormat:@"tel://%@",label.text];
[[UIApplication sharedApplication] openURL:[NSURL URLWithString:telephone]];
}

//**************************************************************************************************************
-(void)onClickAttention:(int)indexPathRow
{
    if ([MFMailComposeViewController canSendMail]){
        // Email Subject
        NSString *emailTitle = nil;
        // Email Content
        NSString *messageBody = nil;
        // To address
        UILabel *label = (UILabel *)[self.view viewWithTag:indexPathRow];
        NSArray *toRecipents = [NSArray arrayWithObject:label.text];
        
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setMessageBody:messageBody isHTML:NO];
        [mc setToRecipients:toRecipents];
        
        // Present mail view controller on screen
        [self presentViewController:mc animated:YES completion:NULL];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"Your device doesn't support the composer sheet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        
        [alert show];
        

    }
}


- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

//***************************************************************************************************************

-(void)goToProject:(UIButton *)button//进入到相关项目中去
{

}
- (void) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width//根据 字符串的的 长度来计算UITextView的高度
{
    textViewHeight = [[NSString stringWithFormat:@"%@\n ",value] boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:fontSize],NSFontAttributeName, nil] context:nil].size.height;
    
    
}

-(void)rightBtnClicked:(UIButton *)button
{

    
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
