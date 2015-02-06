//
//  ProjectTableViewCell.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-26.
//
//

#import <UIKit/UIKit.h>
#import "projectModel.h"
#import "EGOImageView.h"
@protocol ProjectTableViewCellDelegate <NSObject>

-(void)addProjectCommentView:(int)index;

@end
@interface ProjectTableViewCell : UITableViewCell<EGOImageViewDelegate>{
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
    UILabel *zoneLabel;
    EGOImageView *bigImage;
    float imageHight;
    float imageWidth;
    int flag;
}
@property(nonatomic,weak)projectModel *model;
@property(nonatomic,weak)id<ProjectTableViewCellDelegate>delegate;
@property(nonatomic)int indexRow;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier model:(projectModel *)model fromView:(NSString *)fromView;
@end
