//
//  CorrelateCell.h
//  ZhuZhan
//
//  Created by Jack on 14-9-4.
//
//

#import <UIKit/UIKit.h>
#import "projectModel.h"

@protocol  CorrelateCellDelegate<NSObject>

-(void)buttonClicked:(UIButton *)button;

@end


@interface CorrelateCell : UITableViewCell

@property (nonatomic ,weak) id<CorrelateCellDelegate> delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithModel:(projectModel*)model;
@end
