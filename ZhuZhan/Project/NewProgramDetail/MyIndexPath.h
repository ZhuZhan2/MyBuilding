//
//  MyIndexPath.h
//  ZpzchinaMobile
//
//  Created by 孙元侃 on 14-8-25.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyIndexPath : NSObject
@property(nonatomic)NSInteger part;
@property(nonatomic)NSInteger section;
+(MyIndexPath*)getIndexPart:(NSInteger)part section:(NSInteger)section;
@end
