//
//  LocalProjectModel.h
//  ZhuZhan
//
//  Created by 汪洋 on 14/12/9.
//
//

#import <Foundation/Foundation.h>

@interface LocalProjectModel : NSObject
@property (nonatomic,strong) NSString *a_projectId;
@property (nonatomic,strong) NSString *a_time;
-(void)loadWithDictionary:(NSDictionary*)dic;
-(void)loadWithDB:(NSDictionary*)dic;
@end
