//
//  ProjectTableViewCell.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-26.
//
//

#import <UIKit/UIKit.h>
#import "projectModel.h"

@protocol ProjectTableViewCellDelegate <NSObject>

-(void)addProjectCommentView:(int)index;

@end
@interface ProjectTableViewCell : UITableViewCell{
    NSString *stage;
    UILabel *nameLabel;
    UILabel *investmentLabel;
    UILabel *investmentcountLabel;
    UILabel *areaLabel;
    UILabel *areacountLabel;
    UIImageView *progressImage;
    UILabel *startdateLabel;
    UILabel *enddateLabel;
    UILabel *addressLabel;
    int flag;
    int indexRow;
}
@property(nonatomic,weak)projectModel *model;
@property(nonatomic,weak)id<ProjectTableViewCellDelegate>delegate;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier model:(projectModel *)model fromView:(NSString *)fromView index:(int)index;
@end
