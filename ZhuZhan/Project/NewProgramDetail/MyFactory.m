//
//  MyFactory.m
//  test
//
//  Created by 孙元侃 on 14-8-21.
//  Copyright (c) 2014年 sunyk. All rights reserved.
//

#import "MyFactory.h"
#import "MyView.h"
#import "RKViewFactory.h"

#define NoDataColor RGBCOLOR(166, 166, 166)
#define HasDataColor RGBCOLOR(125, 125, 125)
#define NameColor RGBCOLOR(82, 125, 237)
#define TitleFont [UIFont systemFontOfSize:15]
#define ContentFont [UIFont systemFontOfSize:14]

@implementation MyFactory

+(void)addNameWithContacts:(NSMutableArray*)array name:(NSString*)name{
    for (int i=0; i<array.count; i++) {
        [array[i] addObject:name];
    }
}

//返回有联系人名称数据的颜色
static UIColor* nameColor(BOOL hasData){
    return hasData?NameColor:NoDataColor;
}

//返回有联系人职位数据的颜色
static UIColor* positionColor(BOOL hasData){
    return hasData?[UIColor blackColor]:NoDataColor;
}

//返回有联系人详细内容数据的颜色
static UIColor* contentColor(BOOL hasData){
    return hasData?HasDataColor:NoDataColor;
}

//判断字符串是否为@""，没有数据则返回@"-"
static NSString* hasContent(NSString* string){
    return [string isEqualToString:@""]?Heng:string;
}

//判断字符串是否为@""，返回BOOL
static BOOL hasContentBool(NSString* string){
    return ![string isEqualToString:@""];
}

//判断是否有姓名，没则返回@"姓名"
static NSString* hasName(NSString* string){
    return [string isEqualToString:@""]?@"姓名":string;
}

//判断职位是否有数据，没有则返回@"职位"
static NSString* hasPosition(NSString* string){
    return [string isEqualToString:@""]?@"职位":string;
}

//判断是否为空，空则返回地块名称
static NSString* hasAreaName(NSString* string){
    return [string isEqualToString:@""]?@"地块名称":string;
}

//判断是否为空，空则返回地块区域
static NSString* hasAreaPart(NSString* string){
    return [string isEqualToString:@"  "]?@"地块区域":string;
}

//判断是否为空，空则返回地块地址
static NSString* hasAreaAddress(NSString* string){
    return [string isEqualToString:@""]?@"地块地址":string;
}

//判断是否为空，空则返回项目名称
static NSString* hasProgramName(NSString* string){
    return [string isEqualToString:@""]?@"项目名称":string;
}
//判断是否为空，空则返回项目地址
static NSString* hasProgramAddress(NSString* string){
    return [string isEqualToString:@"  "]?@"项目地址":string;
}
//判断是否为空，空则返回项目描述
static NSString* hasProgramDescribe(NSString* string){
    return [string isEqualToString:@""]?@"项目描述":string;
}
//判断是否为空，空则返回业主类型
static NSString* hasUserTypeContent(NSString* string){
    return [string isEqualToString:@""]?@"业主类型":string;
}

//program大块 三行
+(UIView*)getThreeLinesTitleViewWithTitle:(NSString*)title titleImage:(UIImage*)titleImage dataThreeStrs:(NSArray*)datas{
    UIView* view=[[UIView alloc]initWithFrame:CGRectZero];
    view.backgroundColor=RGBCOLOR(229, 229, 229);
    CGFloat height=0;//累加，最后给view
    
    //获得第一部分
    UIView* part0=[self getTitleViewWithTitleImage:titleImage title:title];
    [view addSubview: part0];
    height+=part0.frame.size.height;
    
    //获得第二部分
    UIView* part1=[self getThreeLinesWithDataThreeStrs:datas isFirst:[title isEqualToString:@"土地规划/拍卖"]?YES:NO];
    part1.center=CGPointMake(160, height+part1.frame.size.height*.5);
    [view addSubview:part1];
    height+=part1.frame.size.height;
    
    //赋值frame,返回view
    view.frame=CGRectMake(0, 0, 320, height);
    return view;
}

