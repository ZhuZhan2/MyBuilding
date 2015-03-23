//
//  DemandStageCell.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/23.
//
//

#import <UIKit/UIKit.h>

@interface DemandStageCellModel : NSObject
@property(nonatomic,copy)NSString* stageName;
@property(nonatomic)BOOL isHighlight;
@end

@interface DemandStageCell : UITableViewCell
@property(nonatomic,strong)DemandStageCellModel* model;
@end
