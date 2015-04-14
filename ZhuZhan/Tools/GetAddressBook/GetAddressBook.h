//
//  GetAddressBook.h
//  通讯录
//
//  Created by 汪洋 on 15/1/21.
//  Copyright (c) 2015年 wy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
@interface GetAddressBook : NSObject
@property (nonatomic) ABAddressBookRef addressBook;
-(void)registerAddressBook:(void (^)(bool granted, NSError *error))block;
@property (nonatomic, strong)NSMutableArray* phones;
@end
