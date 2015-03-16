//
//  SearchBarCell.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/10.
//
//

#import <UIKit/UIKit.h>
@interface SearchBarCellModel : NSObject
@property(nonatomic,copy)NSString* mainImageUrl;
@property(nonatomic,copy)NSString* mainLabelText;
@property(nonatomic)BOOL isHighlight;
@end

@interface SearchBarCell : UITableViewCell
-(void)setModel:(SearchBarCellModel*)model;
@end
