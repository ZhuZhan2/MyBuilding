//
//  AddFriendCell.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/9.
//
//

#import <UIKit/UIKit.h>

@interface AddFriendCell : UITableViewCell
@property(nonatomic,strong)UIImageView* userImageView;
@property(nonatomic,strong)UIButton* rightBtn;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier needRightBtn:(BOOL)needRightBtn;

-(void)setUserName:(NSString*)userName time:(NSString*)time userImageUrl:(NSString*)userImageUrl isFinished:(BOOL)isFinished indexPathRow:(NSInteger)indexPathRow status:(NSString *)status;
@end
