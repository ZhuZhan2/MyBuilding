//
//  GetAddressBook.m
//  通讯录
//
//  Created by 汪洋 on 15/1/21.
//  Copyright (c) 2015年 wy. All rights reserved.
//

#import "GetAddressBook.h"
#import "AddressBookApi.h"
@implementation GetAddressBook
@synthesize addressBook = _addressBook;
//注册通讯录
-(void)registerAddressBook:(void (^)(bool granted, NSError *error))block{
    CFErrorRef error = NULL;
    
    _addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    ABAddressBookRequestAccessWithCompletion(_addressBook, ^(bool granted, CFErrorRef error) {
        
        if (granted) {
            //查询所有
            [self filterContentForSearchText];
            if(block){
                block(YES,nil);
            }
        }else{
            NSLog(@"asdfasdfasf");
        }
    });
}

- (void)filterContentForSearchText{
    //如果没有授权则退出
    if (ABAddressBookGetAuthorizationStatus() != kABAuthorizationStatusAuthorized) {
        return ;
    }
    CFArrayRef results = ABAddressBookCopyArrayOfAllPeople(_addressBook);
    CFMutableArrayRef mresults=CFArrayCreateMutableCopy(kCFAllocatorDefault,
                                                        CFArrayGetCount(results),
                                                        results);
    //将结果按照拼音排序，将结果放入mresults数组中
    CFArraySortValues(mresults,
                      CFRangeMake(0, CFArrayGetCount(results)),
                      (CFComparatorFunction) ABPersonComparePeopleByName,
                      (void*) ABPersonGetSortOrdering());
    
    [self getNameAndPhone:mresults];
}

//-(void)sendAddressBook:(NSMutableArray*)array{
//    [AddressBookApi ContactsAddWithBlock:^(NSMutableArray *posts, NSError *error) {
//        if (!error) {
//            
//        }
//    } arr:array noNetWork:nil];
//}

//获取联系人名字电话
-(void)getNameAndPhone:(CFMutableArrayRef)mresults{
    NSMutableArray *allArr = [[NSMutableArray alloc] init];
    //遍历所有联系人
    for (int k=0;k<CFArrayGetCount(mresults);k++) {
        ABRecordRef tempRecord=CFArrayGetValueAtIndex(mresults,k) ;
        NSMutableDictionary* singleDataDic=[NSMutableDictionary dictionary];
        NSObject* baseInformation=[self getBaseInformationDicValueWithRecord:tempRecord];
       // NSObject* birthday=[self getBirthdayDicValueWithRecord:tempRecord];
       // NSObject* addresses=[self getAddressesDicValueWithRecord:tempRecord];
        NSObject* cellPhones=[self getCellPhonesDicValueWithRecord:tempRecord];
       // NSObject* emails=[self getEmailsDicValueWithRecord:tempRecord];
       // NSObject* ims=[self getImsDicValueWithRecord:tempRecord];
        [singleDataDic setObject:baseInformation forKey:@"baseInformation"];
//        [singleDataDic setObject:birthday forKey:@"birthday"];
//        [singleDataDic setObject:addresses forKey:@"addresses"];
        [singleDataDic setObject:cellPhones forKey:@"cellPhones"];
//        [singleDataDic setObject:emails forKey:@"emails"];
//        [singleDataDic setObject:ims forKey:@"ims"];
        [allArr addObject:singleDataDic];
    }
    //[self sendAddressBook:allArr];
    self.phones=allArr;
   // NSLog(@"内部phones=%@",self.phones);
}

