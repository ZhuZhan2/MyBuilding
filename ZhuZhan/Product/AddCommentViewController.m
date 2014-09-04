//
//  AddCommentViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 14-9-3.
//
//

#import "AddCommentViewController.h"

@interface AddCommentViewController ()<UITextViewDelegate>
@property(nonatomic,strong)UILabel* countLabel;//字数label
@property(nonatomic,strong)UILabel* aboveMaxLabel;//超过字数限制时的中文提示label
@end

@implementation AddCommentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadSelf];
    [self initTitlePart];
    [self initTextViewPart];
    [self initTextCountPart];
}

-(void)initTextCountPart{
    UIView* separatorLine=[self getSeparatorLine];
    separatorLine.center=CGPointMake(140, self.view.frame.size.height-40);
    [self.view addSubview:separatorLine];
    
    self.countLabel=[[UILabel alloc]initWithFrame:CGRectMake(5, self.view.frame.size.height-30, 60, 20)];
    //self.countLabel.backgroundColor=[UIColor greenColor];
    self.countLabel.text=@"0/100";
    self.countLabel.font=[UIFont systemFontOfSize:16];
    self.countLabel.textAlignment=NSTextAlignmentRight;
    self.countLabel.textColor=RGBCOLOR(155, 155, 155);
    [self.view addSubview:self.countLabel];
    
    self.aboveMaxLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 140, 20)];
    self.aboveMaxLabel.center=CGPointMake(167, self.view.frame.size.height-20);
    [self.view addSubview:self.aboveMaxLabel];
    
    
}

-(void)initTextViewPart{
    CGRect frame=self.view.frame;
    frame.origin.y+=50;
    frame.size.height-=100;
    frame.origin.x+=10;
    frame.size.width-=20;
    
    UITextView* textView=[[UITextView alloc]initWithFrame:frame];
    textView.delegate=self;
    textView.backgroundColor=[UIColor clearColor];
    textView.font=[UIFont systemFontOfSize:18];
    [self.view addSubview:textView];
}

-(void)textViewDidChange:(UITextView *)textView{
    //该判断用于联想输入
    NSLog(@"%d",10-textView.text.length);
    if (textView.text.length<=100) {
        self.countLabel.text=[NSString stringWithFormat:@"%d/100",textView.text.length];
        self.aboveMaxLabel.text=nil;
    }else{
        self.countLabel.text=@"100/100";
        self.aboveMaxLabel.text=[NSString stringWithFormat:@"已经超过%d字",textView.text.length-100];
    }
}


-(void)initTitlePart{
    UILabel* titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
    titleLabel.center=CGPointMake(160, 19);
    titleLabel.text=@"评论动态";
    titleLabel.font=[UIFont boldSystemFontOfSize:18];
    [self.view addSubview:titleLabel];
    
    UIButton* cancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame=CGRectMake(10, 10, 50, 20);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font=[UIFont boldSystemFontOfSize:17];
    [cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
    
    UIButton* sureBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame=CGRectMake(220, 10, 50, 20);
    [sureBtn setTitle:@"确认" forState:UIControlStateNormal];
    [sureBtn setTitleColor:BlueColor forState:UIControlStateNormal];
    sureBtn.titleLabel.font=[UIFont boldSystemFontOfSize:17];
    [sureBtn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
    
    UIView* separatorLine=[self getSeparatorLine];
    separatorLine.center=CGPointMake(140, 40);
    [self.view addSubview:separatorLine];
}

-(void)cancel{
    NSLog(@"cancel");
}

-(void)sure{
    NSLog(@"sure");
}
//=========================================================================
//=========================================================================
//=========================================================================

-(UIView*)getSeparatorLine{
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 280, 1)];
    view.backgroundColor=RGBCOLOR(196, 196, 196);
    return view;
}

-(void)loadSelf{
    self.view.frame = CGRectMake(0, 0, 280, 220);
    self.view.layer.masksToBounds=YES;
    self.view.backgroundColor=[[UIColor alloc]initWithRed:1 green:1 blue:1 alpha:.95];
    self.view.layer.cornerRadius=12;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
