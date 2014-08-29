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
    NSString *string = [[NSString alloc] init];
    if([[NSString stringWithFormat:@"%@",str] isEqualToString:@"(null)"]||[[NSString stringWithFormat:@"%@",str] isEqualToString:@"<null>"]||[[NSString stringWithFormat:@"%@",str] isEqualToString:@" "]){
        string = @"";
    }else{
        string = str;
    }
    return string;
}

+(NSString *)ProjectTimeStage:(NSString *)str{
    NSString *string = [[NSString alloc] init];
    if([[NSString stringWithFormat:@"%@",str] isEqualToString:@"(null)"]||[[NSString stringWithFormat:@"%@",str] isEqualToString:@"<null>"]||[[NSString stringWithFormat:@"%@",str] isEqualToString:@" "]){
        string = @"";
    }else{
        NSArray *arr = [str componentsSeparatedByString:@"T"];
        string = arr[0];
    }
    return string;
}

+(NSString *)ProjectBoolStage:(NSString *)str{
    NSString *string = [[NSString alloc] init];
    if([[NSString stringWithFormat:@"%@",str] isEqualToString:@"(null)"]||[[NSString stringWithFormat:@"%@",str] isEqualToString:@"<null>"]||[[NSString stringWithFormat:@"%@",str] isEqualToString:@" "]){
        string = @"No";
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

+(NSArray*)JudgmentProjectDetailStage:(projectModel*)model{
    
    //土地规划/拍卖
    NSArray* auctionStage=@[model.a_landName,model.a_province,model.a_city,model.a_district,model.a_landAddress,model.a_area,model.a_plotRatio,model.a_usage,model.auctionContacts];
    //@[self.model.a_landName,[NSString stringWithFormat:@"%@ %@ %@",self.model.a_province,self.model.a_city,self.model.a_district],self.model.a_landAddress];;
//    @[[self.model.a_area stringByAppendingString:@"㎡"],[self.model.a_plotRatio stringByAppendingString:@"%"],self.model.a_usage];
//    self.model.auctionContacts
    
    //项目立项
    NSArray* approvalStage=@[model.a_projectName,model.a_city,model.a_district,model.a_landAddress,model.a_description,model.a_exceptStartTime,model.a_storeyHeight,model.a_foreignInvestment,model.a_exceptFinishTime,model.a_investment,model.a_storeyArea,model.ownerContacts];
//    @[self.model.a_projectName,[NSString stringWithFormat:@"%@ %@ %@",self.model.a_city,self.model.a_district,self.model.a_landAddress],self.model.a_description];
//    @[self.model.a_exceptStartTime,[self.model.a_storeyHeight stringByAppendingString:@"M"],self.model.a_foreignInvestment,self.model.a_exceptFinishTime,self.model.a_investment,[self.model.a_storeyArea stringByAppendingString:@"㎡"]];
//    self.model.ownerContacts
//    self.model.a_ownerType componentsSeparatedByString:@","
    
    //地勘阶段
    NSArray* explorationStage=@[model.explorationContacts];
    //self.model.explorationContacts
    
    //设计阶段
    NSArray* designStage=@[model.designContacts];
    //self.model.designContacts
    
    //出图阶段
    NSArray* pictureStage=@[model.ownerContacts,model.a_mainDesignStage,model.a_exceptStartTime,model.a_exceptFinishTime,model.a_elevator,model.a_airCondition,model.a_heating,model.a_externalWallMeterial,model.a_stealStructure];
    //self.model.ownerContacts
//    @[self.model.a_mainDesignStage],@[self.model.a_exceptStartTime,self.model.a_exceptFinishTime]
//    self.model.a_elevator,self.model.a_airCondition,self.model.a_heating,self.model.a_externalWallMeterial,self.model.a_stealStructure
    
    //地平阶段
//    NSArray* constructionStage;
//    self.model.constructionContacts
//    self.model.a_actureStartTime
//    
//    //桩基基坑
//    NSArray* pileStage;
//    self.model.pileContacts
//    
//    //主体施工
//    NSArray* mainBulidStage;
//    
//    //消防/景观绿化
//    NSArray* fireGreenStage;
//    @[self.model.a_fireControl,self.model.a_green]
//    
//    //装修阶段
//    NSArray* decorationStage;
//    @[self.model.a_electorWeakInstallation,self.model.a_decorationSituation,self.model.a_decorationProcess]
    
    return nil;
}

@end
