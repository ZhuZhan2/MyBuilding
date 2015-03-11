//
//  ProductPublishController.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/2.
//
//

#import <UIKit/UIKit.h>

@protocol ProductPublishControllerDelegate <NSObject>

-(void)successAddProduct;

@end
@interface ProductPublishController : UIViewController
@property(nonatomic,weak)id<ProductPublishControllerDelegate>delegate;
@end
