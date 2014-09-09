//
//  projectModel.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-25.
//
//

#import "projectModel.h"
#import "ProjectStage.h"
#import "ProjectContactModel.h"
#import "ProjectImageModel.h"
@implementation projectModel
- (void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.a_id = [ProjectStage ProjectStrStage:dict[@"id"]];
    self.a_landName = [ProjectStage ProjectStrStage:dict[@"landName"]];
    self.a_district = [ProjectStage ProjectStrStage:dict[@"landDistrict"]];
    self.a_province = [ProjectStage ProjectStrStage:dict[@"landProvince"]];
    self.a_city = [ProjectStage ProjectStrStage:dict[@"landCity"]];
    self.a_landAddress = [ProjectStage ProjectStrStage:dict[@"landAddress"]];
    self.a_area = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"landArea"]]];
    self.a_plotRatio = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"landPlotRatio"]]];
    self.a_usage = [ProjectStage ProjectStrStage:dict[@"landUsages"]];
    self.a_projectName = [ProjectStage ProjectStrStage:dict[@"projectName"]];
    self.a_description = [ProjectStage ProjectStrStage:dict[@"projectDescription"]];
    self.a_exceptStartTime = [ProjectStage ProjectTimeStage:dict[@"exceptStartTime"]];
    self.a_exceptFinishTime = [ProjectStage ProjectTimeStage:dict[@"exceptFinishTime"]];
    self.a_investment = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"investment"]]];
    self.a_storeyArea = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"storeyArea"]]];
    self.a_storeyHeight = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"storeyHeight"]]];
    self.a_foreignInvestment = [ProjectStage ProjectBoolStage:dict[@"foreignInvestment"]];
    self.a_ownerType = [ProjectStage ProjectStrStage:dict[@"ownerType"]];
    self.a_longitude = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"longitude"]]];
    self.a_latitude = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"latitude"]]];
    self.a_mainDesignStage = [ProjectStage ProjectStrStage:dict[@"mainDesignStage"]];
    self.a_elevator = [ProjectStage ProjectBoolStage:dict[@"elevator"]];
    self.a_airCondition = [ProjectStage ProjectBoolStage:dict[@"airCondition"]];
    self.a_heating = [ProjectStage ProjectBoolStage:dict[@"heating"]];
    self.a_externalWallMeterial = [ProjectStage ProjectBoolStage:dict[@"externalWallMeterial"]];
    self.a_stealStructure = [ProjectStage ProjectBoolStage:dict[@"stealStructure"]];
    self.a_actureStartTime = [ProjectStage ProjectTimeStage:dict[@"actualStartTime"]];
    self.a_fireControl = [ProjectStage ProjectStrStage:dict[@"fireControl"]];
    self.a_green = [ProjectStage ProjectStrStage:dict[@"green"]];
    self.a_electorWeakInstallation = [ProjectStage ProjectStrStage:dict[@"electorWeakInstallation"]];
    self.a_decorationSituation = [ProjectStage ProjectStrStage:dict[@"decorationSituation"]];
    self.a_decorationProcess = [ProjectStage ProjectStrStage:dict[@"decorationProcess"]];
}

-(void)getContacts:(NSArray *)contacts{
    //对应原contactAry 对应json键auctionUnitContacts
    self.auctionContacts=[[NSMutableArray alloc]init];
    //对应原ownerAry 对应json键ownerUnitContacts
    self.ownerContacts=[[NSMutableArray alloc]init];
    //对应原explorationAry 对应json键explorationUnitContacts
    self.explorationContacts=[[NSMutableArray alloc]init];
    //对应原designAry 对应json键contractorUnitContacts
    self.designContacts=[[NSMutableArray alloc]init];
    //对应原horizonAry 对应json键designInstituteContacts
    self.constructionContacts=[[NSMutableArray alloc]init];
    //对应原pileAry 对应json键pileFoundationUnitContacts
    self.pileContacts=[[NSMutableArray alloc]init];
    
    NSArray* array=@[self.auctionContacts,self.ownerContacts,self.explorationContacts,self.designContacts,self.constructionContacts,self.pileContacts];
    NSArray* categorys=@[@"auctionUnitContacts",@"ownerUnitContacts",@"explorationUnitContacts",@"contractorUnitContacts",@"designInstituteContacts",@"pileFoundationUnitContacts"];
    NSLog(@"===> %d",contacts.count);
    for(int i=0;i<contacts.count;i++){
        ProjectContactModel* contactModel = contacts[i];
        NSInteger index=0;
        for (int i=0; i<array.count; i++) {
            if ([contactModel.a_category isEqualToString:categorys[i]]) {
                index=i;
                break;
            }
        }
        NSArray* tempAry=@[contactModel.a_contactName,contactModel.a_duties,contactModel.a_accountName,contactModel.a_accountAddress,contactModel.a_mobilePhone];
        [array[index] addObject:tempAry];
    }
}

-(void)getImages:(NSArray *)images{
    //土地信息 土地规划/拍卖 阶段 图片  planImageArr @"plan"
    self.auctionImages=[[NSMutableArray alloc]init];
    //主体设计 地勘 阶段 图片 self.explorationImageArr @"exploration"
    self.explorationImages=[[NSMutableArray alloc]init];
    //主体施工 地平 阶段 图片 self.horizonImageArr @"horizon"
    self.constructionImages=[[NSMutableArray alloc]init];
    //主体施工 桩基基坑 阶段 图片 pilePitImageArr @"pileFoundation"
    self.pileImages=[[NSMutableArray alloc]init];
    //主体施工 主体施工 阶段 图片 mainConstructionImageArr @"mainPart"
    self.mainBulidImages=[[NSMutableArray alloc]init];
    //装修 阶段 图片 electroweakImageArr @"electroweak"
    self.decorationImages=[[NSMutableArray alloc]init];
    
    NSArray* array=@[self.auctionImages,self.explorationImages,self.constructionImages,self.pileImages,self.mainBulidImages,self.decorationImages];
    NSArray* categorys=@[@"plan",@"exploration",@"horizon",@"pileFoundation",@"mainPart",@"electroweak"];
    
    for(int i=0;i<images.count;i++){
        ProjectImageModel* imageModel = images[i];
        NSInteger index=0;
        for (int i=0; i<array.count; i++) {
            if ([imageModel.a_imageCategory isEqualToString:categorys[i]]) {
                index=i;
                break;
            }
        }
        [array[index] addObject:imageModel.a_imageOriginalLocation];
        NSLog(@"%@",[array lastObject]);
    }
}
@end
