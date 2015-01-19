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
        companyLabel.font = [UIFont boldSystemFontOfSize:14];
        [view addSubview:companyLabel];
        
        height += companyLabel.frame.size.height;
    }
    
    NSLog(@"===>%@",model.a_isIn);
    if(![model.a_inDate isEqualToString:@""]||![model.a_outDate isEqualToString:@""]){
        UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 70, 180, 30)];
        if([model.a_isIn isEqualToString:@"1"]){
            dateLabel.text = [NSString stringWithFormat:@"(%@—目前)",model.a_inDate];
        }else{
            dateLabel.text = [NSString stringWithFormat:@"(%@—%@)",model.a_inDate,model.a_outDate];
        }
        dateLabel.font = [UIFont systemFontOfSize:12];
        dateLabel.textColor = GrayColor;
        [view addSubview:dateLabel];
        
        height += dateLabel.frame.size.height;
    }
    
    if(![model.a_information isEqualToString:@""]){
        NSString *string = [NSString stringWithFormat:@"个人简介：%@",model.a_information];
        UILabel* contentLabel = [[UILabel alloc] init];
        contentLabel.numberOfLines =0;
        contentLabel.font = [UIFont systemFontOfSize:12];
        contentLabel.text = string;
        CGSize size =CGSizeMake(260,1000);
        CGSize actualsize =[string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
        contentLabel.frame = CGRectMake(30, 100, 260, actualsize.height);
        [view addSubview:contentLabel];
        height += contentLabel.frame.size.height;
    }
    
    view.frame = CGRectMake(0, 0, 320, 50+height);
    return view;
}

@end
