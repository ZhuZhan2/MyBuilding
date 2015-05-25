//
//  BusinessSucessCreateController.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/5/25.
//
//

#import <UIKit/UIKit.h>

@protocol BusinessSucessCreateControllerDelegate <NSObject>
-(void)businessSucessCreateControllerLeftBtnClicked;
-(void)businessSucessCreateControllerRightBtnClicked;
@end

@interface BusinessSucessCreateController : UIViewController
@property (nonatomic, weak)id<BusinessSucessCreateControllerDelegate> delegate;
@end
