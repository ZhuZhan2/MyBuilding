//
//  CommonCell.h
//  ZhuZhan
//
//  Created by Jack on 14-9-4.
//
//

#import <UIKit/UIKit.h>
#import "projectModel.h"
#import "ContactCell.h"
@interface CommonCell : UITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithModel:(projectModel *)proModel WithIndex:(int)index WithContactModel:(ContactModel *)model;

@end
