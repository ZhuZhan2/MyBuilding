//
//  DemandListSearchController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/23.
//
//

#import "DemandListSearchController.h"

@interface DemandListSearchController ()

@end

@implementation DemandListSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSearchBarWithNeedTableView:YES isTableViewHeader:NO];
    [self.searchBar becomeFirstResponder];
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self.navigationController popViewControllerAnimated:YES];
    [self disappearAnimation:searchBar];
}

-(void)disappearAnimation:(UISearchBar *)searchBar{
    self.navigationController.view.transform=CGAffineTransformMakeTranslation(0, 0);
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.searchBarAnimationBackView removeFromSuperview];
}

-(void)appearAnimation:(UISearchBar *)searchBar{
    self.searchBar.showsCancelButton=YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    CGFloat height=65+CGRectGetHeight(self.stageChooseView.frame);
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
    self.searchBarAnimationBackView=view;
    self.searchBarAnimationBackView.alpha=0;
    self.searchBarAnimationBackView.backgroundColor=RGBCOLOR(223, 223, 223);
    [self.navigationController.view addSubview:self.searchBarAnimationBackView];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.searchBarAnimationBackView.alpha=1;
        CGFloat ty=64-20+CGRectGetHeight(self.stageChooseView.frame);
        self.navigationController.view.transform=CGAffineTransformMakeTranslation(0, -ty);
    } completion:^(BOOL finished) {
        
    }];
}
@end
