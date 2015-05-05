

#import <Foundation/Foundation.h>

@interface AdDataModel : NSObject

@property (retain,nonatomic,readonly) NSArray * imageNameArray;
@property (retain,nonatomic,readonly) NSArray * adTitleArray;

- (instancetype)initWithImageName;
- (instancetype)initWithImageNameAndAdTitleArray;
+ (id)adDataModelWithImageName;
+ (id)adDataModelWithImageNameAndAdTitleArray;
@end

