//
//  ChooseContactsViewCell.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/9.
//
//

#import <UIKit/UIKit.h>

@interface ChooseContactsCellModel : NSObject
@property(nonatomic,copy)NSString* mainImageUrl;
@property(nonatomic,copy)NSString* mainLabelText;
@property(nonatomic)BOOL isHighlight;
@end

@protocol ChooseContactsViewCellDelegate <NSObject>
-(void)chooseAssistBtn:(UIButton*)btn indexPath:(NSIndexPath*)indexPath;
@end

@interface ChooseContactsViewCell : UITableViewCell
-(void)setModel:(ChooseContactsCellModel*)model indexPath:(NSIndexPath*)indexPath;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier delegate:(id<ChooseContactsViewCellDelegate>)delegate;
@end
