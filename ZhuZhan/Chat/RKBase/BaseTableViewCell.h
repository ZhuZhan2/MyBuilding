//
//  BaseTableViewCell.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/5/29.
//
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCellModel.h"
@interface BaseTableViewCell : UITableViewCell

/**********************************************************
 函数描述：根据cellModel返回cell的高度
 **********************************************************/
+ (CGFloat)carculateCellHeightWithModel:(BaseTableViewCellModel*)cellModel;

//cell上的内容
@property(nonatomic,strong)BaseTableViewCellModel* model;
@end
