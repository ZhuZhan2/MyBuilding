//
//  ProgramDetailViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 14-8-26.
//
//

#import "ProgramDetailViewController.h"
#import "ProjectApi.h"
#import "ProjectImageModel.h"
#import "ProjectContactModel.h"
@interface ProgramDetailViewController ()

@end

@implementation ProgramDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self initNaviAndScrollView];
    [ProjectApi SingleProjectWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            NSLog(@"==========%@",posts);
            //posts下标0是联系人数组 下标1是图片数组
            for(int i=0;i<[posts[0] count];i++){
                ProjectContactModel *contactModel = posts[0][i];
                NSLog(@"%@",contactModel.a_category);
            }
            
            for(int i=0;i<[posts[1] count];i++){
                ProjectImageModel *imageModel = posts[1][i];
                NSLog(@"%@",imageModel.a_imageCategory);
            }
        }else{
        
        }
    } projectId:self.ID];
    // Do any additional setup after loading the view.
}

-(void)initNaviAndScrollView{
    [self addBackButton];
//    CGRect frame=CGRectMake(285,30,25.5,22.5);
//    UIButton* modificationButton=[UIButton buttonWithType:UIButtonTypeCustom];
//    modificationButton.frame=frame;
//    [modificationButton setImage:[UIImage imageNamed:@"XiangMuXiangQing/more_01@2x.png"] forState:UIControlStateNormal];
//    [modificationButton addTarget:self action:@selector(gotoModificationVC) forControlEvents:UIControlEventTouchUpInside];
//    [self.topView addSubview:modificationButton];
    
    
//    //scrollView初始
//    NSLog(@"============%f",self.contentView.frame.size.height);
//    self.myScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, self.contentView.frame.size.height)];
//    self.myScrollView.backgroundColor=RGBCOLOR(229, 229, 229);
//    self.myScrollView.showsVerticalScrollIndicator=NO;
//    [self.contentView addSubview:self.myScrollView];
//    
//    CGSize size=self.myScrollView.bounds.size;
//    //预留下方动画高度
//    size.height=50+56;//50是上导航的位置,56是下方动画的预留位置
//    self.myScrollView.contentSize=size;
//    
//    //动画view控制初始
//    self.animationView=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
//    self.animationView.color=[UIColor blackColor];
//    
//    //用来在加载新页面时,下方开始圈圈动画的时候,页面无法点击 该view初始
//    self.spaceView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 568-64.5)];
//    self.spaceView.backgroundColor=[UIColor clearColor];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
