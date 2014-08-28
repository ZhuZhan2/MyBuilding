//
//  AccountImgCell.h
//  PersonalCenter
//
//  Created by Jack on 14-8-19.
//  Copyright (c) 2014年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadioButton.h"
@interface AccountImgCell : UITableViewCell<UITextFieldDelegate,RadioButtonDelegate>

@property (nonatomic,strong) UIImageView *bgImgview;
@property (nonatomic,strong) UIImageView *userIcon;
@property (nonatomic,strong) UILabel *userLabel;
@property (nonatomic,strong) UILabel *companyLabel;
//@property (nonatomic,strong) UILabel *positionLabel;

@end
