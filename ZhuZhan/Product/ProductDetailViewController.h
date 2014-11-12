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

@interface ProductDetailViewController : UIViewController<UIActionSheetDelegate>
@property(nonatomic,weak)id<ProductDetailDelegate>delegate;
@property(nonatomic,strong)NSString *type;//判断入口类型；
-(instancetype)initWithProductModel:(ProductModel*)productModel;
-(instancetype)initWithActivesModel:(ActivesModel*)activesModel;
-(instancetype)initWithPersonalCenterModel:(PersonalCenterModel*)personalModel;
@end
