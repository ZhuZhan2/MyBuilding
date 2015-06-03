//
//  CommentModel.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/1.
//
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject
@property (nonatomic, copy)NSString* userImageUrl;
@property (nonatomic)BOOL needRound;
@property (nonatomic, copy)NSString* userName;
@property (nonatomic, copy)NSString* actionTime;
@property (nonatomic, copy)NSString* content;

@property (nonatomic, strong)NSIndexPath* indexPath;
@end
