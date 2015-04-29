//
//  ContractsListSingleModel.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/4/17.
//
//

#import "ContractsListSingleModel.h"
#import "LoginSqlite.h"
@implementation ContractsListSingleModel
-(void)setDict:(NSDictionary *)dict{
    _dict=dict;
    self.a_id=dict[@"id"];
    self.a_createdBy=dict[@"createdBy"];
    self.a_recipientName=dict[@"recipientName"];
    self.a_createdByType=dict[@"createdByType"];
    self.a_contractsMoney=dict[@"contractsMoney"];
    self.a_createdById=dict[@"createdById"];
    self.a_serialNumber=dict[@"serialNumber"];
    self.a_status=[dict[@"status"] integerValue];
    self.a_fileName=dict[@"fileName"];
    self.a_partyA=dict[@"partyA"];
    self.a_partyB=dict[@"partyB"];
    self.a_provideHas=[dict[@"recordHas"] isEqualToString:@"1"];
    self.a_saleHas=[dict[@"saleHas"] isEqualToString:@"1"];
    
    NSString* createdTime=dict[@"createdTime"];
    self.a_createdTime=[createdTime substringToIndex:createdTime.length-3];
    
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
    
    self.a_isSaler=[self.a_salerName isEqualToString:[LoginSqlite getdata:@"userName"]];
    
    self.a_isSelfCreated=[dict[@"createdBy"] isEqualToString:[LoginSqlite getdata:@"userName"]];
    
    NSDictionary* contractsTypes=@{
                                   @"1":@"供应商佣金合同",
                                   @"2":@"销售佣金合同",
                                   @"3":@"佣金撤销流程"
                                   };
    self.a_contractsTypeInt=[dict[@"contractsType"] integerValue];
    self.a_contractsType=contractsTypes[dict[@"contractsType"]];
    
    {
        NSArray* archiveStatuses=@[@"进行中",@"已完成",@"已关闭"];
        NSInteger archiveStatus=[dict[@"archiveStatus"] integerValue];
        //        if (self.a_isSaler) {
        //            if (archiveStatus==1&&self.a_saleHas) {
        //                archiveStatus=1;
        //            }else if(archiveStatus!=2){
        //                archiveStatus=0;
        //            }
        //        }
        self.a_archiveStatusInt=archiveStatus;
        self.a_archiveStatus=archiveStatuses[self.a_archiveStatusInt];
    }
    self.a_contractsRecordId=dict[@"contractsRecordId"];
}
@end
