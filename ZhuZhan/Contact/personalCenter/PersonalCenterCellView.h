//
//  PersonalCenterCellView.h
//  ZhuZhan
//
//  Created by 孙元侃 on 14-9-28.
//
//

#import <UIKit/UIKit.h>

@interface PersonalCenterCellView : UIView
+(UIView*)getPersonalCenterCellViewWithImageUrl:(NSString*)imageUrl content:(NSString*)content category:(NSString*)category name:(NSString *)name;
@end
