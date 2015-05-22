//
//  MyFocusProductCellModel.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/5/22.
//
//

#import <Foundation/Foundation.h>
#import "RKBtnStatusEnum.h"

@interface MyFocusProductCellModel : NSObject
@property(nonatomic,copy)NSString* mainImageUrl;
@property(nonatomic,copy)NSString* title;
@property(nonatomic,copy)NSString* content;
@property(nonatomic)RKBtnStatusEnum status;
@end
