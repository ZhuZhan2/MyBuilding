//
//  AskPriceViewCell.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/17.
//
//

#import <UIKit/UIKit.h>
#import "AskPriceModel.h"
@interface AskPriceViewCell : UITableViewCell
@property(nonatomic,strong)NSArray* contents;
+(CGFloat)carculateTotalHeightWithContents:(NSArray*)contents;
@end
