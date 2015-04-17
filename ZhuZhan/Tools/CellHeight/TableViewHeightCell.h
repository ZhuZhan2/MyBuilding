//
//  TableViewHeightCell.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/4/17.
//
//

#import <UIKit/UIKit.h>
#import "CellHeightDelegate.h"
#define DEFAULT_CELL_SIZE (CGSize){[[UIScreen mainScreen] bounds].size.width, 44}
@interface TableViewHeightCell : UITableViewCell<CellHeightDelegate>

@end
