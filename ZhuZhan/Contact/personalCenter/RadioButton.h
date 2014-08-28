//
//  RadioButton.h
//  MyRadioButton
//
//  Created by administrator on 14-6-12.
//  Copyright (c) 2014年 HHL. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RadioButtonDelegate <NSObject>
-(void)getStringFromRadioButtonSelected:(NSString *)title;
@end

@interface RadioButton : UIButton {
    NSString *_groupId;
    NSUInteger _index;
    
}
@property(nonatomic,retain)NSString *groupId;
@property(nonatomic,assign)NSUInteger index;
@property (nonatomic,assign)id<RadioButtonDelegate> delegate;

-(id)initWithGroupId:(NSString*)groupId index:(NSUInteger)index WithTitle:(NSString *)title WithFrame:(CGRect)frame;

@end
