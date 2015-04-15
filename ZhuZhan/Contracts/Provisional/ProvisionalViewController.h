//
//  ProvisionalViewController.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/30.
//
//

#import "CommissionBaseViewController.h"

@interface ProvisionalModel : NSObject
@property(nonatomic,strong)NSString *personaStr1;
@property(nonatomic,strong)NSString *personaStr2;
@property(nonatomic,strong)NSString *myCompanyName;
@property(nonatomic,strong)NSString *otherCompanyName;
@property(nonatomic,strong)NSString *personaName;
@property(nonatomic,strong)NSString *moneyStr;
@property(nonatomic,strong)NSString *contractStr;
@end

@interface ProvisionalViewController : CommissionBaseViewController
-(id)initWithView:(ProvisionalModel *)model;
@end
