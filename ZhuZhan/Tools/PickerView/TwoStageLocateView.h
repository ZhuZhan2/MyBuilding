//
//  TwoStageLocateView.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/6/9.
//
//

#import <UIKit/UIKit.h>

@interface TwoStageLocateView : UIActionSheet
<UIPickerViewDelegate, UIPickerViewDataSource>{
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
-(void)cancelClick;
@end
