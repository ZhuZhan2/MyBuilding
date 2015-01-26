//
//  CorrelateCell.h
//  ZhuZhan
//
//  Created by Jack on 14-9-4.
//
//

#import <UIKit/UIKit.h>
#import "projectModel.h"
@interface CorrelateCell : UITableViewCell{
    NSString *stage;
    UIImageView *imageView;
    UILabel *ProjectLabel;
    UILabel *addressLabel;
    UILabel *zoneLabel;
}
@property(nonatomic,strong)projectModel *model;
@end
