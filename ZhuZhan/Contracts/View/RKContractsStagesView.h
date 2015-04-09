//
//  RKContractsStagesView.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/4/9.
//
//

#import <UIKit/UIKit.h>

typedef enum{
    RKContractsSmallStagesStyleCompleted,
    RKContractsSmallStagesStyleNotBegin,
    RKContractsSmallStagesStyleEnd
}RKContractsSmallStageStyle;

@interface RKContractsStagesView : UIScrollView
//big为一维，small为二维
+(instancetype)contractsStagesViewWithBigStageNames:(NSArray*)bigStageNames smallStageNames:(NSArray*)smallStageNames smallStageStyles:(NSArray*)smallStageStyles isClosed:(BOOL)isClosed;
@end
