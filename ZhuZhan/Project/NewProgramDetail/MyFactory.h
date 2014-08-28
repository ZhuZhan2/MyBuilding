//
//  MyFactory.h
//  test
//
//  Created by 孙元侃 on 14-8-21.
//  Copyright (c) 2014年 sunyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyFactory : NSObject
+(UIView*)getThreeLinesTitleViewWithTitle:(NSString*)title titleImage:(UIImage*)titleImage dataThreeStrs:(NSArray*)datas;//program大块 三行
+(UIView*)getImageViewWithImageUrl:(NSString*)imageUrl count:(NSInteger)count;//图加图的数量
+(UIView*)getBlueTwoLinesWithFirstStr:(NSArray*)firstStrs secondStr:(NSArray*)secondStrs;//第一行蓝，第二行黑的view
+(UIView*)getThreeContactsViewThreeTypesFiveStrs:(NSArray*)datas;//联系人view
+(UIView*)getTwoLinesTitleViewWithTitle:(NSString*)title titleImage:(UIImage*)titleImage firstStrs:(NSArray*)firstStrs secondStrs:(NSArray*)secondStrs;//program大块 二行
+(UIView*)getNoLineTitleViewWithTitle:(NSString*)title titleImage:(UIImage*)titleImage;//program大块 零行
+(UIView*)getDeviceAndBoolWithDevic:(NSArray*)devices boolStrs:(NSArray*)boolStrs;//硬件设备以及yes和no
+(UIView*)getBlackTwoLinesWithFirstStr:(NSArray*)firstStrs secondStr:(NSArray*)secondStrs;//第一行黑，第二行灰的view
+(UIView*)getSeperatedLine;//分割线
+(UIView*)getBlueThreeTypesTwoLinesWithFirstStr:(NSArray*)firstStrs secondStr:(NSArray*)secondStrs;
+(UIView*)getOwnerTypeViewWithImage:(UIImage*)image owners:(NSArray*)owners;

+(void)addButtonToView:(UIView*)view target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
@end
