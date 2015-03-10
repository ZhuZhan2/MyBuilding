//
//  AddressBookCell.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/9.
//
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
#import "AddressBookModel.h"
@interface AddressBookCell : UITableViewCell{
    UILabel *nameLabel;
    EGOImageView *headImage;
}
@property(nonatomic,strong)AddressBookContactModel *model;
@end
