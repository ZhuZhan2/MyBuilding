//
//  Pan.h
//  ZhuZhan
//
//  Created by Jack on 14-8-27.
//
//

#import <UIKit/UIKit.h>

@protocol PanDelegate <NSObject>

- (void)goToDetail;
- (void)gotoConcern;

@end
@interface Pan : UIView<PanDelegate>

@property (nonatomic,assign) id<PanDelegate> delegate;

@end
