//
//  AddCategoriesView.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/18.
//
//

#import <UIKit/UIKit.h>

@interface AddCategoriesView : UIView
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *cateroryLabel;
@property(nonatomic,strong)UIImageView *cutLine;
@property(nonatomic,strong)UIImageView *arrowImageView;
-(void)GetHeightWithBlock:(void (^)(double height))block str:(NSString *)str;
@end
