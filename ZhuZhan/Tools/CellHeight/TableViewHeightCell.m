//
//  TableViewHeightCell.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/4/17.
//
//

#import "TableViewHeightCell.h"

@implementation TableViewHeightCell
+ (void)initialize {
    // Create array
    cellArray = [NSMutableArray array];
}

+ (CGSize)sizeForCellWithDefaultSize:(CGSize)defaultSize setupCellBlock:(setupCellBlock)block {
    __block UITableViewCell *cell = nil;
    [cellArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[[self class] class]]) {
            cell = obj;
            *stop = YES;
        }
    }];
    
    if (!cell) {
        cell = [[[self class] alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tableViewCell"];
        cell.frame = CGRectMake(0, 0, defaultSize.width, defaultSize.height);
        [cellArray addObject:cell];
    }
    cell = block((id<CellHeightDelegate>)cell);
    CGSize size = cell.frame.size;
    size.width = MAX(defaultSize.width, size.width);
    return size;
}
@end
