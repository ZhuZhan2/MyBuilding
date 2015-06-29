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
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    _dict = dict;
    self.a_lastUpdatedTime = [ProjectStage ProjectCardTimeStage:dict[@"lastUpdatedTime"]];
    self.a_commentsNum = [ProjectStage ProjectStrStage:dict[@"commentsNum"]];
    self.a_id = [ProjectStage ProjectStrStage:dict[@"projectId"]];
    self.a_landName = [ProjectStage ProjectStrStage:dict[@"landName"]];
    self.a_district = [ProjectStage ProjectStrStage:dict[@"landDistrict"]];
    self.a_province = [ProjectStage ProjectStrStage:dict[@"landProvince"]];
    self.a_city = [ProjectStage ProjectStrStage:dict[@"landCity"]];
    self.a_landAddress = [ProjectStage ProjectStrStage:dict[@"landAddress"]];
    self.a_area = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"landArea"]]];
    self.a_plotRatio = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"landPlotRatio"]]];
    self.a_usage = [ProjectStage ProjectStrStage:dict[@"landUsagesCn"]];
    self.a_projectName = [ProjectStage ProjectStrStage:dict[@"projectName"]];
    self.a_description = [ProjectStage ProjectStrStage:dict[@"projectDesc"]];
    self.a_exceptStartTime = [ProjectStage ProjectTimeStage:dict[@"startTime"]];
    self.a_exceptFinishTime = [ProjectStage ProjectTimeStage:dict[@"endTime"]];
    self.a_investment = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"investment"]]];
    self.a_storeyArea = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"storeyArea"]]];
    self.a_storeyHeight = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"storeyHeight"]]];
    self.a_foreignInvestment = [ProjectStage ProjectBoolStage:dict[@"isForeignIn"]];
    self.a_ownerType = [ProjectStage ProjectStrStage:dict[@"ownerTypeCn"]];
    self.a_longitude = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"longitude"]]];
    self.a_latitude = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"latitude"]]];
    self.a_mainDesignStage = [ProjectStage ProjectStrStage:dict[@"mainDesignStageCn"]];
    self.a_elevator = [ProjectStage ProjectBoolStage:dict[@"elevator"]];
    self.a_airCondition = [ProjectStage ProjectBoolStage:dict[@"airCondition"]];
    self.a_heating = [ProjectStage ProjectBoolStage:dict[@"heating"]];
    self.a_externalWallMeterial = [ProjectStage ProjectBoolStage:dict[@"externalWallMeterial"]];
    self.a_stealStructure = [ProjectStage ProjectBoolStage:dict[@"stealStructure"]];
    self.a_actureStartTime = [ProjectStage ProjectTimeStage:dict[@"actureStartTime"]];
    self.a_fireControl = [ProjectStage ProjectStrStage:dict[@"fireControlCn"]];
    self.a_green = [ProjectStage ProjectStrStage:dict[@"greenCn"]];
    self.a_electorWeakInstallation = [ProjectStage ProjectStrStage:dict[@"electroWeakInstallationCn"]];
    self.a_decorationSituation = [ProjectStage ProjectStrStage:dict[@"decorationSituationCn"]];
    self.a_decorationProcess = [ProjectStage ProjectStrStage:dict[@"decorationProcessCn"]];
    self.isFocused = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"isFocus"]]];
    self.a_projectstage = [ProjectStage ProjectStrStage:dict[@"projectStage"]];
    if(![[ProjectStage ProjectStrStage:dict[@"projectImagesId"]] isEqualToString:@""]){
        self.a_imageLocation = [NSString stringWithFormat:@"%@%@",[userDefaults objectForKey:@"serverAddress"],image([ProjectStage ProjectStrStage:dict[@"projectImagesId"]], @"project", @"288", @"110", @"1")];
    }else{
        self.a_imageLocation = [ProjectStage ProjectStrStage:dict[@"projectImagesId"]];
    }
    self.a_imageHeight = [ProjectStage ProjectStrStage:dict[@"imageHeight"]];
    self.a_imageWidth = [ProjectStage ProjectStrStage:dict[@"imageWidth"]];
    
    self.a_loginId = dict[@"loginId"];
    if([dict[@"isVerify"] isEqualToString:@"00"]){
        self.a_isVerify = NO;
    }else{
        self.a_isVerify = YES;
    }
    
    if([dict[@"verifyApply"] intValue] == 0){
        self.a_verifyApply = NO;
    }else{
        self.a_verifyApply = YES;
    }
    
    if(self.a_isVerify){
        self.a_verifyStage = 2;
    }else{
        if(self.a_verifyApply){
            self.a_verifyStage = 1;
        }else{
            self.a_verifyStage = 0;
        }
    }
}

