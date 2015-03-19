//
//  SearchCategoryTableViewCell.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/19.
//
//

#import "SearchCategoryTableViewCell.h"

@implementation SearchCategoryTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.categoryName];
        [self.contentView addSubview:self.lineImageView];
    }
    return self;
}

-(UILabel *)categoryName{
    if(!_categoryName){
        _categoryName = [[UILabel alloc] initWithFrame:CGRectMake(20, 14, 280, 16)];
        _categoryName.font = [UIFont systemFontOfSize:16];
    }
    return _categoryName;
}

-(UIImageView *)lineImageView{
    if(!_lineImageView){
        _lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 43, 320, 1)];
        _lineImageView.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineImageView;
}

-(void)setCategoryNameStr:(NSString *)categoryNameStr{
    self.categoryName.text = categoryNameStr;
}
@end
