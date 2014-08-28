//
//  PersonalDetailViewController.h
//  ZhuZhan
//
//  Created by Jack on 14-8-27.
//
//

#import <UIKit/UIKit.h>
#import "XHPathCover.h"
@interface PersonalDetailViewController : UITableViewController<XHPathCoverDelegate>

@property (nonatomic,strong) NSArray *KindIndex;
@property (nonatomic,strong) NSArray *kImgArr;
@property (nonatomic, strong) XHPathCover *pathCover;

@end
