//
//  PublishRequirementCooperationView.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/8.
//
//

#import <UIKit/UIKit.h>
@protocol PublishRequirementCooperationViewDelegate <NSObject>
- (void)cooperationViewAreaBtnClicked;
@end

@interface PublishRequirementCooperationView : UIView
+ (PublishRequirementCooperationView*)cooperationView;
@property (nonatomic, copy)NSString* area;
@property (nonatomic, copy)NSString* requirementDescribe;
@property (nonatomic, weak)id<PublishRequirementCooperationViewDelegate> delegate;
@end