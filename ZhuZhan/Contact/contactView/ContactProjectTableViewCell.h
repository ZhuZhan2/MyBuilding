//
//  ContactProjectTableViewCell.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-2.
//
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
#import "HeadImageDelegate.h"
#import "ActivesModel.h"
@interface ContactProjectTableViewCell : UITableViewCell{
    EGOImageView *headImageView;
    UIImageView *stageImage;
    UILabel *titleLabel;
    UILabel *contentLabel;
}
@property(nonatomic,weak)id<HeadImageDelegate>delegate;
@property(nonatomic,strong)ActivesModel *model;
@end
