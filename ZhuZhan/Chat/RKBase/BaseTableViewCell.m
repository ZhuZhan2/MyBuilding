//
//  BaseTableViewCell.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/5/29.
//
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell
/**********************************************************
 函数描述：根据cellModel返回cell的高度
 **********************************************************/
+ (CGFloat)carculateCellHeightWithModel:(BaseTableViewCellModel *)cellModel{
    return 44;
}
@end
