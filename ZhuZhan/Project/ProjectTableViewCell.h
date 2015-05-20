//
//  ProjectTableViewCell.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-26.
//
//

#import <UIKit/UIKit.h>
#import "projectModel.h"

@interface ProjectTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *topImageView;
@property(nonatomic,strong)UIImageView *topContentImageView;
@property(nonatomic,strong)UILabel *stageLabel;
@property(nonatomic,strong)UILabel *detailLabel;
@property(nonatomic,strong)UIImageView *arrowImageView;
@property(nonatomic,strong)UIButton *detailBtn;
@property(nonatomic,strong)UIImageView *cutLine;
@property(nonatomic,strong)UIImageView *contentImageView;
@property(nonatomic,strong)UILabel *projectName;
@property(nonatomic,strong)UILabel *projectAddress;
@property(nonatomic,strong)UILabel *projectInvestment;
@property(nonatomic,strong)UILabel *projectArea;
@property(nonatomic,strong)projectModel *model;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,strong)NSString *projectNameString;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
