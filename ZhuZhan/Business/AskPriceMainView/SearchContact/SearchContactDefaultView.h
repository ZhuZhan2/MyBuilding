//
//  SearchContactDefaultView.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/5/27.
//
//

#import <UIKit/UIKit.h>
#import "UserOrCompanyModel.h"

@protocol SearchContactDefaultViewDelegate <NSObject>
-(void)selectContact:(UserOrCompanyModel *)model;
@end

@interface SearchContactDefaultView : UIView
@property(nonatomic,weak)id<SearchContactDefaultViewDelegate>delegate;
-(instancetype)initWithFrame:(CGRect)frame;
@end
