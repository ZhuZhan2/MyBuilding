//
//  ContactBackgroundTableViewCell.h
//  ZhuZhan
//
//  Created by 汪洋 on 14/10/28.
//
//

#import <UIKit/UIKit.h>
#import "MyCenterModel.h"
@interface ContactBackgroundTableViewCell : UITableViewCell{
    UILabel *realName;
    UILabel *sex;
    UILabel *location;
    UILabel *birthday;
    UILabel *constellation;
    UILabel *bloodType;
}
@property(nonatomic,strong)MyCenterModel *model;
@end
