//
//  ContactsActiveCell.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/1.
//
//

#import "BaseTableViewCell.h"
#import "ContactsActiveCellModel.h"

@interface ContactsActiveCell :BaseTableViewCell
@property (nonatomic, strong)ContactsActiveCellModel* model;
+ (CGFloat)carculateCellHeightWithModel:(ContactsActiveCellModel *)cellModel;
@end
