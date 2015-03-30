//
//  BaseContractsView.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/30.
//
//

#import <UIKit/UIKit.h>

@protocol ContractsViewDelegate <NSObject>
-(void)contractsViewPDFImageViewBtnClicked;
-(void)contractsViewBtnClickedWithNumber:(NSInteger)number;
@end

@interface BaseContractsView : UIView
+(BaseContractsView*)contractsViewWithPDFImageName:(NSString*)PDFImageName btnImageNmaes:(NSArray*)imageNames delegate:(id<ContractsViewDelegate>)delegate size:(CGSize)size;
@end
