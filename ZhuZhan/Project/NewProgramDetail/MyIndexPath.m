//
//  MyIndexPath.m
//  ZpzchinaMobile
//
//  Created by 孙元侃 on 14-8-25.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "MyIndexPath.h"

@implementation MyIndexPath
+(MyIndexPath*)getIndexPart:(NSInteger)part section:(NSInteger)section{
    MyIndexPath* indexPath=[[MyIndexPath alloc]init];
    indexPath.part=part;
    indexPath.section=section;
    return indexPath;
}
@end
