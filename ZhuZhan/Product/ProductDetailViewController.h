//
//  ProductDetailViewController.h
//  ZhuZhan
//
//  Created by 孙元侃 on 14-9-3.
//
//

#import <UIKit/UIKit.h>

@interface ProductDetailViewController : UIViewController
-(instancetype)initWithImage:(UIImage*)productImage text:(NSString*)productText productID:(NSString*)productID;
@end
