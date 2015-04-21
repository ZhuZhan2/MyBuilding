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
@property (nonatomic, strong)NSDictionary* dict;
@end
