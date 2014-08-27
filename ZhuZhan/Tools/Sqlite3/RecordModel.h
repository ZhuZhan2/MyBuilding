//
//  RecordModel.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-7-22.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecordModel : NSObject
@property (nonatomic,strong) NSString *a_name;
@property (nonatomic,strong) NSString *a_time;
-(void)loadWithDictionary:(NSDictionary*)dic;
-(void)loadWithDB:(NSDictionary*)dic;
@end
