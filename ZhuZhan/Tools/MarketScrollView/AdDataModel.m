

#import "AdDataModel.h"

#define PLISTFILENAME @"AdDataPlist.plist"

#define PATH  [[NSBundle mainBundle]pathForResource:PLISTFILENAME ofType:nil]

@implementation AdDataModel

- (instancetype)initWithImageName
{
    self = [super init];
    if (self)
    {
        _imageNameArray = [NSArray arrayWithContentsOfFile:PATH][0];
    }
    return self;
}

- (instancetype)initWithImageNameAndAdTitleArray
{
    _adTitleArray = [NSArray arrayWithContentsOfFile:PATH][1];
    
    return [self initWithImageName];
}

+ (id)adDataModelWithImageName
{
    return [[self alloc]initWithImageName];
}

+ (id)adDataModelWithImageNameAndAdTitleArray
{
    return [[self alloc]initWithImageNameAndAdTitleArray];
}
@end
