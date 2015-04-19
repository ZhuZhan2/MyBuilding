//
//  CellHeightDelegate.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/4/17.
//
//

#import <Foundation/Foundation.h>
@protocol CellHeightDelegate;
static NSMutableArray *cellArray;
typedef id (^setupCellBlock)(id<CellHeightDelegate> cellToSetup);
@protocol CellHeightDelegate <NSObject>
+ (CGSize)sizeForCellWithDefaultSize:(CGSize)defaultSize setupCellBlock:(setupCellBlock)block;
@end
