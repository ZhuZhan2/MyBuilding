//
//  ContractsMainClauseModel.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/4/20.
//
//

#import <Foundation/Foundation.h>

@interface ContractsMainClauseModel : NSObject
//非撤销合同时是主条款、供应商合同id,撤销时是撤销id
@property (nonatomic, copy)NSString* a_id;
@property (nonatomic)BOOL a_isSelfCreated;
@property (nonatomic)NSInteger a_archiveStatus;
@property (nonatomic, copy)NSString* a_contentMain;
@property (nonatomic, copy)NSString* a_fileName;
@property (nonatomic, copy)NSString* a_createdTime;
//流水号
@property (nonatomic, copy)NSString* a_serialNumber;
//接收者用户名
@property (nonatomic, copy)NSString* a_recipientName;
@property (nonatomic)NSInteger a_status;
/*
 未开始  0
 已创建	1
 不同意	2
 同意	3
 导出	4
 上传敲章合同	5
 */
@property (nonatomic)NSInteger a_salestatus;
//合同金额
@property (nonatomic, copy)NSString* a_contractsMoney;
//销售方的用户名
@property (nonatomic, copy)NSString* a_salerName;
//供应方的用户名
@property (nonatomic, copy)NSString* a_providerName;
//销售方的公司全称
@property (nonatomic, copy)NSString* a_salerCompanyName;
//供应方的公司全称
@property (nonatomic, copy)NSString* a_providerCompanyName;

//A方的公司全称
@property (nonatomic, copy)NSString* a_partyA;
//B方的公司全称
@property (nonatomic, copy)NSString* a_partyB;

@property (nonatomic)BOOL a_provideHas;

//@"1"供应商,@"2"销售方
@property (nonatomic, copy)NSString* a_createdByType;

//销售合同的archiveStatus
@property (nonatomic)NSInteger a_saleArchiveStatus;

@property (nonatomic, strong)NSDictionary* dict;
@end
