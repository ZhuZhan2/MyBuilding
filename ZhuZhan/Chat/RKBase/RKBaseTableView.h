//
//  RKBaseTableView.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/13.
//
//

#import <UIKit/UIKit.h>

@protocol RKBaseTableViewDelegate <UITableViewDelegate>
-(void)touchesBeganInRKBaseTableView;
@end

@interface RKBaseTableView : UITableView
@property(nonatomic,weak)id<RKBaseTableViewDelegate>delegate;
@property (nonatomic, strong)UIView* noDataView;
@end
