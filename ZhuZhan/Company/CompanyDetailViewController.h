//
//  CompanyDetailViewController.h
//  ZhuZhan
//
//  Created by 孙元侃 on 14-9-9.
//
//
#import "ChatBaseViewController.h"
#import "CompanyModel.h"
@protocol CompanyDetailDelegate <NSObject>

-(void)gotoCompanyDetail:(BOOL)needAnimation;

@end
@interface CompanyDetailViewController : ChatBaseViewController
@property(nonatomic,copy)NSString* companyId;
@property(nonatomic,weak)id<CompanyDetailDelegate>delegate;
@end
