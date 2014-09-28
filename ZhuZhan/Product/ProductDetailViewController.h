//
//  ProductDetailViewController.h
//  ZhuZhan
//
//  Created by 孙元侃 on 14-9-3.
//
//

#import <UIKit/UIKit.h>
#import "ProductModel.h"
#import "ActivesModel.h"
#import "PersonalCenterModel.h"
@protocol ProductDetailDelegate <NSObject>
-(void)finishAddCommentFromDetailWithPosts:(NSMutableArray*)posts;
@end

@interface ProductDetailViewController : UIViewController
@property(nonatomic,strong)id<ProductDetailDelegate>delegate;
-(instancetype)initWithProductModel:(ProductModel*)productModel;
-(instancetype)initWithActivesModel:(ActivesModel*)activesModel;
-(instancetype)initWithPersonalCenterModel:(PersonalCenterModel*)personalModel;
@end
