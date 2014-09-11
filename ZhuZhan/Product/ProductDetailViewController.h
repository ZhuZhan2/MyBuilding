//
//  ProductDetailViewController.h
//  ZhuZhan
//
//  Created by 孙元侃 on 14-9-3.
//
//

#import <UIKit/UIKit.h>
#import "ProductModel.h"
@interface ProductDetailViewController : UIViewController
-(instancetype)initWithProductModel:(ProductModel*)productModel text:(NSString*)productText productID:(NSString*)productID;
@end
