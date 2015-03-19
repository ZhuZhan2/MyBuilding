//
//  SearchCategoryViewController.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/19.
//
//

#import <UIKit/UIKit.h>
@protocol SearchCategoryViewDelegate <NSObject>
-(void)selectCategory:(NSString *)str;
@end

@interface SearchCategoryViewController : UIViewController
@property(nonatomic,weak)id<SearchCategoryViewDelegate>delegate;
@end
