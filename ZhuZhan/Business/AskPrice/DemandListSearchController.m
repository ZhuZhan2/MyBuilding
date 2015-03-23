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
    //elf.navigationController.view.transform=CGAffineTransformMakeTranslation(0, -64);
    //[self.navigationController setNavigationBarHidden:YES animated:NO];
    [self setUpSearchBarWithNeedTableView:YES isTableViewHeader:NO];
    [self.searchBar becomeFirstResponder];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    //[self.navigationController setNavigationBarHidden:NO animated:NO];
    //self.navigationController.view.transform=CGAffineTransformMakeTranslation(0, 0);
    self.searchBar.showsCancelButton=NO;
    //self.navigationController.navigationBar.barTintColor=RGBCOLOR(85, 103, 166);
    //[self searchBarTableViewDisppear];
    //self.view.transform=CGAffineTransformMakeTranslation(0, -upHeight);

    //[UIView animateWithDuration:0.3 animations:^{
    self.navigationController.view.transform=CGAffineTransformIdentity;//CGAffineTransformMakeTranslation(0, 0);
    //[(UIView*)self.navigationController.view.subviews.lastObject setAlpha:0];
    //self.view.alpha=1;
    // } completion:^(BOOL finished) {
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //[self.navigationController.view.subviews.lastObject removeFromSuperview];
    
    [super searchBarCancelButtonClicked:searchBar];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)appearAnimation:(UISearchBar *)searchBar{
    self.searchBar.showsCancelButton=YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    CGFloat height=65+CGRectGetHeight(self.stageChooseView.frame);
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
    view.alpha=0;
    view.backgroundColor=RGBCOLOR(223, 223, 223);
    [self.navigationController.view addSubview:view];
    
    UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.searchBar.frame)+64+CGRectGetHeight(self.stageChooseView.frame), kScreenWidth, CGRectGetHeight(self.view.frame))];
    [button addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [UIView animateWithDuration:0.3 animations:^{
        view.alpha=1;
        CGFloat ty=64-20+CGRectGetHeight(self.stageChooseView.frame);
        self.navigationController.view.transform=CGAffineTransformMakeTranslation(0, -ty);
    } completion:^(BOOL finished) {
        
    }];
}

-(void)disappearAnimation:(UISearchBar *)searchBar{
    searchBar.text=@"";
    self.searchBar.showsCancelButton=NO;
    self.navigationController.navigationBar.barTintColor=RGBCOLOR(85, 103, 166);
    //[self searchBarTableViewDisppear];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.navigationController.view.transform=CGAffineTransformMakeTranslation(0, 0);
        [(UIView*)self.navigationController.view.subviews.lastObject setAlpha:0];
        self.view.alpha=1;
    } completion:^(BOOL finished) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        [self.navigationController.view.subviews.lastObject removeFromSuperview];
        [self.view.subviews.lastObject removeFromSuperview];
        [searchBar resignFirstResponder];
    }];
}


-(void)backBtnClicked{
    [self.searchBar resignFirstResponder];
//    [self disappearAnimation:self.searchBar];
}

//-(void)disappearAnimation:(UISearchBar *)searchBar{
//    searchBar.text=@"";
//    self.searchBar.showsCancelButton=NO;
//    self.navigationController.navigationBar.barTintColor=RGBCOLOR(85, 103, 166);
//    [self searchBarTableViewDisppear];
//    
//    [UIView animateWithDuration:0.3 animations:^{
//        self.navigationController.view.transform=CGAffineTransformMakeTranslation(0, 0);
//        [(UIView*)self.navigationController.view.subviews.lastObject setAlpha:0];
//        self.view.alpha=1;
//    } completion:^(BOOL finished) {
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//        [self.navigationController.view.subviews.lastObject removeFromSuperview];
//        [self.view.subviews.lastObject removeFromSuperview];
//        [searchBar resignFirstResponder];
//    }];
//}
@end
