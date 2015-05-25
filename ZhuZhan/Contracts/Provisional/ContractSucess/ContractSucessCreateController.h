//
//  ContractSucessCreateController.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/5/25.
//
//

#import <UIKit/UIKit.h>

@protocol ContractSucessCreateControllerDelegate <NSObject>
-(void)contractSucessCreateControllerLeftBtnClicked;
-(void)contractSucessCreateControllerRightBtnClicked;
@end

@interface ContractSucessCreateController : UIViewController
@property (nonatomic, weak)id<ContractSucessCreateControllerDelegate> delegate;
@end
