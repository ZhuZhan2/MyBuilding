//
//  MarketView.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/5/5.
//
//

#import "MarketView.h"
#define contentHeight (kScreenHeight==480?431:519)
@implementation MarketView

-(id)initWithFrame:(CGRect)frame controller:(UIViewController *)controller{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = RGBCOLOR(237, 237, 237);
        self.controller = controller;
        [self addSubview:self.scrollView];
        [self addSubview:self.headImageView];
        [self.scrollView addSubview:self.adScrollView];
        [self.scrollView addSubview:self.centerImageView];
        [self.scrollView addSubview:self.phoneImageView];
        [self addSubview:self.contactBtn];
    }
    return self;
}


-(UIScrollView *)scrollView{
    if(!_scrollView){
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, 320, contentHeight-64)];
        _scrollView.contentSize = CGSizeMake(320, 455);
    }
    return _scrollView;
}

-(UIImageView *)headImageView{
    if(!_headImageView){
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
        _headImageView.image = [GetImagePath getImagePath:@"index_head"];
    }
    return _headImageView;
}

-(UIImageView *)homeImageView{
    if(!_homeImageView){
        _homeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 24, 21)];
        _homeImageView.image = [GetImagePath getImagePath:@"index_home"];
    }
    return _homeImageView;
}

-(AdScrollView *)adScrollView{
    if(!_adScrollView){
        _adScrollView = [[AdScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 100)];
        AdDataModel * dataModel = [AdDataModel adDataModelWithImageName];
        //_adScrollView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
        _adScrollView.imageNameArray = dataModel.imageNameArray;
        [_adScrollView setAdTitleArray:dataModel.adTitleArray withShowStyle:AdTitleShowStyleLeft];
    }
    return _adScrollView;
}

-(UIImageView *)centerImageView{
    if(!_centerImageView){
        _centerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 320, 224)];
        _centerImageView.image = [GetImagePath getImagePath:@"index_need"];
    }
    return _centerImageView;
}

-(UIImageView *)phoneImageView{
    if(!_phoneImageView){
        _phoneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 334, 320, 121)];
        _phoneImageView.image = [GetImagePath getImagePath:@"index_phone"];
    }
    return _phoneImageView;
}

-(UIButton *)contactBtn{
    if(!_contactBtn){
        _contactBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _contactBtn.frame = CGRectMake(5, 15, 40, 40);
        [_contactBtn addTarget:self action:@selector(contactAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _contactBtn;
}

-(UIButton *)searchBtn{
    if(!_searchBtn){
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchBtn.frame = CGRectMake(5, 15, 40, 40);
        [_searchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _contactBtn;
}

-(void)contactAction{
    if([self.delegate respondsToSelector:@selector(gotoContactView)]){
        [self.delegate gotoContactView];
    }
}

-(void)searchAction{
    [self.controller.navigationController pushViewController:nil animated:YES];
}
@end
