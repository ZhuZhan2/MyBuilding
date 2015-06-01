//
//  ProjectTableViewCell.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-26.
//
//

#import <UIKit/UIKit.h>
#import "projectModel.h"
#import "TableViewHeightCell.h"

@protocol ProjectTableViewCellDelegate <NSObject>
-(void)gotoLoginView;
-(void)addFocused:(NSIndexPath *)indexPath;
@end

@interface ProjectTableViewCell : TableViewHeightCell
@property(nonatomic,strong)UIImageView *topImageView;
@property(nonatomic,strong)UIImageView *topContentImageView;
@property(nonatomic,strong)UILabel *stageLabel;
@property(nonatomic,strong)UIButton *focusBtn;
@property(nonatomic,strong)UIImageView *cutLine;
@property(nonatomic,strong)UIImageView *contentImageView;
@property(nonatomic,strong)UILabel *projectName;
@property(nonatomic,strong)UILabel *projectAddress;
@property(nonatomic,strong)UILabel *projectInvestment;
@property(nonatomic,strong)UILabel *projectArea;
@property(nonatomic,strong)UILabel *projectInvestmentCount;
@property(nonatomic,strong)UILabel *projectAreaCount;
@property(nonatomic,strong)UIImageView *mapImageVIew;
@property(nonatomic,strong)UILabel *lastUpdatedTime;
@property(nonatomic,strong)UILabel *lastUpdatedTimeCount;
@property(nonatomic,strong)UIImageView *bottomImageView;
@property(nonatomic,strong)NSString *isFocused;
@property(nonatomic,strong)NSString *projectID;
@property(nonatomic,strong)projectModel *model;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,weak)id<ProjectTableViewCellDelegate>delegate;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
