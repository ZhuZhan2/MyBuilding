//
//  ChatTableViewCell.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/5.
//
//

#import <UIKit/UIKit.h>
#import "ChatModel.h"
@interface ChatTableViewCell : UITableViewCell
@property(nonatomic,strong)ChatModel* model;
+(CGFloat)carculateTotalHeightWithContentStr:(NSString*)contentStr isSelf:(BOOL)isSelf;
+(UILabel *)sendTimeLabel;
@end
