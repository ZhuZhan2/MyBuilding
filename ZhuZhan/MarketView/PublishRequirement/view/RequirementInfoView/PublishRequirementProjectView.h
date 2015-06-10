//
//  PublishRequirementProjectView.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/4.
//
//

#import <UIKit/UIKit.h>

@protocol PublishRequirementProjectViewDelegate <NSObject>
- (void)projectViewAreaBtnClicked;
@end

@interface PublishRequirementProjectView : UIView
+ (PublishRequirementProjectView*)projectView;
@property (nonatomic, copy)NSString* area;
@property (nonatomic, copy)NSString* minMoney;
@property (nonatomic, copy)NSString* maxMoney;
@property (nonatomic, copy)NSString* requirementDescribe;
@property (nonatomic, weak)id<PublishRequirementProjectViewDelegate> delegate;
@end
