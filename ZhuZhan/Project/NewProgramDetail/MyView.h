//
//  MyView.h
//  ZhuZhan
//
//  Created by 孙元侃 on 14-9-1.
//
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
@interface MyView : UIView
@property(nonatomic,strong)EGOImageView* myImageView;
-(void)observeImage;
@end
