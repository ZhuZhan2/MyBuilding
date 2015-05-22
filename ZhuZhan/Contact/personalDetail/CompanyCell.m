//
//  CompanyCell.m
//  ZhuZhan
//
//  Created by Jack on 14-9-4.
//
//

#import "CompanyCell.h"

@implementation CompanyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.statusLabel];
    }
    return self;
}

-(UILabel *)nameLabel{
    if(!_nameLabel){
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 260, 30)];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = [UIFont boldSystemFontOfSize:16];
    }
    return _nameLabel;
}

-(UILabel *)statusLabel{
    if(!_statusLabel){
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 20, 150, 30)];
        _statusLabel.textAlignment = NSTextAlignmentLeft;
        _statusLabel.textColor = AllLightGrayColor;
        _statusLabel.font = [UIFont systemFontOfSize:14];
    }
    return _statusLabel;
}
@end
