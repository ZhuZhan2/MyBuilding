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
#import "LoginViewController.h"
#import "LoadingView.h"
@interface PersonalDetailViewController : UITableViewController<XHPathCoverDelegate,MFMailComposeViewControllerDelegate,ContactCellDelegate,LoginViewDelegate,UIActionSheetDelegate>{
    NSMutableArray *viewArr;
    ContactBackgroundView *contactbackgroundview;
    int startIndex;
    LoadingView *loadingView;
}
@property (nonatomic,strong) NSString *contactId;
@property (nonatomic, strong) XHPathCover *pathCover;
@property (nonatomic,strong)MyCenterModel *contactModel;
@property (nonatomic,strong)ParticularsModel *parModel;
@property (nonatomic,strong)NSMutableArray *showArr;
@property (nonatomic,strong)NSString *isFocused;
@property (nonatomic,strong)NSString *isFriend;
@property(nonatomic,strong)NSString *fromViewName;
@property(nonatomic,strong)NSString *chatType;
@end
