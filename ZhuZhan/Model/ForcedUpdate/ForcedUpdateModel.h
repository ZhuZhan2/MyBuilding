//
//  ForcedUpdateModel.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/8.
//
//

#import <Foundation/Foundation.h>

@interface ForcedUpdateModel : NSObject
@property (nonatomic, copy)NSString* a_createdTime;
@property (nonatomic, copy)NSString* a_createdUser;
@property (nonatomic, copy)NSString* a_deviceId;
@property (nonatomic, copy)NSString* a_deviceType;
@property (nonatomic, copy)NSString* a_downloadType;
@property (nonatomic, copy)NSString* a_downloadUrl;
@property (nonatomic, copy)NSString* a_forceUpdate;
@property (nonatomic, copy)NSString* a_releaseId;
@property (nonatomic, copy)NSString* a_releaseLog;
@property (nonatomic, copy)NSString* a_releaseSize;
@property (nonatomic, copy)NSString* a_releaseVersion;
@property (nonatomic, copy)NSString* a_updatedTime;
@property (nonatomic, copy)NSString* a_updatedUser;
@property (nonatomic, strong)NSDictionary* dict;
@end
