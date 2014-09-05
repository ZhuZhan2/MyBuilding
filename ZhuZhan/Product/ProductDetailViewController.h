//
//  ProductDetailViewController.h
//  ZhuZhan
//
//  Created by 孙元侃 on 14-9-3.
//
//

#import <UIKit/UIKit.h>

@interface ProductDetailViewController : UIViewController
-(instancetype)initWithImage:(UIImage*)productImage text:(NSString*)productText comments:(NSMutableArray*)comments;
@property(nonatomic,copy)NSString* a_id;
@end
