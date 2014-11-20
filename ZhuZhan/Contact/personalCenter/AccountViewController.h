//
//  AccountViewController.h
//  PersonalCenter
//
//  Created by Jack on 14-8-19.
//  Copyright (c) 2014年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHPathCover.h"
#import "AccountCell.h"
#import "Camera.h"

@interface AccountViewController : UIViewController<XHPathCoverDelegate,UIActionSheetDelegate,UITextFieldDelegate,AccountCellDelegate,CameraDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) XHPathCover *pathCover;
@property(nonatomic,strong)UITableView* tableView;
@property (nonatomic, strong) UIImage *userIcon;
@property (nonatomic, strong) ContactModel *model;
@property (nonatomic, strong) Camera *camera;
@property (nonatomic, strong) NSString *userIdStr;
@end
