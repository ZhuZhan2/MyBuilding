//
//  ContactEGOView.h
//  ZhuZhan
//
//  Created by 孙元侃 on 14/12/24.
//
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@interface ContactEGOView : UIView
@property(nonatomic,strong)EGOImageView* myImageView;
-(void)observeImage;
@end