//获得titleView部分
+(UIView*)getTitleViewWithTitleImage:(UIImage*)titleImage title:(NSString*)title{
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 55)];
    
    UIImageView* shadow=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 3.5)];
    shadow.image=[GetImagePath getImagePath:@"Shadow-bottom"];
    [view addSubview:shadow];
    
    UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, titleImage.size.width, titleImage.size.height)];
    imageView.image=titleImage;
    imageView.center=CGPointMake(160, imageView.frame.size.height*.5+10);
    [view addSubview:imageView];
    
    UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
    label.center=CGPointMake(160, 36);
    label.text=title;
    label.font=[UIFont systemFontOfSize:15];
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=RGBCOLOR(82, 125, 237);
    [view addSubview:label];
    
    return view;
}

//获得titleView下面的三行strs
+(UIView*)getThreeLinesWithDataThreeStrs:(NSArray*)datas isFirst:(BOOL)isFirst{
    UIView* view=[[UIView alloc]initWithFrame:CGRectZero];
    
    //计算总高,初始值10为分割线下方的预留高度
    CGFloat height=10;
    
    //与大标题之间的分割线
    [view addSubview:[self getSeperatedLine]];
    
    //第一行str
    UIFont* font=[UIFont systemFontOfSize:18];
    CGSize size=[datas[0] boundingRectWithSize:CGSizeMake(280, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    UILabel* programName=[[UILabel alloc]initWithFrame:CGRectMake(20, height, 280, size.height)];
    programName.text=isFirst?hasAreaName(datas[0]):hasProgramName(datas[0]);
    programName.font=font;
    programName.numberOfLines=0;
    programName.textColor=hasContentBool(datas[0])?[UIColor blackColor]:NoDataColor;
    programName.textAlignment=NSTextAlignmentCenter;
    [view addSubview:programName];
    height+=programName.frame.size.height+12;
    
    //第二行str
    font=[UIFont systemFontOfSize:14];
    size=[datas[1] boundingRectWithSize:CGSizeMake(280, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    
    UILabel* areaLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, height, 280, size.height)];
    areaLabel.text=isFirst?hasAreaPart(datas[1]):hasProgramAddress(datas[1]);
    NSLog(@"====%@=====",datas[1]);
    areaLabel.numberOfLines=2;
    areaLabel.font=font;
    areaLabel.textColor=![datas[1] isEqualToString:@"  "]?[UIColor blackColor]:NoDataColor;
    areaLabel.textAlignment=NSTextAlignmentCenter;
    [view addSubview:areaLabel];
    height+=areaLabel.frame.size.height+4;
    
    //第三行str
    font=[UIFont systemFontOfSize:14];
    size=[datas[2] boundingRectWithSize:CGSizeMake(280, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    
    UILabel* areaDetailLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, height, 280, isFirst?(size.height>20?32:size.height):size.height)];
    areaDetailLabel.text=isFirst?hasAreaAddress(datas[2]):hasProgramDescribe(datas[2]);
    areaDetailLabel.numberOfLines=0;
    areaDetailLabel.textColor=contentColor(hasContentBool(datas[2]));
    areaDetailLabel.font=font;
    areaDetailLabel.textAlignment=NSTextAlignmentCenter;
    [view addSubview:areaDetailLabel];
    height+=areaDetailLabel.frame.size.height+10;
    
    view.frame=CGRectMake(0, 0, 320, height);
    return view;
}

//分割线
+(UIView*)getSeperatedLine{
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(15, 0, 290, 1)];
    view.backgroundColor=RGBCOLOR(206, 206, 206);
    
    return view;
}

//program大块 二行
+(UIView*)getTwoLinesTitleViewWithTitle:(NSString*)title titleImage:(UIImage*)titleImage firstStrs:(NSArray*)firstStrs secondStrs:(NSArray*)secondStrs{
    UIView* view=[[UIView alloc]initWithFrame:CGRectZero];
    view.backgroundColor=RGBCOLOR(229, 229, 229);
    CGFloat height=0;//累加，最后给view
    
    UIView* part0=[self getTitleViewWithTitleImage:titleImage title:title];
    [view addSubview:part0];
    height+=part0.frame.size.height;
    
    UIView* part1=[self getBlackTwoLinesWithFirstStr:firstStrs secondStr:secondStrs];
    part1.backgroundColor=[UIColor clearColor];
    [part1 addSubview:[self getSeperatedLine]];
    part1.center=CGPointMake(160, height+part1.frame.size.height*.5);
    [view addSubview:part1];
    height+=part1.frame.size.height;
    
    view.frame=CGRectMake(0, 0, 320, height);
    return view;
}

//program大块 零行
+(UIView*)getNoLineTitleViewWithTitle:(NSString*)title titleImage:(UIImage*)titleImage{
    UIView* view=[self getTitleViewWithTitleImage:titleImage title:title];
    view.backgroundColor=RGBCOLOR(229, 229, 229);
    return view;
}

//图加图的数量
+(UIView*)getImageViewWithImageUrl:(NSString*)imageUrl count:(NSInteger)count{
    UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 216)];
    imageView.backgroundColor = [UIColor grayColor];
    [RKViewFactory imageViewWithImageView:imageView imageUrl:imageUrl defaultImageName:@"默认图_项目详情老"];
    
    //图片数量label
    UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(0, 164, 58, 26)];
    label.text=[NSString stringWithFormat:@"%ld张",(long)count];
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=[UIColor whiteColor];
    label.font=[UIFont systemFontOfSize:14.5];
    label.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:.7];
    [imageView addSubview:label];
    
    return imageView;
}

