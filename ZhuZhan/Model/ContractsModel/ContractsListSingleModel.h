//
//  ContractsListSingleModel.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/4/17.
//
//

#import <Foundation/Foundation.h>
/*
 archiveStatus = 0;
 companyName = "";
 contractsMoney = 88888888;
 contractsRecordId = "";
 contractsType = 0;
 createdBy = wy0003;
 createdById = "d859009b-51b4-4415-ada1-d5ea09ca4130";
 createdByType = 1;
 createdTime = "2015/4/17 11:11:05";
 fileName = "";
 id = "f3ab3693-a62b-4095-a4ef-a1f585f1917e";
 partyA = "\U9500\U552e\U65b9\U516c\U53f8\U5168\U540d";
 partyB = "\U9500\U552e\U65b9\U516c\U53f8\U5168\U540d";
 pecipientName = "";
 recipientId = "4dab083a-3f09-4854-839a-f45995b6047f";
 recipientName = wy0002;
 remark = "";
 remarkOne = "";
 remarkRecord = "";
 serialNumber = 4796B295FBBFDF;
 serialNumberRecord = "";
 status = 1;
 */
@interface ContractsListSingleModel : NSObject

@property (nonatomic, copy)NSString* a_id;

//进行中0，已完成1，已关闭2
@property (nonatomic)NSInteger a_archiveStatusInt;
@property (nonatomic, copy)NSString* a_archiveStatus;
/*
 所有合同	0
 供应商合同	1
 销售合同	2
 撤销合同	3
 */
@property (nonatomic, copy)NSString* a_contractsType;
@property (nonatomic, copy)NSString* a_createdBy;
//接收者用户名
@property (nonatomic, copy)NSString* a_recipientName;

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


//@"1"供应商,@"2"销售方
@property (nonatomic, copy)NSString* a_createdByType;
//合同金额
@property (nonatomic, copy)NSString* a_contractsMoney;
//创建人的id
@property (nonatomic, copy)NSString* a_createdById;
//流水号
@property (nonatomic, copy)NSString* a_serialNumber;
/*
 主条款已创建	1
 不同意主条款	2
 同意主条款	3
 不同意佣金合同	4
 同意佣金合同	5
 客服不同意佣金	6
 客服同意佣金	7
 已导出佣金合同	8
 上传敲章合同	9
 */
@property (nonatomic)NSInteger a_status;
@property (nonatomic, copy)NSString* a_fileName;
@property (nonatomic, copy)NSString* a_createdTime;
@property (nonatomic)BOOL a_isSelfCreated;
@property (nonatomic)BOOL a_isSaler;
@property (nonatomic)BOOL a_provideHas;
@property (nonatomic)BOOL a_saleHas;

@property (nonatomic, strong)NSDictionary* dict;
@end
