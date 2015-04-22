//
//  ContractsMainClauseModel.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/4/20.
//
//

#import <Foundation/Foundation.h>

@interface ContractsMainClauseModel : NSObject
@property (nonatomic, copy)NSString* a_contentMain;
@property (nonatomic, copy)NSString* a_fileName;
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
@property (nonatomic, strong)NSDictionary* dict;
@end
