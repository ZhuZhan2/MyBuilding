//
//  PublishRequirementMaterialView.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/8.
//
//

#import <UIKit/UIKit.h>

@interface PublishRequirementMaterialView : UIView
+ (PublishRequirementMaterialView*)materialView;
@property (nonatomic, copy)NSString* bigCategory;
@property (nonatomic, copy)NSString* smallCategory;
@property (nonatomic, copy)NSString* requirementDescribe;
@end
