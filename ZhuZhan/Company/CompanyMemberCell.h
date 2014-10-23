//
//  CompanyMemberCell.h
//  ZhuZhan
//
//  Created by 孙元侃 on 14/10/22.
//
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
@interface CompanyMemberCell : UITableViewCell
@property(nonatomic,strong)UIButton* rightBtn;
@property(nonatomic,strong)EGOImageView* userImageView;
@property(nonatomic,strong)UILabel* userNameLabel;
@property(nonatomic,strong)UILabel* userBussniessLabel;
-(void)setModelWithUserImageUrl:(NSString*)url userName:(NSString*)name userBussniess:(NSString*)bussniess btnImage:(UIImage*)image;
@end
