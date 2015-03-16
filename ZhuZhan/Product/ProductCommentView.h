//
//  ProductCommentView.h
//  ZhuZhan
//
//  Created by 孙元侃 on 14-9-3.
//
//

#import <UIKit/UIKit.h>
@interface ProductCommentView : UIView
-(instancetype)initWithCommentImageUrl:(NSString*)userImageUrl userName:(NSString*)userName commentContent:(NSString*)commentContent creatBy:(NSString *)creatBy;
@end
