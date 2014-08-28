//
//  LocateView.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-25.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocateView : UIActionSheet<UIPickerViewDelegate, UIPickerViewDataSource>{
    UIPickerView *pickerview;
}
@property (nonatomic,retain) UIPickerView *pickerview;
@property (nonatomic, strong) NSMutableArray *allCityArray;
@property (nonatomic, strong) NSMutableArray *cityArray;
@property (nonatomic, strong) NSMutableArray *thirdArray;
@property (nonatomic, strong) NSMutableArray *lastChoose;
@property (nonatomic, strong) NSMutableDictionary *proviceDictionary;
- (id)initWithTitle:(CGRect)frame title:(NSString *)title delegate:(id /*<UIActionSheetDelegate>*/)delegate;
- (void)showInView:(UIView *)view;
@end
