//
//  AddFriendCell.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/9.
//
//

#import <UIKit/UIKit.h>

@protocol AddFriendCellDelegate <NSObject>
-(void)headClick:(int)index;
@end

@interface AddFriendCell : UITableViewCell
@property(nonatomic,strong)UIButton* rightBtn;
@property(nonatomic,strong)UIButton *headBtn;
@property(nonatomic,weak)id<AddFriendCellDelegate>delegate;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier needRightBtn:(BOOL)needRightBtn;

-(void)setUserName:(NSString*)userName time:(NSString*)time userImageUrl:(NSString*)userImageUrl isFinished:(BOOL)isFinished indexPathRow:(NSInteger)indexPathRow status:(NSString *)status;
@end
