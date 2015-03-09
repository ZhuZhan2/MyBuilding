//
//  AddressBookCell.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/9.
//
//

#import "AddressBookCell.h"
#import "AddressBookModel.h"
@implementation AddressBookCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addContent];
    }
    return self;
}

-(void)addContent{
    headImage = [[EGOImageView alloc]initWithFrame:CGRectMake(6, 5, 50, 50)];
    [self.contentView addSubview:headImage];
    
    nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 5, 200, 25)];
    nameLabel.backgroundColor  = [UIColor clearColor];
    nameLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:nameLabel];
    
    UIImageView *lineImage = [[UIImageView alloc]initWithFrame:CGRectMake(60, 59, 320-60, 1)];
    lineImage.backgroundColor = [UIColor blackColor];
    lineImage.alpha = 0.2;
    [self.contentView addSubview:lineImage];
}

-(void)setArray:(NSMutableArray *)array{
    [array enumerateObjectsUsingBlock:^(AddressBookContactModel* model, NSUInteger idx, BOOL *stop) {
        headImage.imageURL = [NSURL URLWithString:model.a_avatarUrl];
        nameLabel.text = model.a_contactName;
    }];
}
@end
