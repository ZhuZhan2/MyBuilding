//
//  PublishRequirementRelationView.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/8.
//
//

#import <UIKit/UIKit.h>
@protocol PublishRequirementRelationViewDelegate <NSObject>
- (void)relationViewAreaBtnClicked;
@end

@interface PublishRequirementRelationView : UIView
+ (PublishRequirementRelationView*)relationView;
@property (nonatomic, copy)NSString* area;
@property (nonatomic, copy)NSString* requirementDescribe;
@property (nonatomic, weak)id<PublishRequirementRelationViewDelegate> delegate;
@end
