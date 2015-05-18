//
//  ChatImageCell.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/5/15.
//
//

#import "TableViewHeightCell.h"
#import "ChatMessageModel.h"
#import "ChatMessageImageView.h"

@interface ChatImageCell : TableViewHeightCell{
    CALayer      *_contentLayer;
    CAShapeLayer *_maskLayer;
}
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UIButton *userHeadBtn;
@property(nonatomic,strong)UILabel *userNameLabel;
@property(nonatomic,strong)ChatMessageImageView *chatMessageImageView;
@property(nonatomic,strong)UIImageView *messageImageView;
@property(nonatomic)CGFloat imageWidth;
@property(nonatomic)CGFloat imageHeight;
@property(nonatomic)BOOL isSelf;
@property(nonatomic,strong)ChatMessageModel *model;
@end
