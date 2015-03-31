//
//  AskPriceCellHeader.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/17.
//
//

#import <UIKit/UIKit.h>

@interface AskPriceCellHeaderModel : NSObject
@property(nonatomic,copy)NSString* stage;
//@property(nonatomic)BOOL hasNew;
@property(nonatomic,copy)NSString* number;
@end

typedef enum  AskPriceCellHeaderStageMode{
    AskPriceCellHeaderStageDoing,
    AskPriceCellHeaderStageDone,
    AskPriceCellHeaderStageClosed
} AskPriceCellHeaderStageMode;
@interface AskPriceCellHeader : UIView
+(AskPriceCellHeader*)askPriceCellHeaderWithModel:(AskPriceCellHeaderModel*)model;
-(void)changeStageName:(NSString*)stageName code:(NSString *)code stageColor:(UIColor*)stageColor codeColor:(UIColor*)codeColor;
@end
