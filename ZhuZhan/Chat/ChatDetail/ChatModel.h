//
//  ChatModel.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/5.
//
//

#import <Foundation/Foundation.h>

@interface ChatModel : NSObject
@property(nonatomic,copy)NSString* userImageStr;
@property(nonatomic,copy)NSString* userNameStr;
@property(nonatomic,copy)NSString* chatContent;
@property(nonatomic)BOOL isSelf;
@end
