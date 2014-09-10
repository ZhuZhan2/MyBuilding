//
//  ContactCell.h
//  ZhuZhan
//
//  Created by Jack on 14-9-4.
//
//

#import <UIKit/UIKit.h>
#import "ContactModel.h"

@protocol  ContactCellDelegate<NSObject>

-(void)buttonClicked:(UIButton *)button;

@end

@interface ContactCell : UITableViewCell

@property (nonatomic ,weak) id<ContactCellDelegate> delegate;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithModel:(ContactModel *)model WithEmailExist:(BOOL)exist;

@end
