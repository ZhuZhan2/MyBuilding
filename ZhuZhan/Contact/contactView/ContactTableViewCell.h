//
//  ContactTableViewCell.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-3.
//
//

#import <UIKit/UIKit.h>
#import "ActivesModel.h"
#import "HeadImageDelegate.h"
@interface ContactTableViewCell : UITableViewCell{
    UIImageView *headImageView;
    UIImageView *stageImage;
    UILabel *titleLabel;
    UILabel *nameLabel;
    UILabel *jobLabel;
    NSIndexPath *indexpath;
}
@property(nonatomic,weak)ActivesModel *model;
@property(nonatomic,weak)id<HeadImageDelegate>delegate;
@property(nonatomic,strong)NSIndexPath *indexpath;
@end
