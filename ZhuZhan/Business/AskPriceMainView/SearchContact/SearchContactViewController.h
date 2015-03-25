//
//  SearchContactViewController.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/19.
//
//

#import <UIKit/UIKit.h>
#import "UserOrCompanyModel.h"
@protocol SearchContactViewDelegate <NSObject>
-(void)selectContact:(UserOrCompanyModel *)model;
@end

@interface SearchContactViewController : UIViewController
@property(nonatomic,weak)id<SearchContactViewDelegate>delegate;
@end
