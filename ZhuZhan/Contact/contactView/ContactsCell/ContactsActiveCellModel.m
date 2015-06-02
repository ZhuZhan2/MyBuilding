//
//  ContactsActiveCellModel.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/1.
//
//

#import "ContactsActiveCellModel.h"

@implementation ContactsActiveCellModel
- (NSMutableArray *)commentArr{
    if (!_commentArr) {
        _commentArr = [NSMutableArray array];
    }
    return _commentArr;
}
@end
