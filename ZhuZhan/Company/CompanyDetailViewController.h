//
//  CompanyDetailViewController.h
//  ZhuZhan
//
//  Created by 孙元侃 on 14-9-9.
//
//

#import <UIKit/UIKit.h>
#import "CompanyModel.h"
@protocol CompanyDetailDelegate <NSObject>

-(void)gotoCompanyDetail:(BOOL)needAnimation;

@end
@interface CompanyDetailViewController : UIViewController
@property(nonatomic,strong)NSString *companyId;
@property(nonatomic,weak)id<CompanyDetailDelegate>delegate;
@end
