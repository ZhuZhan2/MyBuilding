//
//  ConditionsView.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-1.
//
//

#import <UIKit/UIKit.h>
#import "ConditionsModel.h"
@interface ConditionsView : UIView

@property (nonatomic,strong)NSMutableDictionary *dataDic;
+(ConditionsView *)setFram:(ConditionsModel *)model;

@end
