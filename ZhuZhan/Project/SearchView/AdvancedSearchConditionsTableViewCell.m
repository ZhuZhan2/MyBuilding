//
//  AdvancedSearchConditionsTableViewCell.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-28.
//
//

#import "AdvancedSearchConditionsTableViewCell.h"

@implementation AdvancedSearchConditionsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setContent];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setContent{
    [self setBackgroundColor:[UIColor greenColor]];
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 350)];
    [bgView setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:bgView];
    
    for(int i=0;i<6;i++){
        UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 50*(i+1), 300, 1)];
        [lineImage setBackgroundColor:[UIColor grayColor]];
        [bgView addSubview:lineImage];
    }
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setFrame:CGRectMake(15, 305, 290, 40)];
    [searchBtn setBackgroundColor:[UIColor blueColor]];
    [searchBtn setTitle:@"搜  索" forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:searchBtn];
    
    keyWord = [[UITextField alloc] initWithFrame:CGRectMake(15, 5, 290, 40)];
    keyWord.delegate = self;
    keyWord.placeholder = @"请输入项目关键词";
    [bgView addSubview:keyWord];
}

-(void)searchClick{
    NSLog(@"searchClick");
}
@end
