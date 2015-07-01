//
//  ForwardListCell.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/7/1.
//
//

#import <UIKit/UIKit.h>
#import "ChatListModel.h"

@interface ForwardListCell : UITableViewCell
@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UIImageView *cutLine;
@property(nonatomic,strong)ChatListModel *model;
@end
