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
#import "CorrelateCell.h"
#import "CompanyCell.h"
#import "ContactCell.h"
#import "ContactModel.h"
#import "projectModel.h"
#import "MyCenterModel.h"
#import "ContactBackgroundTableViewCell.h"
#import "ParticularsModel.h"
#import "ContactBackgroundView.h"
@interface PersonalDetailViewController : UITableViewController<XHPathCoverDelegate,MFMailComposeViewControllerDelegate,ContactCellDelegate>{
    NSMutableArray *viewArr;
    ContactBackgroundView *contactbackgroundview;
}
@property (nonatomic,strong) NSString *contactId;
@property (nonatomic, strong) XHPathCover *pathCover;
@property (nonatomic,strong)MyCenterModel *contactModel;
@property (nonatomic,strong)ParticularsModel *parModel;
@property (nonatomic,strong)NSMutableArray *showArr;
@end
