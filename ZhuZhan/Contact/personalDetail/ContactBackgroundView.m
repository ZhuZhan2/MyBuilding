//
//  ContactBackgroundView.m
//  ZhuZhan
//
//  Created by 汪洋 on 14/10/29.
//
//

#import "ContactBackgroundView.h"

@implementation ContactBackgroundView

+(ContactBackgroundView *)setFram:(ParticularsModel *)model{
    ContactBackgroundView *view = [[ContactBackgroundView alloc] init];
    UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    back.backgroundColor = [UIColor colorWithPatternImage:[GetImagePath getImagePath:@"grayColor"]];
    [view addSubview:back];
    
    UIImageView *topLineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 5)];
    [topLineImage setImage:[UIImage imageNamed:@"项目－高级搜索－2_15a"]];
    [view addSubview:topLineImage];
    
    UIImageView *imgaeView = [[UIImageView alloc] initWithFrame:CGRectMake(129, 8, 52, 34)];
    imgaeView.image = [GetImagePath getImagePath:@"人脉－人的详情_29a"];
    [view addSubview:imgaeView];
    
    CGFloat height=0;
    
    if(![model.a_company isEqualToString:@""]){
        UILabel *companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 50, 150, 30)];
        companyLabel.text = model.a_company;
        companyLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
        [view addSubview:companyLabel];
        
        height += companyLabel.frame.size.height;
    }
    
    view.frame = CGRectMake(0, 0, 320, 89+height);
    return view;
}

@end
