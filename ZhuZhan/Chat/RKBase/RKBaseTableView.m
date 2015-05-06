//
//  RKBaseTableView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/13.
//
//

#import "RKBaseTableView.h"

@implementation RKBaseTableView
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    if ([self.delegate respondsToSelector:@selector(touchesBeganInRKBaseTableView)]) {
        [self.delegate touchesBeganInRKBaseTableView];
    }
}

- (void)reloadData{
    [super reloadData];
    ;
    if (!self.noDataView) return;
    if (![self.dataSource tableView:self numberOfRowsInSection:0]) {
        self.userInteractionEnabled = NO;
        self.noDataView.frame = self.bounds;
        [self addSubview:self.noDataView];
    }else{
        self.userInteractionEnabled = YES;
        [self.noDataView removeFromSuperview];
    }
}
@end
