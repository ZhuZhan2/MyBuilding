//
//  ProjectStage.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-26.
//
//

#import "ProjectStage.h"

@implementation ProjectStage
+(NSString *)ProjectStrStage:(NSString *)str{
    NSString *string = nil;
    if([[NSString stringWithFormat:@"%@",str] isEqualToString:@"(null)"]||[[NSString stringWithFormat:@"%@",str] isEqualToString:@"<null>"]||[[NSString stringWithFormat:@"%@",str] isEqualToString:@" "]){
        string = @"";
    }else{
        string = str;
    }
    return string;
}

+(NSString *)ProjectTimeStage:(NSString *)str{
    NSString *string = nil;
    if([[NSString stringWithFormat:@"%@",str] isEqualToString:@"(null)"]||[[NSString stringWithFormat:@"%@",str] isEqualToString:@"<null>"]||[[NSString stringWithFormat:@"%@",str] isEqualToString:@" "]){
        string = @"";
    }else{
        NSArray *arr = [str componentsSeparatedByString:@"T"];
        string = arr[0];
    }
    return string;
}

+(NSDate *)ProjectDateStage:(NSString *)str{
    NSDate *date = nil;
    if([[NSString stringWithFormat:@"%@",str] isEqualToString:@"(null)"]||[[NSString stringWithFormat:@"%@",str] isEqualToString:@"<null>"]||[[NSString stringWithFormat:@"%@",str] isEqualToString:@" "]){
        date = nil;
    }else{
        NSArray *arr = [str componentsSeparatedByString:@"."];
        NSString *time = [arr[0] stringByReplacingOccurrencesOfString:@"T" withString:@" "];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        date = [dateFormatter dateFromString:time];
    }
    return date;
}

+(NSString *)ProjectBoolStage:(NSString *)str{
    NSString *string = nil;
    if([[NSString stringWithFormat:@"%@",str] isEqualToString:@"(null)"]||[[NSString stringWithFormat:@"%@",str] isEqualToString:@"<null>"]||[[NSString stringWithFormat:@"%@",str] isEqualToString:@" "]){
        string = @"";
    }else{
        if([[NSString stringWithFormat:@"%@",str] isEqualToString:@"0"]){
            string = @"No";
        }else if([[NSString stringWithFormat:@"%@",str] isEqualToString:@"1"]){
            string = @"Yes";
        }
    }
    return string;
}

+(NSString *)JudgmentProjectStage:(projectModel *)model{
    NSString *stage = [[NSString alloc] init];
    if(![model.a_landName isEqualToString:@""] ||
       ![model.a_district isEqualToString:@""] ||
       ![model.a_province isEqualToString:@""] ||
       ![model.a_landAddress isEqualToString:@""] ||
       ![model.a_city isEqualToString:@""] ||
       ![model.a_area isEqualToString:@""] ||
       ![model.a_plotRatio isEqualToString:@""] ||
       ![model.a_usage isEqualToString:@""] ||
       ![model.a_projectName isEqualToString:@""] ||
       ![model.a_description isEqualToString:@""] ||
       ![model.a_exceptStartTime isEqualToString:@""] ||
       ![model.a_investment isEqualToString:@""] ||
       ![model.a_storeyArea isEqualToString:@""] ||
       ![model.a_storeyHeight isEqualToString:@""] ||
       ![model.a_foreignInvestment isEqualToString:@""] ||
       ![model.a_ownerType isEqualToString:@""] ){
        stage = @"1";
    }
    
    if(![model.a_mainDesignStage isEqualToString:@""] ||
       ![model.a_elevator isEqualToString:@"0"] ||
       ![model.a_airCondition isEqualToString:@"0"] ||
       ![model.a_exceptFinishTime isEqualToString:@""] ||
       ![model.a_heating isEqualToString:@"0"] ||
       ![model.a_externalWallMeterial isEqualToString:@"0"] ||
       ![model.a_stealStructure isEqualToString:@"0"] ){
        stage = @"2";
    }
    
    if(![model.a_actureStartTime isEqualToString:@""] ||
       ![model.a_fireControl isEqualToString:@""] ||
       ![model.a_green isEqualToString:@""] ){
        stage = @"3";
    }
    
    if(![model.a_electorWeakInstallation isEqualToString:@""] ||
       ![model.a_decorationSituation isEqualToString:@""] ||
       ![model.a_decorationProcess isEqualToString:@""] ){
        stage = @"4";
    }
    return stage;
}

+(NSString*)JudgmentContentIsPartOfAll:(NSArray*)contents{
    BOOL part=NO;
    BOOL none=NO;
    for (NSString* str in contents) {
        if (!part&&![str isEqualToString:@""]) {
            part=YES;
            if (none) {
                return @"part";
            }
        }else if(!none&&[str isEqualToString:@""]){
            none=YES;
            if (part) {
                return @"part";
            }
        }
    }
    return part?@"all":@"none";
}

