//
//  CatoryTableViewCell.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/21.
//
//

#import "CatoryTableViewCell.h"

@implementation CatoryTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.catoryLabel];
    }
    return self;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(26, 16, 180, 16)];
        _titleLabel.textColor = BlueColor;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.text = @"产品大类";
    }
    return _titleLabel;
}

-(UILabel *)catoryLabel{
    if(!_catoryLabel){
        _catoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(26, 42, 180, 16)];
        _catoryLabel.textAlignment = NSTextAlignmentLeft;
        _catoryLabel.font = [UIFont systemFontOfSize:16];
    }
    return _catoryLabel;
}

-(void)setCatoryStr:(NSString *)catoryStr{
    self.catoryLabel.text = catoryStr;
}
@end
