//
//  ContractsUserView.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/4/15.
//
//

#import <UIKit/UIKit.h>

@interface ContractsUserView : UIView
+(ContractsUserView*)contractsUserViewWithUserName:(NSString*)userName userCategory:(NSString*)userCategory companyName:(NSString*)companyName remarkContent:(NSString*)remarkContent;
@end
