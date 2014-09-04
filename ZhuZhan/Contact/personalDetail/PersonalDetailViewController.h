//
//  PersonalDetailViewController.h
//  ZhuZhan
//
//  Created by Jack on 14-8-27.
//
//

#import <UIKit/UIKit.h>
#import "XHPathCover.h"
#import <MessageUI/MessageUI.h>
#import "BgCell.h"
#import "CorrelateCell.h"
#import "ContactModel.h"
@interface PersonalDetailViewController : UITableViewController<XHPathCoverDelegate,MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) XHPathCover *pathCover;
@property (nonatomic,strong) ContactModel *model;

@end
