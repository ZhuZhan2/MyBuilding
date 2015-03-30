//
//  RKMuchBtnAssistView.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/30.
//
//

#import <UIKit/UIKit.h>

@interface RKMuchBtnAssistView : UIView
+(RKMuchBtnAssistView*)muchBtnAssistViewWithMaxStageCount:(NSInteger)maxStageCount size:(CGSize)size;
-(void)setContent:(NSString*)content stageNumber:(NSInteger)stageNumber;
@end