+(void)addButtonToView:(UIView*)view target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    UIButton* button=[[UIButton alloc]initWithFrame:view.frame];
    button.tag=view.tag;
    [button addTarget:target action:action forControlEvents:controlEvents];
    [view addSubview:button];
}

+(UIView*)getOwnerTypeViewWithImage:(UIImage*)image owners:(NSArray*)owners extraDownHeight:(CGFloat)extraDownHeight{
    UIView* view=[[UIView alloc]initWithFrame:CGRectZero];
    view.backgroundColor=[UIColor whiteColor];
    
    UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(15, extraDownHeight, 20, 20)];
    imageView.image=image;
    [view addSubview:imageView];
    
    BOOL hasData=YES;
    for (int i=0; i<owners.count; i++) {
        UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(45+i%4*((320-45)*1.0/4), extraDownHeight+i/4*30, 200, 20)];
        if ((owners.count==1)&[owners[0] isEqualToString:@""]) {
            label.text=hasUserTypeContent(owners[0]);
            hasData=NO;
        }else{
            label.text=(i==owners.count-1)?owners[i]:[owners[i] stringByAppendingString:@"，"];
        }
        label.textColor=hasData?[UIColor blackColor]:NoDataColor;
        label.font=ContentFont;
        [view addSubview:label];
    }
    
    view.frame=CGRectMake(0, 0, 320, extraDownHeight+35+(owners.count>0?(owners.count-1)/4*30:0));
    return view;
}

