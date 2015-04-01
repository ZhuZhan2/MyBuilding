//
//  AskPriceCellHeader.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/17.
//
//

#import <UIKit/UIKit.h>

typedef enum  AskPriceCellHeaderStageMode{
    AskPriceCellHeaderStageDoing,
    AskPriceCellHeaderStageDone,
    AskPriceCellHeaderStageClosed
} AskPriceCellHeaderStageMode;
@interface AskPriceCellHeader : UIView
+(AskPriceCellHeader*)askPriceCellHeader;
-(void)changeStageName:(NSString*)stageName code:(NSString *)code stageColor:(UIColor*)stageColor codeColor:(UIColor*)codeColor;
@end
