//
//  AddContactView.h
//  交易辅助流程demo
//
//  Created by 汪洋 on 15/3/17.
//  Copyright (c) 2015年 wy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddContactViewDelegate <NSObject>
-(void)addContent;
-(void)closeContent:(NSInteger)index;
@end

@interface AddContactView : UIView
@property(nonatomic,strong)UILabel *fixationLabel;//参与用户label
@property(nonatomic,strong)UILabel *lastlabel;
@property(nonatomic,strong)UIView *addView;
@property(nonatomic,weak)id<AddContactViewDelegate>delegate;
-(void)GetHeightWithBlock:(void (^)(double height))block labelArr:(NSMutableArray *)labelArr;
@end
