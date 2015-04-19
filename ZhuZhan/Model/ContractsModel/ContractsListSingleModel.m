//
//  ContractsListSingleModel.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/4/17.
//
//

#import "ContractsListSingleModel.h"



@implementation ContractsListSingleModel
-(void)setDict:(NSDictionary *)dict{
    _dict=dict;
    /*
     @property (nonatomic, copy)NSString* a_archiveStatus;
     @property (nonatomic, copy)NSString* a_contractsType;
     @property (nonatomic, copy)NSString* a_createdBy;
     @property (nonatomic, copy)NSString* a_recipientName;
     @property (nonatomic, copy)NSString* a_salerCompanyName;
     @property (nonatomic, copy)NSString* a_providerCompanyName;
     @property (nonatomic, copy)NSString* a_createdByType;
     @property (nonatomic, copy)NSString* a_contractsMoney;
     @property (nonatomic, copy)NSString* a_createdById;
     @property (nonatomic, copy)NSString* a_serialNumber;
     @property (nonatomic, copy)NSString* a_status;
     */
    self.a_createdBy=dict[@"createdBy"];
    self.a_recipientName=dict[@"recipientName"];
    
    self.a_createdByType=dict[@"createdByType"];
    self.a_contractsMoney=dict[@"contractsMoney"];
    self.a_createdById=dict[@"createdById"];
    self.a_serialNumber=dict[@"serialNumber"];
    self.a_status=dict[@"status"];
    
    if ([self.a_createdByType isEqualToString:@"2"]) {
        self.a_providerCompanyName=dict[@"partyB"];
        self.a_salerCompanyName=dict[@"partyA"];
    }else{
        self.a_providerCompanyName=dict[@"partyA"];
        self.a_salerCompanyName=dict[@"partyB"];
    }
    
    NSInteger index1=[dict[@"contractsType"] integerValue];
    if (index1==4) {
        self.a_contractsType=@"佣金撤销流程";
    }else{
        NSDictionary* contractsTypes=@{
                                  @"1":@"供应商佣金合同",
                                  @"2":@"销售佣金合同"
                                  };
        self.a_contractsType=contractsTypes[self.a_createdByType];
    }

    NSArray* archiveStatus=@[@"进行中",@"已完成",@"已关闭"];
    NSInteger index2=[dict[@"archiveStatus"] integerValue];
    self.a_archiveStatus=archiveStatus[index2];
}
@end
