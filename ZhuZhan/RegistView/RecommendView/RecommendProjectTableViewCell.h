//
//  RecommendProjectTableViewCell.h
//  ZhuZhan
//
//  Created by 汪洋 on 14/12/18.
//
//

#import <UIKit/UIKit.h>
#import "projectModel.h"

@protocol RecommendProjectTableViewCellDelegate <NSObject>

-(void)attentionProject:(NSString *)projectId;

@end
@interface RecommendProjectTableViewCell : UITableViewCell{
    UIImageView *stageImage;
    UILabel *startDate;
    UILabel *endDate;
    UILabel *projectName;
    UILabel *area;
    UILabel *investment;
    UILabel *zone;
    UILabel *address;
    UIButton *attentionBtn;
    NSString *projectId;
    int isFocused;
}
@property(nonatomic,strong)projectModel *model;
@property(nonatomic,weak)id<RecommendProjectTableViewCellDelegate>delegate;
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
