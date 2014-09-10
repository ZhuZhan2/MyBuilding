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
#import "CompanyCell.h"
#import "ContactCell.h"
#import "ContactModel.h"
#import "projectModel.h"
@interface PersonalDetailViewController : UITableViewController<XHPathCoverDelegate,MFMailComposeViewControllerDelegate,ContactCellDelegate,CorrelateCellDelegate>

@property (nonatomic, strong) XHPathCover *pathCover;
@property (nonatomic,strong) ContactModel *contactModel;
@property (nonatomic,strong) projectModel *proModel;//项目model  
@end