+(NSString*)getPart:(NSArray*)detailStage contacts:(NSMutableArray*)contacts images:(NSMutableArray*)images{
    NSInteger count=0;
    if (contacts) {
        count++;
    }
    if (images) {
        count++;
    }
    NSInteger imagesCount=images?images.count:0;
    
    NSString* temp=[self JudgmentContentIsPartOfAll:[detailStage subarrayWithRange:NSMakeRange(0, detailStage.count-count)]];
    NSString* tempContect=@"none";
    if (contacts.count) {
        if (contacts.count<=2) {
            tempContect=@"part";
        }else{
            for (NSArray* ary in contacts) {
                for (NSString* str in ary) {
                    if ([str isEqualToString:@""]) {
                        tempContect=@"part";
                        break;
                    }
                }
                if ([tempContect isEqualToString:@"part"]) {
                    break;
                }else{
                    tempContect=@"all";
                }
            }
        }
    }else{
        tempContect=@"none";
    }
    
    if ([temp isEqualToString:@"all"]&&(contacts?[tempContect isEqualToString:@"all"]:1)&&(images?imagesCount:1)) {
        return @"all";
    }else if ([temp isEqualToString:@"none"]&&(contacts?[tempContect isEqualToString:@"none"]:1)&&(images?(!imagesCount):1)){
        return @"none";
    }else{
        return @"part";
    }
}

+(NSArray*)JudgmentProjectDetailStage:(projectModel*)model{
    
    NSMutableArray* array=[[NSMutableArray alloc]init];
    
    //土地规划/拍卖
    NSArray* auctionStage=@[model.a_landName,model.a_province,model.a_city,model.a_district,model.a_landAddress,model.a_area,model.a_plotRatio,model.a_usage,model.auctionContacts,model.auctionImages];
    //model.a_landName,model.a_province,model.a_city,model.a_district,model.a_landAddress,model.a_area ,model.a_plotRatio,model.a_usage,model.auctionContacts
    [array addObject:[self getPart:auctionStage contacts:model.auctionContacts images:model.auctionImages] ];
    
    //项目立项
    NSArray* approvalStage=@[model.a_projectName,model.a_city,model.a_district,model.a_landAddress,model.a_description,model.a_exceptStartTime,model.a_storeyHeight,model.a_foreignInvestment,model.a_exceptFinishTime,model.a_investment,model.a_storeyArea,model.a_ownerType,model.ownerContacts];
    //model.a_projectName,model.a_city,model.a_district,model.a_landAddress,model.a_description,model.a_exceptStartTime,model.a_storeyHeight,model.a_foreignInvestment,model.a_exceptFinishTime,model.a_investment,model.a_storeyArea,model.a_ownerType,model.ownerContacts
    [array addObject:[self getPart:approvalStage contacts:model.ownerContacts images:nil]];
    
    //地勘阶段
    NSArray* explorationStage=@[model.explorationContacts,model.explorationImages];
    //model.explorationContacts,model.explorationImages
    [array addObject:[self getPart:explorationStage contacts:model.explorationContacts images:model.explorationImages]];
    
    //设计阶段
    NSArray* designStage=@[model.a_mainDesignStage,model.designContacts];
    //model.designContacts
    [array addObject:[self getPart:designStage contacts:model.designContacts images:nil]];
    
    //出图阶段
    NSArray* pictureStage=@[model.a_exceptStartTime,model.a_exceptFinishTime,model.a_elevator,model.a_airCondition,model.a_heating,model.a_externalWallMeterial,model.a_stealStructure,model.ownerContacts];
    //model.ownerContacts,model.a_mainDesignStage,model.a_exceptStartTime,model.a_exceptFinishTime,model.a_elevator,model.a_airCondition,model.a_heating,model.a_externalWallMeterial,model.a_stealStructure
    [array addObject:[self getPart:pictureStage contacts:model.ownerContacts images:nil]];
   
    //地平阶段
    NSArray* constructionStage=@[model.a_actureStartTime,model.constructionContacts,model.constructionImages];
//    model.constructionContacts,model.a_actureStartTime,model.constructionImages
    [array addObject:[self getPart:constructionStage contacts:model.constructionContacts images:model.constructionImages]];
   
    //桩基基坑
    NSArray* pileStage=@[model.pileContacts,model.pileImages];
    //model.pileContacts,model.pileImages
    [array addObject:[self getPart:pileStage contacts:model.pileContacts images:model.pileImages]];
    
    //主体施工
    NSArray* mainBulidStage=@[model.mainBulidImages];
    //model.mainBulidImages
    [array addObject:[self getPart:mainBulidStage contacts:nil images:model.mainBulidImages]];
    
    //消防/景观绿化
    NSArray* fireGreenStage=@[model.a_fireControl,model.a_green];
    //model.a_fireControl,model.a_green
    [array addObject:[self getPart:fireGreenStage contacts:nil images:nil]];
    
    //装修阶段
    NSArray* decorationStage=@[model.a_electorWeakInstallation,model.a_decorationSituation,model.a_decorationProcess,model.decorationImages];
    //model.a_electorWeakInstallation,model.a_decorationSituation,model.a_decorationProcess,model.decorationImages
    [array addObject:[self getPart:decorationStage contacts:nil images:model.decorationImages]];
    
    return array;
}

@end