//第一行蓝，第二行黑，专门为土地信息做的view
+(UIView*)getBlueThreeTypesTwoLinesWithFirstStr:(NSArray*)firstStrs secondStr:(NSArray*)secondStrs{
    UIView* view=[[UIView alloc]initWithFrame:CGRectZero];
    view.backgroundColor=[UIColor whiteColor];
    
    //土地面积
    //计算土地面积名称Label的宽
    CGSize size=[firstStrs[0] boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:TitleFont} context:nil].size;
    //开始初始化土地面积label
    UILabel* areaFirstLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, 10, size.width, 20)];
    areaFirstLabel.text=firstStrs[0];
    areaFirstLabel.textColor=NameColor;
    areaFirstLabel.font=TitleFont;
    areaFirstLabel.textAlignment=NSTextAlignmentLeft;
    [view addSubview:areaFirstLabel];
    
    BOOL hasData=hasContentBool(secondStrs[0]);
    UILabel* areaSecondLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, 30, size.width, 20)];
    areaSecondLabel.text=hasContent(secondStrs[0]);
    areaSecondLabel.textColor=contentColor(hasData);
    areaSecondLabel.font=ContentFont;
    areaSecondLabel.textAlignment=NSTextAlignmentCenter;
    [view addSubview:areaSecondLabel];
    
    //土地容积率
    UILabel* plotFirstLabel=[[UILabel alloc]initWithFrame:CGRectMake(200, 10, 120, 20)];
    plotFirstLabel.text=firstStrs[1];
    plotFirstLabel.textColor=RGBCOLOR(82, 125, 237);
    plotFirstLabel.font=TitleFont;
    plotFirstLabel.textAlignment=NSTextAlignmentCenter;
    [view addSubview:plotFirstLabel];
    
    hasData=hasContentBool(secondStrs[1]);
    UILabel* plotSecondLabel=[[UILabel alloc]initWithFrame:CGRectMake(200, 30, 120, 20)];
    plotSecondLabel.text=hasContent(secondStrs[1]);
    plotSecondLabel.textColor=contentColor(hasData);
    plotSecondLabel.font=ContentFont;
    plotSecondLabel.textAlignment=NSTextAlignmentCenter;
    [view addSubview:plotSecondLabel];
    
    //地块用途
    UILabel* usedFirstLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, 10+60, 160, 20)];
    usedFirstLabel.text=firstStrs[2];
    usedFirstLabel.textColor=RGBCOLOR(82, 125, 237);
    usedFirstLabel.font=TitleFont;
    usedFirstLabel.textAlignment=NSTextAlignmentLeft;
    [view addSubview:usedFirstLabel];
    
    hasData=hasContentBool(secondStrs[2]);
    UILabel* usedSecondLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    usedSecondLabel.text=hasContent(secondStrs[2]);
    usedSecondLabel.numberOfLines=0;
    usedSecondLabel.textColor=contentColor(hasData);
    usedSecondLabel.font=ContentFont;
    usedSecondLabel.textAlignment=NSTextAlignmentLeft;
    CGRect bounds=[usedSecondLabel.text boundingRectWithSize:CGSizeMake( 290, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:ContentFont forKey:NSFontAttributeName] context:nil];
    usedSecondLabel.frame=CGRectMake(15, 30+60, 290, bounds.size.height);
    [view addSubview:usedSecondLabel];
    
    view.frame=CGRectMake(0, 0, 320, 2*60+(bounds.size.height-20));
    return view;
}

//第一行蓝，第二行黑的view
+(UIView*)getBlueTwoLinesWithFirstStr:(NSArray*)firstStrs secondStr:(NSArray*)secondStrs{
    NSInteger count=firstStrs.count>=secondStrs.count?firstStrs.count:secondStrs.count;
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, (count+2)/3*60)];
    view.backgroundColor=[UIColor whiteColor];
    
    for (int i=0; i<firstStrs.count; i++) {
        UILabel* firstLabel=[[UILabel alloc]initWithFrame:CGRectMake(i%3*320*1.0/3, 10+i/3*60, 320*1.0/3, 20)];
        firstLabel.text=firstStrs[i];
        firstLabel.textColor=RGBCOLOR(82, 125, 237);
        firstLabel.font=[UIFont systemFontOfSize:14];
        firstLabel.textAlignment=NSTextAlignmentCenter;
        [view addSubview:firstLabel];
    }
    
    for (int i=0; i<secondStrs.count; i++) {
        UILabel* secondLabel=[[UILabel alloc]initWithFrame:CGRectMake(i%3*320*1.0/3, 30+i/3*60, 320*1.0/3, 20)];
        secondLabel.text=hasContent(secondStrs[i]);
        secondLabel.textColor=RGBCOLOR(125, 125, 125);
        secondLabel.font=[UIFont systemFontOfSize:14];
        secondLabel.textAlignment=NSTextAlignmentCenter;
        [view addSubview:secondLabel];
    }
    
    return view;
}

