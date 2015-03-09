//
//  AddressBookModel.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/9.
//
//

#import "AddressBookModel.h"

@implementation AddressBookModel
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.a_id = dict[@"id"];
    self.a_name = dict[@"name"];
    self.contactArr = [[NSMutableArray alloc] init];
}
@end

@implementation AddressBookContactModel
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.a_contactId = dict[@"id"];
    self.a_contactName = dict[@"name"];
    self.a_avatarUrl = dict[@"head"];
}
@end