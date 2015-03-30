//
//  ContractListCell.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/30.
//
//

#import <UIKit/UIKit.h>

@interface ContractListCell : UITableViewCell
@property(nonatomic,strong)NSArray* contents;
+(CGFloat)carculateTotalHeightWithContents:(NSArray*)contents;
@end
