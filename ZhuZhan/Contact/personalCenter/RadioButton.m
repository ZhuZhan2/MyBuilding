//
//  RadioButton.m
//  MyRadioButton
//
//  Created by administrator on 14-6-12.
//  Copyright (c) 2014年 HHL. All rights reserved.
//

#import "RadioButton.h"

@interface RadioButton()

@end

@implementation RadioButton

@synthesize groupId=_groupId;
@synthesize index=_index;


static NSMutableArray *rb_instances=nil;
static NSMutableDictionary *rb_instancesDic=nil;  // 识别不同的组

#pragma mark - Manage Instances

-(void)registerInstance:(RadioButton*)radioButton withGroupID:(NSString *)aGroupID{
    
    if(!rb_instancesDic){
        rb_instancesDic = [[NSMutableDictionary alloc] initWithCapacity:16];
    }
    
    if ([rb_instancesDic objectForKey:aGroupID]) {
        [[rb_instancesDic objectForKey:aGroupID] addObject:radioButton];
        [rb_instancesDic setObject:[rb_instancesDic objectForKey:aGroupID] forKey:aGroupID];
        
        
    }else {
        NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:16];
        [arr addObject:radioButton];
        
        [rb_instancesDic setObject:arr forKey:aGroupID];
    }
    
}

#pragma mark - Class level handler

+(void)buttonSelected:(RadioButton*)radioButton{
    
    
    NSLog(@"mmm%@",radioButton.groupId);
    
    rb_instances = [rb_instancesDic objectForKey:radioButton.groupId];
    
    if (rb_instances) {
        for (int i = 0; i < [rb_instances count]; i++) {
            RadioButton *button = [rb_instances objectAtIndex:i];
            if (![button isEqual:radioButton]) {
                [RadioButton otherButtonSelected:button];
            }
        }
    }
}

#pragma mark - Object Lifecycle

-(id)initWithGroupId:(NSString*)groupId index:(NSUInteger)index WithTitle:(NSString *)title WithFrame:(CGRect)frame{
    
    
    RadioButton * button = [RadioButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.groupId = groupId;
    button.index = index;
    [button setImage:[UIImage imageNamed:@"RadioButton-Unselected"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"RadioButton-Selected"] forState:UIControlStateSelected];
    
    [self registerInstance:button withGroupID:groupId];
    NSLog(@"llll%@",button.groupId);
    [button addTarget:_delegate action:@selector(handleButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return button;
    
}

- (id)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}



#pragma mark - Tap handling

-(void)handleButtonTap:(RadioButton *)radioButton{
    [radioButton setSelected:YES];
    NSLog(@"llll%@",radioButton.groupId);
    [_delegate getStringFromRadioButtonSelected:radioButton.titleLabel.text];
    [RadioButton buttonSelected:radioButton];
}

+(void)otherButtonSelected:(RadioButton*)radioButton{
        // Called when other radio button instance got selected
    if(radioButton.selected){
        [radioButton setSelected:NO];
    }
}

@end
