//
//  ContactCell.h
//  ZhuZhan
//
//  Created by Jack on 14-9-4.
//
//

#import <UIKit/UIKit.h>
#import "ContactModel.h"
#import "MyCenterModel.h"
@protocol  ContactCellDelegate<NSObject>

-(void)gotoCallEmail:(NSString *)email;
-(void)gotoCallPhone:(NSString *)phone;
@end

@interface ContactCell : UITableViewCell{
    UILabel *commonLabel1;
    UIButton *emailBtn;
    UIImageView *line;
    UIImageView *imageView;
    UILabel *commonLabel2;
    UIButton *cellPhoneBtn;
    UIImageView *imageView1;
    UILabel *commonLabel;
    UIView *back;
    UIImageView *topLineImage;
    UIImageView *topImgaeView;
}
@property(nonatomic,strong)MyCenterModel *model;
@property(nonatomic,strong)NSString *phone;
@property(nonatomic,strong)NSString *email;
@property (nonatomic ,weak) id<ContactCellDelegate> delegate;
@end
