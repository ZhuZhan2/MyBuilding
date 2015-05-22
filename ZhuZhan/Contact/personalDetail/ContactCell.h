//
//  ContactCell.h
//  ZhuZhan
//
//  Created by Jack on 14-9-4.
//
//

#import <UIKit/UIKit.h>
#import "ContactModel.h"
#import "MyCenterModel.h"
@interface ContactCell : UITableViewCell
@property(nonatomic,strong)MyCenterModel *model;
@property(nonatomic,strong)UILabel *phone;
@property(nonatomic,strong)UILabel *email;
@property(nonatomic,strong)UILabel *phoneTitle;
@property(nonatomic,strong)UILabel *emailTitle;
@property(nonatomic,strong)UIView *topBgView;
@property(nonatomic,strong)UIImageView *topLineImage;
@property(nonatomic,strong)UIImageView *topImgaeView;
@property(nonatomic,strong)UIImageView *cutLine;
@end
