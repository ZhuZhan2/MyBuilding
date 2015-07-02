//
//  ChatMessageImageView.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/5/18.
//
//

#import <UIKit/UIKit.h>


@interface ChatMessageImageView : UIImageView
@property(nonatomic)BOOL isSelf;
@property(nonatomic,strong)NSString *bigImageUrl;
@property(nonatomic,strong)UIImage *bigLocalImage;
@property(nonatomic,strong)NSString *imageId;
@property(nonatomic)BOOL isLocal;
@property (nonatomic, copy)NSString* messageId;
- (instancetype)initWithFrame:(CGRect)frame isSelf:(BOOL)isSelf;
@end
