//
//  SaveConditionsViewController.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-1.
//
//

#import <UIKit/UIKit.h>

@protocol SaveConditionsViewDelegate <NSObject>

-(void)backView;
@end

@interface SaveConditionsViewController : UIViewController<UITextFieldDelegate>{
    UITextField *nameTextField;
    NSString *string;
}
@property(nonatomic,weak)id<SaveConditionsViewDelegate>delegate;
@property(nonatomic,weak)NSMutableDictionary *dataDic;
@end
