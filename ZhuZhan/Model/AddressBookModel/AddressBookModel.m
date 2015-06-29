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
    self.a_id = dict[@"groupId"];
    self.a_name = dict[@"groupName"];
    self.a_count = dict[@"counts"];
    self.a_type = dict[@"groupType"];
    self.contactArr = [[NSMutableArray alloc] init];
}
@end

@implementation AddressBookContactModel
-(void)setDict:(NSDictionary *)dict{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    _dict = dict;
    self.a_contactId = dict[@"loginId"];
    self.a_loginName = dict[@"loginName"];
    if(![dict[@"imageId"] isEqualToString:@""]){
        self.a_avatarUrl = [NSString stringWithFormat:@"%@%@",[userDefaults objectForKey:@"serverAddress"],image(dict[@"imageId"], @"login", @"", @"", @"")];
    }else{
        self.a_avatarUrl = dict[@"imageId"];
    }
    self.a_nickName = dict[@"nickName"];
    self.a_realName = dict[@"realName"];
}
@end