//
//  ContactProjectTableViewCell.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-2.
//
//

#import <UIKit/UIKit.h>
#import "HeadImageDelegate.h"
#import "ActivesModel.h"
@interface ContactProjectTableViewCell : UITableViewCell{
    UIImageView *headImageView;
    UIImageView *stageImage;
    UILabel *titleLabel;
    UILabel *contentLabel;
    NSIndexPath *indexpath;
}
@property(nonatomic,weak)id<HeadImageDelegate>delegate;
@property(nonatomic,strong)ActivesModel *model;
@property(nonatomic,strong)NSIndexPath *indexpath;
@end
