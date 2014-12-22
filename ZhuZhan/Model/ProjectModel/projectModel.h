//
//  projectModel.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-25.
//
//

#import <Foundation/Foundation.h>

@interface projectModel : NSObject
//项目ID
@property (nonatomic,copy) NSString *a_id;
//地块名称
@property (nonatomic,copy) NSString *a_landName;
//所在区域
@property (nonatomic,copy) NSString *a_district;
//所在省市
@property (nonatomic,copy) NSString *a_province;
//市区县
@property (nonatomic,copy) NSString *a_city;
//地块地址（项目地址）
@property (nonatomic,copy) NSString *a_landAddress;
//土地面积
@property (nonatomic,copy) NSString *a_area;
//土地容积率
@property (nonatomic,copy) NSString *a_plotRatio;
//地块用途
@property (nonatomic,copy) NSString *a_usage;
//项目名称
@property (nonatomic,copy) NSString *a_projectName;
//项目描述
@property (nonatomic,copy) NSString *a_description;
//预计开工时间
@property (nonatomic,copy) NSString *a_exceptStartTime;
//预计竣工时间
@property (nonatomic,copy) NSString *a_exceptFinishTime;
//投资额
@property (nonatomic,copy) NSString *a_investment;
//建筑面积
@property (nonatomic,copy) NSString *a_storeyArea;
//建筑层高
@property (nonatomic,copy) NSString *a_storeyHeight;
//外资参与
@property (nonatomic,copy) NSString *a_foreignInvestment;
//业主类型
@property (nonatomic,copy) NSString *a_ownerType;
//经度
@property (nonatomic,copy) NSString *a_longitude;
//纬度
@property (nonatomic,copy) NSString *a_latitude;
//主体设计阶段
@property (nonatomic,strong) NSString *a_mainDesignStage;
//电梯
@property (nonatomic,strong) NSString *a_elevator;
//空调
@property (nonatomic,strong) NSString *a_airCondition;
//供暖
@property (nonatomic,strong) NSString *a_heating;
//外墙材料
@property (nonatomic,strong) NSString *a_externalWallMeterial;
//钢结构
@property (nonatomic,strong) NSString *a_stealStructure;
//实际开工时间
@property (nonatomic,strong) NSString *a_actureStartTime;
//消防
@property (nonatomic,strong) NSString *a_fireControl;
//景观绿化
@property (nonatomic,strong) NSString *a_green;
//弱电安装
@property (nonatomic,strong) NSString *a_electorWeakInstallation;
//装修情况
@property (nonatomic,strong) NSString *a_decorationSituation;
//装修进度
@property (nonatomic,strong) NSString *a_decorationProcess;

//土地信息 土地规划/拍卖 阶段 拍卖单位联系人
@property(nonatomic,strong)NSMutableArray* auctionContacts;
//土地信息 项目立项 阶段 业主单位联系人 //主体设计 出图 阶段 业主单位联系人
@property(nonatomic,strong)NSMutableArray* ownerContacts;
//主体设计 地勘 阶段 地勘公司联系人
@property(nonatomic,strong)NSMutableArray* explorationContacts;
//主体设计 设计 阶段 设计院联系人
@property(nonatomic,strong)NSMutableArray* designContacts;
//主体施工 地平 阶段 施工总承包单位联系人
@property(nonatomic,strong)NSMutableArray* constructionContacts;
//主体施工 桩基基坑 阶段 桩基分包单位联系人
@property(nonatomic,strong)NSMutableArray* pileContacts;

//土地信息 土地规划/拍卖 阶段 图片
@property(nonatomic,strong)NSMutableArray* auctionImages;
//主体设计 地勘 阶段 图片
@property(nonatomic,strong)NSMutableArray* explorationImages;
//主体施工 地平 阶段 图片
@property(nonatomic,strong)NSMutableArray* constructionImages;
//主体施工 桩基基坑 阶段 图片
@property(nonatomic,strong)NSMutableArray* pileImages;
//主体施工 主体施工 阶段 图片
@property(nonatomic,strong)NSMutableArray* mainBulidImages;
//装修 阶段 图片
@property(nonatomic,strong)NSMutableArray* decorationImages;

@property(nonatomic,copy)NSString *a_projectstage;

@property(nonatomic,strong)NSString *isFocused;

@property (nonatomic, copy) NSDictionary *dict;

//***********************************************************************************


//关联项目数组
@property (nonatomic,copy) NSMutableArray *projectArr;

//************************************************************************************

-(void)getContacts:(NSArray*)contacts;
-(void)getImages:(NSArray*)images;
@end
