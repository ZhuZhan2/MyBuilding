//
//  DemandDetailViewCell.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/18.
//
//

#import <UIKit/UIKit.h>
#import "RKImageModel.h"
typedef enum DemandControllerCategory{
    DemandControllerCategoryAskPriceController,// 询价
    DemandControllerCategoryProvidePriceController//报价
}DemandControllerCategory;

@protocol DemandDetailViewCellDelegate <NSObject>
//-(void)leftBtnClickedWithIndexPath:(NSIndexPath*)indexPath;
//-(void)rightBtnClickedWithIndexPath:(NSIndexPath*)indexPath;
-(void)imageCilckWithDemandDetailViewCell:(RKImageModel *)model;
@end

@interface DemandDetailCellModel : NSObject
@property(nonatomic,copy)NSString* userName;
@property(nonatomic,copy)NSString* userDescribe;
@property(nonatomic,copy)NSString* time;
@property(nonatomic,copy)NSString* numberDescribe;
@property(nonatomic,copy)NSString* content;
@property(nonatomic)BOOL isHonesty;
@property(nonatomic,strong)NSArray* array1;
@property(nonatomic,strong)NSArray* array2;
@property(nonatomic,strong)NSArray* array3;

//@property(nonatomic)BOOL isFinish;
//@property(nonatomic,strong)NSIndexPath* indexPath;
@end

@interface DemandDetailViewCell : UITableViewCell
@property(nonatomic,strong)DemandDetailCellModel* model;
@property(nonatomic,weak)id<DemandDetailViewCellDelegate>delegate;
+(CGFloat)carculateTotalHeightWithModel:(DemandDetailCellModel*)model;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier delegate:(id<DemandDetailViewCellDelegate>)delegate category:(DemandControllerCategory)category;
@end
