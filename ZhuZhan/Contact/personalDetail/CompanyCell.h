//
//  CompanyCell.h
//  ZhuZhan
//
//  Created by Jack on 14-9-4.
//
//

#import <UIKit/UIKit.h>
#import "ContactCell.h"
@interface CompanyCell : UITableViewCell{
    UILabel *companyLabel;
    UILabel *positionLabel;
}
@property(nonatomic,strong)NSString *companyStr;
@property(nonatomic,strong)NSString *positionStr;
@end
