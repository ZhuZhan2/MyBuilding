//
//  ContractsRepealModel.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/4/22.
//
//

#import <Foundation/Foundation.h>

@interface ContractsRepealModel : NSObject
@property (nonatomic, copy)NSString* a_id;
@property (nonatomic)NSInteger a_status;
@property (nonatomic, copy)NSString* a_fileName;
@property (nonatomic, strong)NSDictionary* dict;
@end
