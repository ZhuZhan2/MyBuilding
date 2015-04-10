//
//  AddressBookNickNameViewController.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/4/9.
//
//

#import "ChatBaseViewController.h"

@protocol AddressBookNickNameViewControllerDelegate <NSObject>
-(void)addressBookNickNameViewControllerFinish;
@end

@interface AddressBookNickNameViewController : ChatBaseViewController
@property (nonatomic, copy)NSString* targetId;
@property (nonatomic, weak)id<AddressBookNickNameViewControllerDelegate> delegate;
@end
