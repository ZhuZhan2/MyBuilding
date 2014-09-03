//
//  ProductDetailViewCell.h
//  ZhuZhan
//
//  Created by 孙元侃 on 14-9-3.
//
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"
@interface ProductDetailViewCell : UITableViewCell
+(ProductDetailViewCell*)dequeueReusableCellWithTableView:(UITableView*)tableView identifier:(NSString*)identifier comment:(CommentModel*)commentModel;
@end
