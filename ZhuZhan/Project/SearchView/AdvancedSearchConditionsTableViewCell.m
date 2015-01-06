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
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 300)];
    [bgView setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:bgView];
    
    UIFont *font = [UIFont systemFontOfSize:14];
    
    for(int i=0;i<5;i++){
        UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(8.5, 50*(i+1), 303, 1)];
        [lineImage setImage:[GetImagePath getImagePath:@"项目－高级搜索－2_03a"]];
        [bgView addSubview:lineImage];
    }
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setFrame:CGRectMake(12.5, 255, 295, 40)];
    [searchBtn setBackgroundImage:[GetImagePath getImagePath:@"项目－高级搜索－2_11a"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:searchBtn];
    
    keyWord = [[UITextField alloc] initWithFrame:CGRectMake(15, 5, 290, 40)];
    keyWord.delegate = self;
    keyWord.placeholder = @"请输入项目关键词";
    keyWord.returnKeyType = UIReturnKeyDone;
    keyWord.clearButtonMode = UITextFieldViewModeAlways;
    keyWord.tag = 0;
    [bgView addSubview:keyWord];
    
    companyName = [[UITextField alloc] initWithFrame:CGRectMake(15, 55, 290, 40)];
    companyName.delegate = self;
    companyName.placeholder = @"请输入相关公司名称";
    companyName.returnKeyType = UIReturnKeyDone;
    companyName.clearButtonMode = UITextFieldViewModeAlways;
    companyName.tag = 1;
    [bgView addSubview:companyName];
    
    districtBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [districtBtn setFrame:CGRectMake(15, 105, 295, 40)];
    //[districtBtn setBackgroundColor:[UIColor yellowColor]];
    [districtBtn setTitle:@"所在城市" forState:UIControlStateNormal];
    districtBtn.tag = 2;
    [districtBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    districtBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [districtBtn addTarget:self action:@selector(districtBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:districtBtn];
    
    districtLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 105, 185, 40)];
    districtLabel.textAlignment = NSTextAlignmentRight;
    districtLabel.font = font;
    [bgView addSubview:districtLabel];
    
    UIImageView *arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(290,120, 8, 12.5)];
    [arrowImage setImage:[GetImagePath getImagePath:@"新建项目5_09"]];
    [self addSubview:arrowImage];
    
//    provinceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [provinceBtn setFrame:CGRectMake(15, 155, 295, 40)];
//    [provinceBtn setTitle:@"省份" forState:UIControlStateNormal];
//    provinceBtn.tag = 3;
//    [provinceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    provinceBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    [provinceBtn addTarget:self action:@selector(provinceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [bgView addSubview:provinceBtn];
//    
//    provinceLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 155, 185, 40)];
//    provinceLabel.textAlignment = NSTextAlignmentRight;
//    provinceLabel.font = font;
//    [bgView addSubview:provinceLabel];
//    
//    UIImageView *arrowImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(290,170, 8, 12.5)];
//    [arrowImage2 setImage:[GetImagePath getImagePath:@"新建项目5_09"]];
//    [self addSubview:arrowImage2];
    
    projectStageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [projectStageBtn setFrame:CGRectMake(15, 155, 295, 40)];
    [projectStageBtn setTitle:@"项目阶段" forState:UIControlStateNormal];
    [projectStageBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    projectStageBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    projectStageBtn.tag = 0;
    [projectStageBtn addTarget:self action:@selector(projectStageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:projectStageBtn];
    
    projectStageLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 155, 185, 40)];
    projectStageLabel.text = @"";
    projectStageLabel.numberOfLines = 2;
    projectStageLabel.font = font;
    projectStageLabel.textAlignment = NSTextAlignmentRight;
    [bgView addSubview:projectStageLabel];
    
    UIImageView *arrowImage3 = [[UIImageView alloc] initWithFrame:CGRectMake(290,170, 8, 12.5)];
    [arrowImage3 setImage:[GetImagePath getImagePath:@"新建项目5_09"]];
    [self addSubview:arrowImage3];
    
    projectCategoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [projectCategoryBtn setFrame:CGRectMake(15, 205, 295, 40)];
    [projectCategoryBtn setTitle:@"项目类别" forState:UIControlStateNormal];
    [projectCategoryBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    projectCategoryBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    projectCategoryBtn.tag = 1;
    [projectCategoryBtn addTarget:self action:@selector(projectCategoryBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:projectCategoryBtn];
    
    projectCategoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 205, 185, 40)];
    projectCategoryLabel.text = @"";
    projectCategoryLabel.numberOfLines = 2;
    projectCategoryLabel.font = font;
    projectCategoryLabel.textAlignment = NSTextAlignmentRight;
    [bgView addSubview:projectCategoryLabel];
    
    UIImageView *arrowImage4 = [[UIImageView alloc] initWithFrame:CGRectMake(290,220, 8, 12.5)];
    [arrowImage4 setImage:[GetImagePath getImagePath:@"新建项目5_09"]];
    [self addSubview:arrowImage4];
}

-(void)searchClick{
    NSLog(@"searchClick");
    [keyWord resignFirstResponder];
    [companyName resignFirstResponder];
    if([self.delegate respondsToSelector:@selector(startSearch)]){
        [self.delegate startSearch];
    }
}

-(void)districtBtnClick:(UIButton *)button{
    NSLog(@"districtBtnClick");
    [keyWord resignFirstResponder];
    [companyName resignFirstResponder];
    if([self.delegate respondsToSelector:@selector(multipleChose:)]){
        [self.delegate multipleChose:button.tag];
    }
}

//-(void)provinceBtnClick:(UIButton *)button{
//    NSLog(@"provinceBtnClick");
//    [keyWord resignFirstResponder];
//    [companyName resignFirstResponder];
//    if([self.delegate respondsToSelector:@selector(multipleChose:)]){
//        [self.delegate multipleChose:button.tag];
//    }
//}

-(void)projectStageBtnClick:(UIButton *)button{
    [keyWord resignFirstResponder];
    [companyName resignFirstResponder];
    if([self.delegate respondsToSelector:@selector(multipleChose:)]){
        [self.delegate multipleChose:button.tag];
    }
}

-(void)projectCategoryBtnClick:(UIButton *)button{
    [keyWord resignFirstResponder];
    [companyName resignFirstResponder];
    if([self.delegate respondsToSelector:@selector(multipleChose:)]){
        [self.delegate multipleChose:button.tag];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if([self.delegate respondsToSelector:@selector(setTextFieldStr:index:)]){
        [self.delegate setTextFieldStr:textField.text index:textField.tag];
    }
}

-(void)setDic:(NSMutableDictionary *)dic{
    if(![dic[@"landProvince"] isEqualToString:@""]){
        districtLabel.text = [NSString stringWithFormat:@"%@,%@,%@",dic[@"landProvince"],dic[@"landCity"],dic[@"landDistrict"]];
    }else{
        districtLabel.text = @"";
    }
    projectStageLabel.text = dic[@"projectStage"];
    projectCategoryLabel.text = dic[@"projectCategory"];
}
@end
