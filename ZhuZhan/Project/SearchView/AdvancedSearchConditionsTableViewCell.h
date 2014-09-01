//
//  AdvancedSearchConditionsTableViewCell.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-28.
//
//

#import <UIKit/UIKit.h>
@protocol AdvancedSearchConditionsDelegate <NSObject>
-(void)multipleChose:(int)index;
-(void)setTextFieldStr:(NSString *)str index:(int)index;
-(void)startSearch;
@end
@interface AdvancedSearchConditionsTableViewCell : UITableViewCell<UITextFieldDelegate>{
    UITextField *keyWord;
    UITextField *companyName;
    UIButton *districtBtn;
    UIButton *provinceBtn;
    UIButton *projectStageBtn;
    UIButton *projectCategoryBtn;
    
    UILabel *districtLabel;
    UILabel *provinceLabel;
    UILabel *projectStageLabel;
    UILabel *projectCategoryLabel;
}
@property(nonatomic,weak)NSMutableDictionary *dic;
@property(nonatomic,weak)id<AdvancedSearchConditionsDelegate>delegate;
@end