//第一行黑，第二行灰的view
+(UIView*)getBlackTwoLinesWithFirstStr:(NSArray*)firstStrs secondStr:(NSArray*)secondStrs{
    NSInteger count=firstStrs.count;
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 70)];
    view.backgroundColor=[UIColor whiteColor];
    
    for (int i=0; i<firstStrs.count; i++) {
        UILabel* firstLabel=[[UILabel alloc]initWithFrame:CGRectMake(i*320*1.0/count, 15, 320*1.0/count, 20)];
        firstLabel.text=firstStrs[i];
        firstLabel.textColor=[UIColor blackColor];
        firstLabel.font=TitleFont;
        firstLabel.textAlignment=NSTextAlignmentCenter;
        [view addSubview:firstLabel];
    }
    
    for (int i=0; i<secondStrs.count; i++) {
        UILabel* secondLabel=[[UILabel alloc]initWithFrame:CGRectMake(i*320*1.0/count, 35, 320*1.0/count, 20)];
        secondLabel.text=hasContent(secondStrs[i]);
        secondLabel.textColor=contentColor(hasContentBool(secondStrs[i]));
        secondLabel.font=ContentFont;
        secondLabel.textAlignment=NSTextAlignmentCenter;
        [view addSubview:secondLabel];
    }
    
    return view;
}

//2015年3月3日，该方法暂时取消，因为不需要当联系人数量不足3个的时候再用默认数据填充了，可直接使用原数据进行操作
//处理model中的联系人,如果不满3个则补默认格式的联系人过去显示
/**
 *  @param contacts        中每个元素为一个@[@"",@"",@"",@"",@""]的数组
 *
 */
+(NSArray*)loadContacts:(NSMutableArray*)contacts withContactCategory:(NSString*)contactCategory{
    NSMutableArray* array=[NSMutableArray array];
    for (int i=0; i<contacts.count; i++) {
        NSMutableArray* tempArray=[contacts[i] mutableCopy];
        [tempArray addObject:contactCategory];
        [array addObject:tempArray];
    }
    //    for (int i=0; i<3-contacts.count; i++) {
    //        NSArray* tempAry=@[@"",@"",@"",@"",@"",contactCategory];
    //        [array addObject:tempAry];
    //    }
    return [array copy];
}

