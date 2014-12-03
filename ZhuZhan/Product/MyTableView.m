//
//  MyTableView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 14/12/3.
//
//

#import "MyTableView.h"
@implementation MyTableView
-(void)reloadData{
    [super reloadData];
    [self contentFooter];
}

-(void)contentFooter{
    CGFloat orginFooterHeight=self.tableFooterView.frame.size.height;
    CGFloat contentHeightWithOutFooter=self.contentSize.height-orginFooterHeight;
    CGFloat reduce=self.frame.size.height-contentHeightWithOutFooter-64+6;
    if (reduce>=0) {
        self.tableFooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, reduce)];
    }else{
        self.tableFooterView=nil;
    }
}
@end
