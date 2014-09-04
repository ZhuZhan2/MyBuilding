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
@interface PersonalDetailViewController : UITableViewController<XHPathCoverDelegate,MFMailComposeViewControllerDelegate>

@property (nonatomic,strong) NSArray *contactArr;
@property (nonatomic,strong) NSArray *kImgArr;
@property (nonatomic, strong) XHPathCover *pathCover;
@property (nonatomic) float textViewHeight;
@property (nonatomic,strong) NSArray *titleArr;


@end