-(NSObject*)getBaseInformationDicValueWithRecord:(ABRecordRef)record{
    NSDictionary* hasDataKeyDic=
    @{
      @"lastName":@(kABPersonLastNameProperty),
      @"middleName":@(kABPersonMiddleNameProperty),
      @"firstName":@(kABPersonFirstNameProperty),
      @"alias":@(kABPersonNicknameProperty),
      @"companyName":@(kABPersonOrganizationProperty),
      @"duties":@(kABPersonJobTitleProperty),
      @"prefixion":@(kABPersonPrefixProperty),
      @"suffix":@(kABPersonSuffixProperty),
      @"firstNamePinyin":@(kABPersonFirstNamePhoneticProperty),
      @"lastNamePinyin":@(kABPersonLastNamePhoneticProperty)
      };
    NSArray* noDataKeys=
    @[
      @"fullName",
      @"fullNamePinyin",
      @"remark"
      ];
    NSMutableDictionary* dataDic=[NSMutableDictionary dictionary];
    [hasDataKeyDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        CFTypeRef object=ABRecordCopyValue(record, [obj intValue]);
        NSString* string=(__bridge NSString*)object;
        if (!string) {
            string=@"";
        }
        [dataDic setObject:string forKey:key];
    }];
    [noDataKeys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [dataDic setObject:@"" forKey:obj];
    }];
    NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];
    [dataDic setObject:identifierForVendor forKey:@"createdBy"];
    return dataDic;
}

-(NSObject*)getBirthdayDicValueWithRecord:(ABRecordRef)record{
    return @[[self getSingleBirthdayDicValueWithRecord:record]];
}

-(NSObject*)getSingleBirthdayDicValueWithRecord:(ABRecordRef)record{
    NSDictionary* hasDataKeyDic=
    @{
      };
    NSDictionary* dateData=
    @{
      @"birthdayDate":@(kABPersonBirthdayProperty)
      };
    NSArray* noDataKeys=
    @[
      @"tagName"
      ];
    NSMutableDictionary* dataDic=[NSMutableDictionary dictionary];
    [dateData enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        CFTypeRef object=ABRecordCopyValue(record, [obj intValue]);
        NSDate* date=(__bridge NSDate*)object;
        NSDateFormatter* formatter=[[NSDateFormatter alloc]init];
        formatter.dateFormat=@"yyyy-MM-dd";
        NSString* dateStr=[formatter stringFromDate:date];
        if (!dateStr) {
            dateStr=@"";
        }
        [dataDic setObject:dateStr forKeyedSubscript:key];
    }];
    [noDataKeys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [dataDic setObject:@"" forKey:obj];
    }];
    return dataDic;
}

-(NSObject*)getAddressesDicValueWithRecord:(ABRecordRef)record{
    ABMultiValueRef address = ABRecordCopyValue(record, kABPersonAddressProperty);
    long count = ABMultiValueGetCount(address);
    NSMutableArray *addressArr = [[NSMutableArray alloc] init];
    for(int j = 0; j < count; j++)
    {
        NSMutableDictionary *addressDic = [[NSMutableDictionary alloc] init];
        //获取地址Label
        NSString* addressLabel = (__bridge NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(address, j));
        if (!addressLabel) {
            addressLabel=@"";
        }
        [addressDic setObject:addressLabel forKey:@"tagName"];
        
        //获取該label下的地址6属性
        NSDictionary* personaddress =(__bridge NSDictionary*) ABMultiValueCopyValueAtIndex(address, j);
//        NSString* country = [personaddress valueForKey:(NSString *)kABPersonAddressCountryKey];
//        if(country != nil){
//            [addressDic setObject:country forKey:@"country"];
//        }else{
//            [addressDic setObject:@"" forKey:@"country"];
//        }
//        
//        NSString* city = [personaddress valueForKey:(NSString *)kABPersonAddressCityKey];
//        if(city != nil){
//            [addressDic setObject:city forKey:@"city"];
//        }else{
//            [addressDic setObject:@"" forKey:@"city"];
//        }

        NSString* street = [personaddress valueForKey:(NSString *)kABPersonAddressStreetKey];
        if(street != nil){
            [addressDic setObject:street forKey:@"details"];
        }else{
            [addressDic setObject:@"" forKey:@"details"];
        }
        
//        NSString* zipcode = [personaddress valueForKey:(NSString *)kABPersonAddressZIPKey];
//        if(zipcode != nil){
//            [addressDic setObject:zipcode forKey:@"postCode"];
//        }else{
//            [addressDic setObject:@"" forKey:@"postCode"];
//        }
        
        [addressArr addObject:addressDic];
    }
    return addressArr;
}