-(void)getContacts:(NSArray *)contacts{
    //对应原contactAry 对应json键auctionUnitContacts
    self.auctionContacts=[[NSMutableArray alloc]init];
    //对应原ownerAry 对应json键ownerUnitContacts
    self.ownerContacts=[[NSMutableArray alloc]init];
    //对应原explorationAry 对应json键explorationUnitContacts
    self.explorationContacts=[[NSMutableArray alloc]init];
    //对应原designAry 对应json键contractorUnitContacts designInstituteContacts
    self.designContacts=[[NSMutableArray alloc]init];
    //对应原horizonAry 对应json键designInstituteContacts contractorUnitContacts
    self.constructionContacts=[[NSMutableArray alloc]init];
    //对应原pileAry 对应json键pileFoundationUnitContacts
    self.pileContacts=[[NSMutableArray alloc]init];
    
    //将6个联系人数组放入数组,方便后期放入联系人相关内容
    NSArray* array=@[self.auctionContacts,self.ownerContacts,self.explorationContacts,self.designContacts,self.constructionContacts,self.pileContacts];
    
    //6个联系人的接口字段
    NSArray* categorys=@[@"auctionUnitContacts",@"ownerUnitContacts",@"explorationUnitContacts",@"designInstituteContacts",@"contractorUnitContacts",@"pileFoundationUnitContacts"];
    
    //将从接口获取到的所有联系人放入到对应的联系人数组
    for(int i=0;i<contacts.count;i++){
        ProjectContactModel* contactModel = contacts[i];
        
        NSLog(@"=====%@,%@",contactModel.a_contactName,contactModel.a_category);
        
        //判断是这个category是什么
        NSInteger index=-1;
        for (int k=0; k<array.count; k++) {
            if ([contactModel.a_category isEqualToString:categorys[k]]) {
                index=k;
                break;
            }
        }
        
        //判断是否为我们已有的6个category,并且由于接口可能存在的异常,如果超过3个联系人则不再在对应联系人数组里加入联系人
        if (index!=-1&&[array[index] count]<3) {
            //加入一个联系人模型
            NSArray* tempAry=@[contactModel.a_contactName,contactModel.a_duties,contactModel.a_accountName,contactModel.a_accountAddress,contactModel.a_mobilePhone];
            [array[index] addObject:tempAry];

            NSLog(@"=====");
        }
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
    //主体施工 消防/景观绿化 图片,显示在 主体施工/主体施工 阶段里
    
    NSArray* array=@[self.auctionImages,self.explorationImages,self.constructionImages,self.pileImages,self.mainBulidImages,self.decorationImages];
    NSArray* categorys=@[@"plan",@"exploration",@"horizon",@"pileFoundation",@"mainPart",@"electroweak",@"fireControl",@"other"];
    
    for(int i=0;i<images.count;i++){
        ProjectImageModel* imageModel = images[i];
        
        NSInteger index=-1;
        for (int k=0; k<categorys.count; k++) {
            if ([imageModel.a_imageCategory isEqualToString:categorys[k]]) {
                if (k == 6) {
                    index = 4;
                }else if (k == 7){
                    index = 0;
                }else{
                    index = k;
                }
                break;
            }
        }
        //判断是否为我们已有的6个category,并且由于接口可能存在的异常,如果超过3个联系人则不再在对应联系人数组里加入联系人
        if (index!=-1) {
            [array[index] addObject:imageModel];
            //.a_imageOriginalLocation];
        }
    }
}
@end
