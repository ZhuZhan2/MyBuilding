//
//  PostAddressBook.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/5/7.
//
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
@interface PostAddressBook : NSObject
@property (nonatomic) ABAddressBookRef addressBook;
-(void)registerAddressBook:(void (^)(bool granted, NSError *error))block;
@end
