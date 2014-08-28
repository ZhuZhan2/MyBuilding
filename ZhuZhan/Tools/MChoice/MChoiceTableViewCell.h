//
//  MChoiceTableViewCell.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-27.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MChoiceTableViewCell : UITableViewCell{
    UIImageView*	m_checkImageView;
	BOOL			m_checked;
}
- (void) setChecked:(BOOL)checked;
@end
