//
//  ContactProductView.h
//  ZhuZhan
//
//  Created by 孙元侃 on 14/12/23.
//
//

#import <UIKit/UIKit.h>
#import "HeadImageDelegate.h"
@interface ContactProductView : UIView
@property(nonatomic,weak)id<HeadImageDelegate>delegate;
@property(nonatomic,strong)NSIndexPath *indexpath;
-(instancetype)initWithUsrImgUrl:(NSString*)usrImgUrl productImgUrl:(NSString*)productImgUrl productContent:(NSString*)productContent;
@end
