//
//  SearchContactTableViewCell.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/19.
//
//

#import "SearchContactTableViewCell.h"

@implementation SearchContactTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.companyName];
        [self.contentView addSubview:self.lineImageView];
    }
    return self;
}

-(UILabel *)companyName{
    if(!_companyName){
        _companyName = [[UILabel alloc] initWithFrame:CGRectMake(20, 14, 280, 16)];
        _companyName.font = [UIFont systemFontOfSize:16];
    }
    return _companyName;
}

-(UIImageView *)lineImageView{
    if(!_lineImageView){
        _lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 43, 320, 1)];
        _lineImageView.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineImageView;
}

-(void)setCompanyNameStr:(NSString *)companyNameStr{
    self.companyName.text = companyNameStr;
}
@end
