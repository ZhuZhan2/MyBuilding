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
@end
