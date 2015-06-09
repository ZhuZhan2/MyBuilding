//
//  MarkListTableViewCell.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/6/4.
//
//

#import "MarkListTableViewCell.h"
#import "MarketModel.h"
@implementation MarkListTableViewCell

+ (CGFloat)carculateCellHeightWithModel:(MarketModel *)cellModel{
    CGFloat height = 0;
    height += [MarketListTitleView titleViewHeight]+20;
    return height;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.titleView];
    }
    return self;
}

-(MarketListTitleView *)titleView{
    if(!_titleView){
        _titleView = [[MarketListTitleView alloc] init];
    }
    return _titleView;
}

-(void)setMarketModel:(MarketModel *)marketModel{
    [self.titleView setImageUrl:marketModel.a_avatarUrl title:marketModel.a_loginName type:marketModel.a_reqTypeCn time:marketModel.a_createdTime needRound:marketModel.a_needRound];
}
@end
