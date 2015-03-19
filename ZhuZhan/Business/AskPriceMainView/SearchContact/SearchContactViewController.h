//
//  SearchContactViewController.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/19.
//
//

#import <UIKit/UIKit.h>
@protocol SearchContactViewDelegate <NSObject>
-(void)selectContact:(NSString *)str;
@end

@interface SearchContactViewController : UIViewController
@property(nonatomic,weak)id<SearchContactViewDelegate>delegate;
@end
