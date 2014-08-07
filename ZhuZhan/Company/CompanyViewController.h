//
//  CompanyViewController.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-5.
//  Copyright (c) 2014年 zpzchina. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol companyViewDelegate <NSObject>

-(void)companyDidNext;
-(void)companyWillBack;
@end
@interface CompanyViewController : UIViewController
@property(nonatomic,strong)id<companyViewDelegate>delegate;
@end