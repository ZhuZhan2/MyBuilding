//
//  AddressBookModel.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/9.
//
//

#import <Foundation/Foundation.h>
//分组的model
@interface AddressBookModel : NSObject
//分组id
@property(nonatomic,strong)NSString *a_id;
//分组名
@property(nonatomic,strong)NSString *a_name;
//分组里的人
@property(nonatomic,strong)NSMutableArray *contactArr;

@property(nonatomic,strong)NSDictionary *dict;
@end

//分组里的人的model
@interface AddressBookContactModel : NSObject
//人的id
@property(nonatomic,strong)NSString *a_contactId;
//人的名字
@property(nonatomic,strong)NSString *a_contactName;
//头像
@property(nonatomic,strong)NSString *a_avatarUrl;
@property(nonatomic,strong)NSDictionary *dict;
@end