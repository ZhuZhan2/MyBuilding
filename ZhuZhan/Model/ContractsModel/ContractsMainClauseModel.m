//
//  ContractsMainClauseModel.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/4/20.
//
//

#import "ContractsMainClauseModel.h"
#import "LoginSqlite.h"
@implementation ContractsMainClauseModel
-(void)setDict:(NSDictionary *)dict{
    _dict=dict;
    self.a_id=dict[@"id"];
    self.a_contentMain=dict[@"contentMain"];
    self.a_fileName=dict[@"fileName"];
    self.a_status=[dict[@"status"] integerValue];
    self.a_archiveStatus=[dict[@"archiveStatus"] integerValue];
    self.a_isSelfCreated=[dict[@"createdBy"] isEqualToString:[LoginSqlite getdata:@"userName"]];
    self.a_contractsMoney=dict[@"contractsMoney"];
    self.a_serialNumber=dict[@"serialNumber"];
    self.a_recipientName=dict[@"recipientName"];

    if ([self.a_createdByType isEqualToString:@"2"]) {
        self.a_providerCompanyName=dict[@"partyB"];
        self.a_salerCompanyName=dict[@"partyA"];
        
        self.a_providerName=dict[@"recipientName"];
        self.a_salerName=dict[@"createdBy"];
    }else{
        self.a_providerCompanyName=dict[@"partyA"];
        self.a_salerCompanyName=dict[@"partyB"];
        
        self.a_providerName=dict[@"createdBy"];
        self.a_salerName=dict[@"recipientName"];
    }
    
    NSString* createdTime=dict[@"createdTime"];
    self.a_createdTime=[createdTime substringToIndex:createdTime.length-3];
}
@end