-(NSObject*)getCellPhonesDicValueWithRecord:(ABRecordRef)record{
    ABMultiValueRef phone = ABRecordCopyValue(record, kABPersonPhoneProperty);
    NSMutableArray *phoneArr = [[NSMutableArray alloc] init];
    for(NSInteger j = 0; j < ABMultiValueGetCount(phone); j++){
        
        //获取电话Label
        NSString * personPhoneLabel = (__bridge NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(phone, j));
        NSString* tmpPhoneIndex = (__bridge NSString*)ABMultiValueCopyValueAtIndex(phone, j);
        if (!personPhoneLabel) {
            personPhoneLabel=@"";
        }
        if (!tmpPhoneIndex) {
            tmpPhoneIndex=@"";
        }
        NSMutableDictionary *phoneDic = [[NSMutableDictionary alloc] init];
        NSMutableString* str=[tmpPhoneIndex mutableCopy];
        while ([str rangeOfString:@"-"].length) {
            [str deleteCharactersInRange:[str rangeOfString:@"-"]];
        }
        while ([str rangeOfString:@" "].length) {
            [str deleteCharactersInRange:[str rangeOfString:@" "]];
        }
        [phoneDic setValue:str forKey:@"phoneNumber"];
        [phoneDic setValue:personPhoneLabel forKey:@"tagName"];
        [phoneArr addObject:phoneDic];
    }
    return phoneArr;
}

-(NSObject*)getEmailsDicValueWithRecord:(ABRecordRef)record{
    NSMutableArray *emailArr = [[NSMutableArray alloc] init];
    ABMultiValueRef tmpEmails = ABRecordCopyValue(record, kABPersonEmailProperty);
    for(NSInteger j = 0; j<ABMultiValueGetCount(tmpEmails); j++){
        NSString * personEmailLabel = (__bridge NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(tmpEmails, j));
        if (!personEmailLabel) {
            personEmailLabel=@"";
        }
        NSString* tmpEmailIndex = (__bridge NSString*)ABMultiValueCopyValueAtIndex(tmpEmails, j);
        if (!tmpEmailIndex) {
            tmpEmailIndex=@"";
        }
        NSMutableDictionary *emailDic = [[NSMutableDictionary alloc] init];
        [emailDic setValue:tmpEmailIndex forKey:@"emailAddress"];
        [emailDic setValue:personEmailLabel forKey:@"tagName"];
        [emailArr addObject:emailDic];
    }
    return emailArr;
}

-(NSObject*)getImsDicValueWithRecord:(ABRecordRef)record{
    //获取IM多值
    NSMutableArray *IMArr = [[NSMutableArray alloc] init];
    ABMultiValueRef instantMessage = ABRecordCopyValue(record, kABPersonInstantMessageProperty);
    for (int l = 0; l < ABMultiValueGetCount(instantMessage); l++)
    {
        //获取IM Label
        NSString* instantMessageLabel = (__bridge NSString*)ABMultiValueCopyLabelAtIndex(instantMessage, l);
        //获取該label下的2属性
        NSDictionary* instantMessageContent =(__bridge NSDictionary*) ABMultiValueCopyValueAtIndex(instantMessage, l);
        NSString* IMName = [instantMessageContent valueForKey:(NSString *)kABPersonInstantMessageUsernameKey];
        NSMutableDictionary *IMDic = [[NSMutableDictionary alloc] init];
        if(IMName != nil){
            [IMDic setValue:IMName forKey:@"information"];
        }else{
            [IMDic setValue:@"" forKey:@"information"];
        }
        NSString* service = [instantMessageContent valueForKey:(NSString *)kABPersonInstantMessageServiceKey];
        if(service != nil){
            [IMDic setValue:service forKey:@"tagName"];
        }else{
            [IMDic setValue:@"" forKey:@"tagName"];
        }
        [IMArr addObject:IMDic];
    }
    return IMArr;
}
@end
