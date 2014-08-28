//
//  NIDropDown.h
//  NIDropDown
//
//  Created by Bijesh N on 12/28/12.
//  Copyright (c) 2012 Nitor Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NIDropDown;
@protocol NIDropDownDelegate
- (void) niDropDownDelegateMethod: (NIDropDown *) sender text:(NSString *)text tit:(NSString *)tit;
@end 

@interface NIDropDown : UIView <UITableViewDelegate, UITableViewDataSource>{
    NSString *str;
    NSString *title;
}

@property (nonatomic, retain) id <NIDropDownDelegate> delegate;

-(void)hideDropDown:(UIButton *)b;
-(id)initWithFrame:(UIButton *)b arr:(NSArray *)arr tit:(NSString *)tit;
@end
