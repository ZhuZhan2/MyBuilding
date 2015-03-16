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
@end