#define lineHeight 145
#define leftWidth 15
#define lineWidth 290
//联系人view
+(UIView*)getThreeContactsViewThreeTypesFiveStrs:(NSMutableArray*)dataAry withContactCategory:(NSString*)contactCategory{
    //2015年3月3日，该方法暂时取消，因为不需要当联系人数量不足3个的时候再用默认数据填充了，可直接使用原数据进行操作
    NSArray* datas=[self loadContacts:dataAry withContactCategory:contactCategory];
    
    //NSArray* datas=[dataAry copy];
    
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, datas.count*lineHeight)];
    view.backgroundColor=[UIColor whiteColor];
    
    for (int i=0; i<datas.count; i++) {
        NSArray* array=datas[i];
        
        //名字
        UILabel* labelName=[[UILabel alloc]initWithFrame:CGRectMake(leftWidth, 14+i*lineHeight, 280, 20)];
        labelName.text=hasName(array[0]);
        labelName.textAlignment=NSTextAlignmentLeft;
        labelName.textColor=nameColor(hasContentBool(array[0]));
        labelName.font=TitleFont;
        [view addSubview:labelName];
        
        //职位
        UILabel* jobLabel=[[UILabel alloc]initWithFrame:CGRectMake(leftWidth, 40+i*lineHeight, 150, 20)];
        jobLabel.text=hasPosition(array[1]);
        jobLabel.textColor=positionColor(hasContentBool(array[1]));
        jobLabel.font=ContentFont;
        [view addSubview:jobLabel];
        
        
        NSLog(@"===>%@",array);
        //单位名称
        CGSize size=[array[5] boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:ContentFont} context:nil].size;
        UILabel* companyName=[[UILabel alloc]initWithFrame:CGRectMake(leftWidth, 60+i*lineHeight, size.width, 20)];
        companyName.text=array[5];
        companyName.font=ContentFont;
        companyName.textColor=contentColor(YES);
        [view addSubview:companyName];
        
        //单位名称具体内容
        CGFloat tempWidth=290-companyName.frame.size.width;
        BOOL isTwoLine=([array[2] boundingRectWithSize:CGSizeMake(tempWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:ContentFont} context:nil].size.height>23);
        UILabel* companyNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(leftWidth+companyName.frame.size.width, 60+i*lineHeight, tempWidth, isTwoLine?40:20)];
        companyNameLabel.numberOfLines=isTwoLine?2:1;
        companyNameLabel.text=hasContent(array[2]);
        companyNameLabel.textColor=contentColor(hasContentBool(array[2]));
        companyNameLabel.textAlignment=NSTextAlignmentLeft;
        companyNameLabel.font=ContentFont;
        [view addSubview:companyNameLabel];
        
        //地址名称
        size=[@"单位地址：" boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:ContentFont} context:nil].size;
        UILabel* addressName=[[UILabel alloc]initWithFrame:CGRectMake(leftWidth, 100+i*lineHeight, size.width, 20)];
        addressName.text=@"单位地址：";
        addressName.font=ContentFont;
        addressName.textColor=contentColor(YES);
        [view addSubview:addressName];
        
        //地址具体内容
        tempWidth=290-addressName.frame.size.width;
        isTwoLine=([array[3] boundingRectWithSize:CGSizeMake(tempWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:ContentFont} context:nil].size.height>23);
        UILabel* addressLabel=[[UILabel alloc]initWithFrame:CGRectMake(leftWidth+addressName.frame.size.width, 100+i*lineHeight, tempWidth, isTwoLine?40:20)];
        addressLabel.numberOfLines=isTwoLine?2:1;
        addressLabel.text=hasContent(array[3]);
        addressLabel.textColor=contentColor(hasContentBool(array[3]));
        addressLabel.textAlignment=NSTextAlignmentLeft;
        addressLabel.font=ContentFont;
        [view addSubview:addressLabel];
        
        //电话图标
        UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(142, 46+i*lineHeight, 12.5, 12.5)];
        imageView.image=[GetImagePath getImagePath:@"021"];
        [view addSubview:imageView];
        
        //电话号码
        UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(160, 41+i*lineHeight, 160, 20)];
        label.text=hasContent(array[4]);
        label.font=ContentFont;
        label.textColor=contentColor(hasContentBool(array[4]));
        [view addSubview:label];
        
        if (i!=datas.count-1) {
            //分割线1
            UIView* line1=[self getSeperatedLine];
            line1.center=CGPointMake(160, lineHeight-0.5+i*lineHeight);
            [view addSubview:line1];
        }
    }
    return view;
}

//硬件设备以及yes和no  电梯,空调,供暖方式,外墙材料,钢结构,yes or no的几个view
+(UIView*)getDeviceAndBoolWithDevic:(NSArray*)devices boolStrs:(NSArray*)boolStrs hideFirstSeparatorLine:(BOOL)hideFirstSeparatorLine{
    CGFloat cellHeight=40;
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, devices.count*cellHeight)];
    view.backgroundColor=[UIColor whiteColor];
    
    //电梯,空调,供暖方式,外墙材料,钢结构 的label
    for (int i=0; i<devices.count; i++) {
        UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(20, i*cellHeight, 150, cellHeight)];
        label.text=devices[i];
        label.font=ContentFont;
        [view addSubview:label];
        
        //分割线
        UIView* separatorLine=[self getSeperatedLine];
        separatorLine.center=CGPointMake(160, .5+i*cellHeight);
        [view addSubview:separatorLine];
        if (i==0&&hideFirstSeparatorLine) {
            separatorLine.hidden=YES;
        }
    }
    
    //yes or no的label
    for (int i=0; i<boolStrs.count; i++) {
        UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(250, i*cellHeight, 50, cellHeight)];
        label.text=hasContent(boolStrs[i]);
        label.font=ContentFont;
        label.textAlignment=NSTextAlignmentRight;
        label.textColor=hasContentBool(boolStrs[i])?([boolStrs[i] isEqualToString:@"Yes"]?[UIColor redColor]:[UIColor grayColor]):NoDataColor;
        [view addSubview:label];
    }
    
    return view;
}
@end
