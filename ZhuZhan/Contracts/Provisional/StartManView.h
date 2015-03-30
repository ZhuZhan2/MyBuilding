//
//  StartManView.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/30.
//
//

#import <UIKit/UIKit.h>

@interface StartManView : UIView
@property(nonatomic,strong)UILabel *titleLabel;
-(void)GetHeightWithBlock:(void (^)(double height))block str:(NSString *)str;
@end
