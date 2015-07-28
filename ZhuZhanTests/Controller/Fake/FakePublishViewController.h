//
//  FakePublishViewController.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/7/27.
//
//

#import "PublishViewController.h"

@interface FakePublishViewController : PublishViewController
-(BOOL)isAllSpace:(NSString*)content;
@property(nonatomic,strong)NSData *imageData;
- (void)clearAll;
@end
