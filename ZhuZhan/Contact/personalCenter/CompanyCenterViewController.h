//
//  CompanyCenterViewController.h
//  ZhuZhan
//
//  Created by 汪洋 on 14/11/4.
//
//

#import <UIKit/UIKit.h>
#import "XHPathCover.h"
#import "CompanyTableViewCell.h"
#import "CompanyModel.h"
@interface CompanyCenterViewController : UIViewController<XHPathCoverDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,CompanyTableViewCellDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) XHPathCover *pathCover;
@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)NSMutableDictionary *dataDic;
@property(nonatomic,strong)CompanyModel *model;
@end
