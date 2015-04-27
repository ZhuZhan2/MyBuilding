//
//  RKContractsStagesView.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/4/9.
//
//

#import <UIKit/UIKit.h>

//节点状态
typedef enum{
    RKContractsSmallStagesStyleCompleted,//节点已完成
    RKContractsSmallStagesStyleNotBegin,//节点未开始
    RKContractsSmallStagesStyleEnd//节点已关闭
}RKContractsSmallStageStyle;

@interface RKContractsStagesView : UIScrollView
/*
 bigStageNames传一维数组，为阶段条上方的大阶段名称的NSString的数组
 smallStageNames为二维数组，其每个元素数组对应bigStageNames中的每个大阶段名
 smallStageStyles为二维数组,其每个元素数组中的每个元素对应smallStageNames中的每个元素数组中的每个元素的状态
 isClosed若为空，smallStageStyles中每个元素数组中的每个元素均会变为RKContractsSmallStagesStyleEnd，并且smallStageNames中的最后一个元素数组的最后一个元素会改为已关闭
 Created by 孙元侃 on 15/4/9
 */
+(UIView*)contractsStagesViewWithBigStageNames:(NSArray*)bigStageNames smallStageNames:(NSArray*)smallStageNames smallStageStyles:(NSArray*)smallStageStyles isClosed:(BOOL)isClosed;
@end
