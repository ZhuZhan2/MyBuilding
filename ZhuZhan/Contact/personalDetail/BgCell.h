//
//  BgCell.h
//  ZhuZhan
//
//  Created by Jack on 14-9-4.
//
//

#import <UIKit/UIKit.h>
#import "AutoChangeTextView.h"
#import "ContactModel.h"

@interface BgCell : UITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithTextHeight:(float)height WithModel:(ContactModel *)model;

@end
