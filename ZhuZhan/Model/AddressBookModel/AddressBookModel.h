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
//分组里人的数量
@property(nonatomic,strong)NSString *a_count;
//分组类型
@property(nonatomic,strong)NSString *a_type;
//分组里的人
@property(nonatomic,strong)NSMutableArray *contactArr;

@property(nonatomic,strong)NSDictionary *dict;
@end

//分组里的人的model
@interface AddressBookContactModel : NSObject
//人的id
@property(nonatomic,strong)NSString *a_contactId;
//人的名字
@property(nonatomic,strong)NSString *a_loginName;
//昵称
@property(nonatomic,strong)NSString *a_nickName;
//真是姓名
@property(nonatomic,strong)NSString *a_realName;
//头像
@property(nonatomic,strong)NSString *a_avatarUrl;
@property(nonatomic,strong)NSDictionary *dict;
@end