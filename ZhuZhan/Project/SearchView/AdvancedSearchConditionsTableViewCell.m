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
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 350)];
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
    keyWord.returnKeyType = UIReturnKeyDone;
    keyWord.clearButtonMode = UITextFieldViewModeAlways;
    [bgView addSubview:keyWord];
    
    companyName = [[UITextField alloc] initWithFrame:CGRectMake(15, 55, 290, 40)];
    companyName.delegate = self;
    companyName.placeholder = @"请输入相关公司名称";
    companyName.returnKeyType = UIReturnKeyDone;
    companyName.clearButtonMode = UITextFieldViewModeAlways;
    [bgView addSubview:companyName];
    
    districtBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [districtBtn setFrame:CGRectMake(15, 105, 50, 40)];
    [districtBtn setTitle:@"区域" forState:UIControlStateNormal];
    [districtBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    districtBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [districtBtn addTarget:self action:@selector(districtBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:districtBtn];
    
    provinceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [provinceBtn setFrame:CGRectMake(15, 155, 50, 40)];
    [provinceBtn setTitle:@"省份" forState:UIControlStateNormal];
    [provinceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    provinceBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [provinceBtn addTarget:self action:@selector(provinceBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:provinceBtn];
    
    projectStageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [projectStageBtn setFrame:CGRectMake(15, 205, 80, 40)];
    [projectStageBtn setTitle:@"项目阶段" forState:UIControlStateNormal];
    [projectStageBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    projectStageBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    projectStageBtn.tag = 0;
    [projectStageBtn addTarget:self action:@selector(projectStageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:projectStageBtn];
    
    projectCategoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [projectCategoryBtn setFrame:CGRectMake(15, 255, 80, 40)];
    [projectCategoryBtn setTitle:@"项目类别" forState:UIControlStateNormal];
    [projectCategoryBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    projectCategoryBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    projectCategoryBtn.tag = 1;
    [projectCategoryBtn addTarget:self action:@selector(projectCategoryBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:projectCategoryBtn];
}

-(void)searchClick{
    NSLog(@"searchClick");
}

-(void)districtBtnClick{
    NSLog(@"districtBtnClick");
}

-(void)provinceBtnClick{
    NSLog(@"provinceBtnClick");
}

-(void)projectStageBtnClick:(UIButton *)button{
    if([self.delegate respondsToSelector:@selector(multipleChose:)]){
        [self.delegate multipleChose:button.tag];
    }
}

-(void)projectCategoryBtnClick:(UIButton *)button{
    if([self.delegate respondsToSelector:@selector(multipleChose:)]){
        [self.delegate multipleChose:button.tag];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
@end
